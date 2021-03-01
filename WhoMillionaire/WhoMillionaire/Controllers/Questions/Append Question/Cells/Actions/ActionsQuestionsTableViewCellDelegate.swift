//
//  ActionsQuestionsTableViewCellDelegate.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 26.02.2021.
//

import UIKit

protocol ActionsQuestionsTableViewCellDelegate: AnyObject {
    func addEmptyQuestion()
    func saveQuestions()
}

class ActionsQuestionsTableViewCell: UITableViewCell {
    
    static let identifier = "actions"
    
    weak var delegate: ActionsQuestionsTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func appendAction(_ sender: UIButton) {
        delegate?.addEmptyQuestion()
    }
    
    @IBAction func saveQuestions(_ sender: UIButton) {
        delegate?.saveQuestions()
    }
}
