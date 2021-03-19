//
//  SongCell.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 18.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class SongCell: UITableViewCell {
    
    private let imageDownloader = ImageDownloader()
    
    // MARK: - Subviews
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        //label.backgroundColor = .darkGray
        return label
    }()
    
    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13.0)
        //label.backgroundColor = .darkGray
        return label
    }()
    
    private(set) lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - Methods
    
    func configure(with cellModel: SongCellModel) {
        downloadImage(for: cellModel.artwork)
        self.titleLabel.text = cellModel.trackName
        self.subtitleLabel.text = cellModel.artistName
        
    }
    
    // MARK: - UI
    
    override func prepareForReuse() {
        [self.titleLabel, self.subtitleLabel].forEach { $0.text = nil }
        self.coverImageView.image = nil
    }
    
    private func configureUI() {
        
        let labelsStackView = createStackView(with: [UIView(), self.titleLabel, self.subtitleLabel, UIView()], axis: .vertical, space: 4, alignment: .leading, distribution: .fillProportionally)
        let cellStackView = createStackView(with: [self.coverImageView, labelsStackView], axis: .horizontal, space: 12, alignment: .fill, distribution: .fill)
        
        self.contentView.addSubview(cellStackView)
        
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4),
            cellStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            cellStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            cellStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4),
            
            self.coverImageView.widthAnchor.constraint(equalTo: self.coverImageView.heightAnchor)
        ])
    }
    
    //MARK: - Private Methods
    
    private func createStackView(with subviews: [UIView], axis: NSLayoutConstraint.Axis = .horizontal, space: CGFloat = 12, alignment: UIStackView.Alignment = .center, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.alignment = alignment
        stackView.spacing = space
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func downloadImage(for url: String?) {
        guard let url = url else { return }
        
        self.imageDownloader.getImage(fromUrl: url) { [weak self] (image, error) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.coverImageView.image = image
            }
        }
    }
}
