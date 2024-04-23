//
//  UITextField+sideView.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/18/23.
//

import UIKit

extension UITextField {
    func addLeftTemp() {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        leftView.backgroundColor = .clear
        
        self.leftView = leftView
        self.leftViewMode = .always
    }
}
