//
//  PhotosMiniCollectionViewCell.swift
//  VK
//
//  Created by Denis Dmitriev on 13.07.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import UIKit

class PhotosMiniCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imagePhotoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imagePhotoView.layer.masksToBounds = true
        imagePhotoView.layer.cornerRadius = 0
    }
    

}
