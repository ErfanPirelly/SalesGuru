//
//  RightViewTextField.swift
//  Pirelly
//
//  Created by mmdMoovic on 1/28/24.
//

import UIKit

class RightViewTextField: UITextField {
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rightViewFrame = rightView?.frame
        if let frame = rightViewFrame {
            return frame
        } else {
            return super.rightViewRect(forBounds: bounds)
        }
    }
}
