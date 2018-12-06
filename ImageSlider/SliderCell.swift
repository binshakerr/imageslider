//
//  SliderCell.swift
//  ImageSlider
//
//  Created by Eslam Shaker  on 12/6/18.
//  Copyright © 2018 Eslam Shaker . All rights reserved.
//

import UIKit

class SliderCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage! {
        didSet {
            imageView.image = image
        }
    }
    
    
}
