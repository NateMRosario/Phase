//
//  UILabel+AttributedText.swift
//  Phase
//
//  Created by Clint M on 4/9/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import Foundation

extension UILabel {
    
    /** Sets up the label with two different kinds of attributes in its attributed text.
     *  @params:
     *  - primaryString: the normal attributed string.
     *  - secondaryString: the bold or highlighted string.
     */
    
    func setAttributedText(primaryString: String, textColor: UIColor, font: UIFont, secondaryString: String, secondaryTextColor: UIColor, secondaryFont: UIFont) {
        
        let completeString = "\(primaryString) \(secondaryString)"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let completeAttributedString = NSMutableAttributedString(
            string: completeString, attributes: [
                .font: font,
                .foregroundColor: textColor,
                .paragraphStyle: paragraphStyle
            ]
        )
        
        let secondStringAttribute: [NSAttributedStringKey: Any] = [
            .font: secondaryFont,
            .foregroundColor: secondaryTextColor,
            .paragraphStyle: paragraphStyle
        ]
        
        let range = (completeString as NSString).range(of: secondaryString)
        
        completeAttributedString.addAttributes(secondStringAttribute, range: range)
        
        self.attributedText = completeAttributedString
    }
}
