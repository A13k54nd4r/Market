//
//  ImageCollectionViewCell.swift
//  Market
//
//  Created by Aleksandar Savić on 12.06.20.
//  Copyright © 2020 Aleksandar Savić. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func setupImageWith(itemImage: UIImage) {
        imageView.image = itemImage
    }
}
