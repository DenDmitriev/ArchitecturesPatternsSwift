//
//  SongCoverView.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 18.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SongCoverView: UIView {
    
    private(set) lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private(set) lazy var trackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private(set) lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        self.backgroundColor = .clear
        
        self.addSubview(coverImageView)
        self.addSubview(trackLabel)
        self.addSubview(artistLabel)
        
        NSLayoutConstraint.activate([
//            coverImageView.widthAnchor.constraint(equalToConstant: 100),
//            coverImageView.heightAnchor.constraint(equalTo: coverImageView.widthAnchor),
//            coverImageView.topAnchor.constraint(equalTo: topAnchor, constant: 36),
//            coverImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.leftAnchor.constraint(equalTo: leftAnchor),
            coverImageView.rightAnchor.constraint(equalTo: rightAnchor),
            coverImageView.heightAnchor.constraint(equalTo: coverImageView.widthAnchor),
            
            artistLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 16),
            artistLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            trackLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 12),
            trackLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }
    
}
