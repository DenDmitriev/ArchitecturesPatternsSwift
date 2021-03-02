//
//  RemoveQuestionTableViewCell.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 26.02.2021.
//

import UIKit


class RemoveQuestionTableViewCell: UITableViewCell {
    
    static let identifier = "remove"
    
    var removeForm: (() -> Void)?
    
    @IBAction func removeQuestionAction(_ sender: UIButton) {
        print(#function)
        removeForm?()
    }
    
}
