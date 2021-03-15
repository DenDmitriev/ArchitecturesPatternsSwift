//
//  HeaderTableViewCell.swift
//  VK
//
//  Created by Denis Dmitriev on 12.01.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit
import Kingfisher

class HeaderTableViewCell: UITableViewCell, PostSet {

    @IBOutlet weak var avatarImageView: AvatarView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    
    func configure(with viewModel: LentaModel?) {
        guard let headerModel = viewModel as? LentaHeaderModel else { return }
        nameLabel.text = headerModel.name
        datelabel.text = DateFormatter.medium.string(from: Date(timeIntervalSince1970: headerModel.date))
        avatar(for: headerModel.avatar)
    }
    
    private func avatar(for url: URL) {
        let resource = ImageResource(downloadURL: url)
        avatarImageView.imageView.kf.setImage(with: resource)
    }
    
}
