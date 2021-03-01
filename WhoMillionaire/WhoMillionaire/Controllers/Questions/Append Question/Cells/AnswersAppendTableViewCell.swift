//
//  AnswersAppendTableViewCell.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 26.02.2021.
//

import UIKit

class AnswersAppendTableViewCell: UITableViewCell, QuestionSet, UITextFieldDelegate {
    
    static let identifier = "answer"
    
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var trueSwitch: UISwitch!
    
    var editingDidEnd: ((UITextField) -> Void)?
    
    override func prepareForReuse() {
        answerField.text?.removeAll()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        answerField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(type: QuestionCellType) {
        var placeholder: String!
        switch type {
        case .answerOne:
            placeholder = "Ответ A"
        case .answerTwo:
            placeholder = "Ответ B"
        case .answerThree:
            placeholder = "Ответ C"
        case .answerFour:
            placeholder = "Ответ D"
        default:
            placeholder = ""
        }
        answerField.placeholder = placeholder
        
        if type != .answerOne {
            trueSwitch.isOn = false
        } else {
            trueSwitch.isOn = true
        }
    }

    @IBAction func trueSwitchValueChanged(_ sender: Any) {
        
    }
    
    @IBAction func answerDidEndAction(_ sender: UITextField) {
        editingDidEnd?(sender)
    }
}
