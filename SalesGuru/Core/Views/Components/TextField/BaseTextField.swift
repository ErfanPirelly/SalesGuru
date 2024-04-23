//
//  BaseTextField.swift
//  Pirelly
//
//  Created by shndrs on 6/22/23.
//

import UIKit

class BaseTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 5)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}

// MARK: - Methods

extension BaseTextField {
    
    @objc func setup() {
        self.textColor = .ui.label
        self.font = UIFont.Fonts.medium(14)
        self.borderStyle = .none
        self.backgroundColor = .ui.primaryBack
        self.addCornerRadius(radius: 16)
    }
    
}
