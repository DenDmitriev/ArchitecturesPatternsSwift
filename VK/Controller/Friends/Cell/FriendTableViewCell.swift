//
//  FriendTableViewCell.swift
//  1l_ДмитриевДенис
//
//  Created by Denis Dmitriev on 21.06.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    static let identifier = "cell"
    
    var id: Int!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: AvatarView!
    
    func configure(with user: FriendsViewModel, avatar: UIImage?) {
        self.id = user.id
        self.nameLabel.text = user.name
        self.avatarImage.image = avatar
    }
}
