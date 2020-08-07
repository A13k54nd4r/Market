//
//  CategoryCollectionViewCell.swift
//  Market
//
//  Created by Aleksandar Savić on 09.05.20.
//  Copyright © 2020 Aleksandar Savić. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func generateCell(_ category: Category) {
        nameLabel.text = category.name
        imageView.image = category.image
    }
    
}
