//
//  TvCollectionViewCell.swift
//  GrabilityTestiOS
//
//  Created by Alvaro Mendoza on 1/21/20.
//  Copyright © 2020 Alvaro. All rights reserved.
//

import UIKit
import AlamofireImage

class TvCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    public var tvSerie:TvSerie! = nil
    
    func configure(for tvSerie: TvSerie) {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
         if tvSerie.posterPath != nil {
             let url = URL(string: MoviesAPI.baseImageURLString + tvSerie.posterPath!)!
             posterImage.af_setImage(withURL: url)
         }
         nameLabel.text = tvSerie.originalName
         self.tvSerie = tvSerie
     }
     
     override func prepareForReuse() {
         super.prepareForReuse()
         posterImage.af_cancelImageRequest()
         posterImage.image = nil
     }
}
