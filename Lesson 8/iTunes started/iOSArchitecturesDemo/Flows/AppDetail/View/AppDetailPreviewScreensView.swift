//
//  AppDetailPreviewScreensView.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 17.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailPreviewScreensView: UIView {
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 1
        label.text = "Предпросмотр"
        //label.backgroundColor = .brown
        return label
    }()
    
    private(set) lazy var previewCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        return collectionView
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
        
        self.addSubview(titleLabel)
        self.addSubview(previewCollectionView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            previewCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            previewCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            previewCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            previewCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            //add height constraint after download first image
        ])
    }
}
