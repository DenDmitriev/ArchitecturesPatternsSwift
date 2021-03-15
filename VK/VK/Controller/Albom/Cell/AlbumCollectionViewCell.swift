//
//  AlbumCollectionViewCell.swift
//  VK
//
//  Created by Denis Dmitriev on 08.02.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func style() {
        thumbImageView.layer.masksToBounds = true
        thumbImageView.layer.cornerRadius = 8
    }
    
    func set(album: Album) {
        self.titleLabel.text = (album.title ?? "") + " (\(String(describing: album.size)))"
        style()
    }

}
