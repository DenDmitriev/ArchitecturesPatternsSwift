//
//  GroupTableViewCell.swift
//  1l_ДмитриевДенис
//
//  Created by Denis Dmitriev on 21.06.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    static let identifier = "cell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarView: AvatarView!
    
    func configure(with viewModel: GroupViewModel, with avatar: UIImage?) {
        titleLabel.text = viewModel.title
        avatarView.image = avatar
    }

}
