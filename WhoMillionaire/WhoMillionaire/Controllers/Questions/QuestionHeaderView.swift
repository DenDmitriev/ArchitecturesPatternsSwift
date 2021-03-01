//
//  QuestionHeaderView.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 25.02.2021.
//

import UIKit

class QuestionHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "header"
    
    let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        title.translatesAutoresizingMaskIntoConstraints = false
            
        contentView.addSubview(title)

        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor,
                   constant: 8),
            title.trailingAnchor.constraint(equalTo:
                   contentView.layoutMarginsGuide.trailingAnchor,
                                            constant: 8),
//            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            title.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
//            title.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
