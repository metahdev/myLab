//
//  ImageCollectionViewCell.swift
//  myLab
//
//  Created by Metah on 10/31/20.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    // MARK:- Properties
    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var imageName = "" {
        didSet {
            imageView.image = UIImage(named: imageName)
        }
    }
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
}
