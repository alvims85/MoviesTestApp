//
//  MovieCollectionViewCell.swift
//  GrabilityTestiOS
//
//  Created by Alvaro Mendoza on 1/15/20.
//  Copyright © 2020 Alvaro. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    public var movie:Movie! = nil
    
    func configure(for movie: Movie) {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
         if movie.poster_path != nil {
             let url = URL(string: MoviesAPI.baseImageURLString + movie.poster_path!)!
             posterImage.af_setImage(withURL: url)
         }
         nameLabel.text = movie.title
         self.movie = movie
     }
     
     override func prepareForReuse() {
         super.prepareForReuse()
         posterImage.af_cancelImageRequest()
         posterImage.image = nil
     }
}
