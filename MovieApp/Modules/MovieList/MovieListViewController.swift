//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Mariam Abdelhamid on 11/16/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import UIKit
import CoreData

class MovieListViewController: UIViewController {
    
    // MARK: - Helper variables
    
    // get instance of VM
    var viewModel: MovieListViewModel? {
        didSet {
            fillUI()
        }
    }
    
    
    // MARK: - Outlets
    @IBOutlet weak var movieTableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        viewModel = MovieListViewModelImp()
        
        viewModel?.getMovieList()
        

        movieTableView.addInfiniteScroll { (tableView) -> Void in
            // update table view

            self.viewModel?.getMovieList()

            // finish infinite scroll animation

        }

        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        movieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    
    // MARK: - Actions
    
    
    
}


extension MovieListViewController {
    
    func fillUI() {
        
        if !isViewLoaded {
            return
        }
        
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.updatedModelTVList.bind {
            
            if $0 {
                self.movieTableView.reloadData()
                self.movieTableView.finishInfiniteScroll()
                CoreDataManager.sharedManager.saveToDB(m: viewModel.movieList[0])
            } else {
                // to show the error
                if viewModel.errorDescription != "" {
                    print(viewModel.errorDescription ?? "")
                }
            }
        }
    }
}

// MARK: - Confirm TableView Protocols
extension MovieListViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.movieList.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath ) as! MovieTableViewCell
        
        
        
        cell.setCell(obj: (viewModel?.movieList[indexPath.row])!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        movieTableView.deselectRow(at: indexPath, animated: false)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController
        
        vc?.movie = viewModel?.movieList[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
