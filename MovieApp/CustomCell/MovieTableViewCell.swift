//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Mariam Abdelhamid on 11/16/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var moviePhoto: UIImageView!
    @IBOutlet weak var movieOrginalTitleLbl: UILabel!
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var averageRateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(obj: ModelTVShow){
        movieOrginalTitleLbl.text = obj.originalName
        movieTitleLbl.text = obj.name
        let url = URL(string: "http://image.tmdb.org/t/p/w500/\(obj.posterPath ?? "")")
               moviePhoto.kf.setImage(with: url)
        averageRateLbl.text = "\(obj.voteAverage ?? 0.0)"
    }
}
