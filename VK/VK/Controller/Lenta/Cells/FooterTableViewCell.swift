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
    
    func configure(with viewModel: LentaModel?) {
        guard let footerModel = viewModel as? LentaFooterModel else { return }
        configButton(button: likeControl, count: footerModel.likes)
        configButton(button: commentControl, count: footerModel.comments)
        configButton(button: repostControl, count: footerModel.reposts)
        configButton(button: viewControl, count: footerModel.views)
    }

    
    private func configButton(button: LikeButton, count: Int?) {
        guard let number = count else {
            button.isHidden = true
            return
        }
        button.isHidden = false
        button.count = number
    }
    
}
