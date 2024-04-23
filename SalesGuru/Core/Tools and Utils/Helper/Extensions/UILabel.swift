//
//  UILabel.swift
//  Pirelly
//
//  Created by shndrs on 8/13/23.
//

import UIKit

extension UILabel {
    
    func colorChange(fullText: String,
                     changeText: String) {
        guard let strNumber: NSString = fullText as? NSString else { return }
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor,
                               value: UIColor.ui.primaryBlue ?? .ui.label,
                               range: range)
        self.attributedText = attribute
    }
    
}
