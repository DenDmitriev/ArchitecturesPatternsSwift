//
//  TaskView.swift
//  Tasker
//
//  Created by Denis Dmitriev on 12.03.2021.
//

import UIKit

@IBDesignable class TaskView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 4 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}
