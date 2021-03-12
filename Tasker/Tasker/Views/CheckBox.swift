//
//  CheckBox.swift
//  Tasker
//
//  Created by Denis Dmitriev on 12.03.2021.
//

import UIKit

@IBDesignable class CheckBox: UIButton {
    
    let checkedImage = UIImage(systemName: "checkmark.rectangle")
    let uncheckedImage = UIImage(systemName: "rectangle")
    
    @IBInspectable var color: UIColor = UIColor.systemBlue  {
        didSet {
            self.tintColor = color
        }
    }
    
    @IBInspectable var check: Bool = false {
        didSet {
            if check == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
        
    override func awakeFromNib() {
        self.imageView?.contentMode = .scaleAspectFit
        self.contentHorizontalAlignment = .fill
        self.contentVerticalAlignment = .fill
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.check = false
    }
    
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            check = !check
        }
    }
}
