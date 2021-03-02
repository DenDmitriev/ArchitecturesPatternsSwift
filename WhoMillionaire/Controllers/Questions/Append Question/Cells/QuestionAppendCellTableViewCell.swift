//
//  QuestionAppendCellTableViewCell.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 26.02.2021.
//

import UIKit

class QuestionAppendCellTableViewCell: UITableViewCell, QuestionSet, UITextFieldDelegate {
    
    static let identifier = "question"

    @IBOutlet weak var questionField: UITextField!
    
    var editingDidEnd: ((UITextField) -> Void)?
    
    override func prepareForReuse() {
        questionField.text?.removeAll()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questionField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(type: QuestionCellType) {
        questionField.placeholder = "Вопрос"
    }
    
    @IBAction func questionDidEndAction(_ sender: UITextField) {
        editingDidEnd?(sender)
    }

}
