//
//  CoreDataManager.swift
//  MovieApp
//
//  Created by Mariam Abdelhamid on 11/17/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import Foundation
import CoreData
import UIKit

//CoreData Singleton
class CoreDataManager {

    //1
    static let sharedManager = CoreDataManager()
    //2.
    private init() {} // Prevent clients from creating another instance.

    //3
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MovieApp")
        
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    //4
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
        
    //----------------------------------------------------------------------
     //Movie Operations
    func saveToDB(m : ModelTVShow ) {
        print("from save to db movie is \(m.name ?? "")")
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "MovieEntity",
                                                in: managedContext)!
        
        let movie = NSManagedObject(entity: entity,
                                            insertInto: managedContext)

        movie.setValue(m.id , forKey: "id")
        movie.setValue(m.name , forKey: "name")
        movie.setValue(m.originalName , forKey: "originalName")
        movie.setValue(m.overview , forKey: "overview")
        movie.setValue(m.voteAverage , forKey: "voteAverage")
        movie.setValue(m.posterPath , forKey: "posterPath")
        

        do{
            //5
            try managedContext
                .save()
        }catch let err{
            print(err)
        }
        
    }
    
    
    func fetchMovies(completion:@escaping (_ item:[MovieEntity]?)->Void){
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "MovieEntity")
        
        
        do
        {
            
            let fetchResult = try managedContext.fetch(fetchRequest)
            
            completion(fetchResult as? [MovieEntity])
            
            
        }
        catch
        {
            print(error)
            completion(nil)
        }
        
    }
}
