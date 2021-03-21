//
//  SongTitleView.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 19.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SongTitleView: UIView {
    private(set) lazy var trackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
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
        
        backgroundColor = .clear
        
        self.addSubview(artistLabel)
        self.addSubview(trackLabel)
        
        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            artistLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            artistLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
        
            trackLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 8),
            trackLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            trackLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            trackLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

