//
//  QuestionCell.swift.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 26.02.2021.
//

import UIKit

typealias QuestionCell = UITableViewCell & QuestionSet

protocol QuestionSet {
    
    var editingDidEnd: ((UITextField) -> Void)? { get set }
    
    func setup(type: QuestionCellType)
}
