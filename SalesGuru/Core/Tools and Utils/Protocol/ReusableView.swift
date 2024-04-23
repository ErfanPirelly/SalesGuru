//
//  ReusableView.swift
//  Pirelly
//
//  Created by shndrs on 6/17/23.
//

import UIKit

protocol ReusableView {}

extension ReusableView where Self: UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
