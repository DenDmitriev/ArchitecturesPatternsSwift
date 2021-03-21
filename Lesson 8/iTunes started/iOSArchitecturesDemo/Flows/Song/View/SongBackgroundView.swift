//
//  SongBackgroundView.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 19.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SongBackgroundView: UIView {
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.25
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        backgroundColor = .clear
        
        self.addSubview(imageView)
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        //blurredEffectView.frame = imageView.bounds
        self.addSubview(blurredEffectView)
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            blurredEffectView.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            blurredEffectView.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            blurredEffectView.topAnchor.constraint(equalTo: imageView.topAnchor),
            blurredEffectView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }
}

