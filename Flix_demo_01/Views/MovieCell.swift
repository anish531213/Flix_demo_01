//
//  MovieCell.swift
//  Flix_demo_01
//
//  Created by Anish Adhikari on 1/20/18.
//  Copyright © 2018 Anish Adhikari. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: Movie! {
        didSet {
            overviewLabel.text = movie.overview
            titleLabel.text = movie.title
            if movie.posterUrl != nil {
                posterImageView.af_setImage(withURL: movie.posterUrl!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
