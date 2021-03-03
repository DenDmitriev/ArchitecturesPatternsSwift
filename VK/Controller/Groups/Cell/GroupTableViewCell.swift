//
//  GroupTableViewCell.swift
//  1l_ДмитриевДенис
//
//  Created by Denis Dmitriev on 21.06.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarView: AvatarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(group: Group, photoService: PhotoService, indexPath: IndexPath) {
        titleLabel.text = group.title
        avatarView.image = photoService.photo(atIndexpath: indexPath, byUrl: group.avatar)
    }

}
