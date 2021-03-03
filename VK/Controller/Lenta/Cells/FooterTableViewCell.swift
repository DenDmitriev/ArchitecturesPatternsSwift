//
//  FooterTableViewCell.swift
//  VK
//
//  Created by Denis Dmitriev on 12.01.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit

class FooterTableViewCell: UITableViewCell, PostSet {

    @IBOutlet weak var likeControl: LikeButton!
    @IBOutlet weak var commentControl: LikeButton!
    @IBOutlet weak var repostControl: LikeButton!
    @IBOutlet weak var viewControl: LikeButton!
    
    
    func set(post: Post) {
        configButton(button: likeControl, count: post.likes?.count)
        configButton(button: commentControl, count: post.comments?.count)
        configButton(button: repostControl, count: post.reposts?.count)
        configButton(button: viewControl, count: post.views?.count)
    }
    
    func configButton(button: LikeButton, count: Int?) {
        guard let number = count else {
            button.isHidden = true
            return
        }
        button.isHidden = false
        button.count = number
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
