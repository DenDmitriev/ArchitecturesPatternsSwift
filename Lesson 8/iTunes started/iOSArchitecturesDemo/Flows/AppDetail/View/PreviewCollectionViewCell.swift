//
//  PreviewCollectionViewCell.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 17.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class PreviewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PreviewCell"
    
    private(set) lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6.0
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    
    private func configureUI() {
        backgroundColor = .clear
        
        self.addSubview(previewImageView)
        
        NSLayoutConstraint.activate([
            previewImageView.topAnchor.constraint(equalTo: topAnchor),
            previewImageView.leftAnchor.constraint(equalTo: leftAnchor),
            previewImageView.rightAnchor.constraint(equalTo: rightAnchor),
            previewImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
