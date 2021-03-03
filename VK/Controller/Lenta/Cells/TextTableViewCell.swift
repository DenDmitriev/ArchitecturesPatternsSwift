//
//  TextTableViewCell.swift
//  VK
//
//  Created by Denis Dmitriev on 12.01.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit

protocol TextTableViewCellDelegate: class {
    func updateCell(sender: TextTableViewCell)
}

class TextTableViewCell: UITableViewCell, PostSet {
    
    weak var delegate: TextTableViewCellDelegate?
    
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var showMoreView: UIView!
    @IBOutlet weak var showMoreButton: UIButton!
    
    
    //MARK: - Life circle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Setup
    
    func set(post: Post) {
        postTextView.text = post.text
        
        let textHeight = postTextView.calculateViewHeightWithCurrentWidth()
        showMoreView.isHidden = ((textHeight - PostSize.text) / PostSize.text < 1) ? true : false
        post.textMode == .short ? showMoreButton.setTitle("Показать...", for: .normal) : showMoreButton.setTitle("Скрыть", for: .normal)
    }
    
    private func reset() {
        postTextView.text = ""
        showMoreView.isHidden = false
    }
    
    
    //MARK: - Actions
    
    @IBAction func showMoreAction(_ sender: UIButton) {
        delegate?.updateCell(sender: self)
    }
}


