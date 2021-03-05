//
//  TextViewExtension.swift
//  VK
//
//  Created by Denis Dmitriev on 01.02.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit

extension UITextView {
    
    func calculateViewHeightWithCurrentWidth() -> CGFloat {
        let textWidth = self.frame.width -
            self.textContainerInset.left -
            self.textContainerInset.right -
            self.textContainer.lineFragmentPadding * 2.0 -
            self.contentInset.left -
            self.contentInset.right
        
        let maxSize = CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude)
        var calculatedSize = self.attributedText.boundingRect(with: maxSize,
                                                              options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                      context: nil).size
        calculatedSize.height += self.textContainerInset.top
        calculatedSize.height += self.textContainerInset.bottom
        
        if self.text.isEmpty {
            return 0
        } else {
            return ceil(calculatedSize.height)
        }
    }
}
