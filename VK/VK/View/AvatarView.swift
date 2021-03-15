//
//  ViewAvatar.swift
//  1l_ДмитриевДенис
//
//  Created by Denis Dmitriev on 25.06.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import UIKit

@IBDesignable class  AvatarView: UIView {
    
    @IBInspectable var image: UIImage? = nil {
        didSet {
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width/2
    }
    
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    func setup() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
        ])
    }
    
}

