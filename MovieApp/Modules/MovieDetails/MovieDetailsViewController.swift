//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Mariam Abdelhamid on 11/16/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    // MARK: - Helper variables
    var movie: ModelTVShow?
    
    // MARK: - Outlets
    @IBOutlet weak var selectedMoviePhoto: UIImageView!
    
    @IBOutlet weak var movieDescriptionLbl: UILabel!
   
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setData()
    }
    
    
   // MARK: - Helper Method To Set Data

    func setData(){
        movieDescriptionLbl.text = movie?.overview
        
        
        
        let url = URL(string: "http://image.tmdb.org/t/p/w500/\(movie?.posterPath ?? "")")
        selectedMoviePhoto.kf.setImage(with: url)
    }
   // MARK: - Actions
    @IBAction func backActionBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
