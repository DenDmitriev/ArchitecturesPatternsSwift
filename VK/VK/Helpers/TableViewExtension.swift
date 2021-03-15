//
//  TableViewExtension.swift
//  VK
//
//  Created by Denis Dmitriev on 29.01.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit

extension UITableView {
    
    func showPlaceholder(message: String) {
        let label = UILabel()
        label.text = message
        label.textColor = .gray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        self.backgroundView = label
    }
    
    func dissmisPlaceholder() {
        self.backgroundView = nil
    }
    
}
