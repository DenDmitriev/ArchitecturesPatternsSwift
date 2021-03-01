//
//  UIAlertControllerExtension.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 25.02.2021.
//

import UIKit

extension UIAlertController {
    func setFontColor(_ titleColor: UIColor, _ messageColor: UIColor) {
        if let title = title {
            self.setValue(NSAttributedString(string: title, attributes: [.foregroundColor : titleColor]), forKey: "attributedTitle")
        }
        if let message = message {
            self.setValue(NSAttributedString(string: message, attributes: [.foregroundColor : messageColor]), forKey: "attributedMessage")
        }
    }
    
    func setbackgroundColor(_ color: UIColor) {
        self.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = color
    }
}
