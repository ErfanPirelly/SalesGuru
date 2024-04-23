//
//  UITextField.swift
//  Pirelly
//
//  Created by shndrs on 8/13/23.
//

import UIKit

extension UITextField {
        
    func custom(placeholder: String) {
        self.backgroundColor = .ui.textFieldsBG
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.systemGray
            ]
        )
    }
    
}