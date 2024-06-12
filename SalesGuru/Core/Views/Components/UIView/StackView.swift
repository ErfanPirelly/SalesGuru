//
//  StackView.swift
//  Pirelly
//
//  Created by mmdMoovic on 9/24/23.
//

import UIKit

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis = .horizontal,
                     alignment: Alignment = .center,
                     distribution: Distribution = .equalSpacing,
                     spacing: CGFloat = 8,
                     arrangedSubviews: [UIView] = []) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        
        for (index, value) in arrangedSubviews.enumerated() {
            if value.tag == 0 {
                value.tag = index
            }
        }
    }
}
