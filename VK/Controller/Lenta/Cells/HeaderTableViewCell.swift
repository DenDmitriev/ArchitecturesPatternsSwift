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
    
    func set(post: Post) {
        
        datelabel.text = Format.shared.dateFormatter.string(from: Date(timeIntervalSince1970: post.date))
        
        if post.user != nil {
            let user = post.user
            let title = (user?.name ?? "") + " " + (user?.lastname ?? "")
            let image = user?.avatar
            setAuthor(image: image, title: title)
        } else if post.group != nil {
            let group = post.group
            let title = group?.title ?? ""
            let image = group?.avatar
            setAuthor(image: image, title: title)
        }
    }
    
    func setAuthor(image: String?, title: String) {
        nameLabel.text = title
        guard let url = URL(string: image ?? "") else { return }
        let resource = ImageResource(downloadURL: url)
        avatarImageView.imageView.kf.setImage(with: resource)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
