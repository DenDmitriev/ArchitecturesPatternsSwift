//
//  AppDetailReleaseNotesView.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 17.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailReleaseNotesView: UIView {
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 1
        label.text = "Что нового"
        return label
    }()
    
    private(set) lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.numberOfLines = 1
        label.text = "Версия "
        return label
    }()
    
    private(set) lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.numberOfLines = 1
        return label
    }()
    
    private(set) lazy var releaseNotesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var historyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("История версий", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        return button
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
        
        let stackViewTitleWithHistory = createStackView(with: [titleLabel, historyButton])
        self.addSubview(stackViewTitleWithHistory)
        
        let stackViewVersionWithDate = createStackView(with: [versionLabel, releaseDateLabel])
        self.addSubview(stackViewVersionWithDate)
        
        self.addSubview(releaseNotesLabel)
        
        NSLayoutConstraint.activate([
            stackViewTitleWithHistory.topAnchor.constraint(equalTo: topAnchor),
            stackViewTitleWithHistory.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackViewTitleWithHistory.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            stackViewVersionWithDate.topAnchor.constraint(equalTo: stackViewTitleWithHistory.bottomAnchor, constant: 12),
            stackViewVersionWithDate.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackViewVersionWithDate.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            releaseNotesLabel.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: 12),
            releaseNotesLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            releaseNotesLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            releaseNotesLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func createStackView(with subviews: [UIView], axis: NSLayoutConstraint.Axis = .horizontal, space: CGFloat = 12, alignment: UIStackView.Alignment = .center, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.alignment = alignment
        stackView.spacing = space
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}
