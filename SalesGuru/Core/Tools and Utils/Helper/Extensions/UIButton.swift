//
//  UIButton.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/7/23.
//

import UIKit

public extension UIButton {
    convenience init(image: UIImage) {
        self.init(type: .system)
        self.translatesAutoresizingMaskIntoConstraints = false
        setImage(image, for: .normal)
    }
    
    // swiftlint:disable:next function_default_parameter_at_end
    convenience init(type: ButtonType = .system, title: String? = nil, attributedTitle: NSAttributedString? = nil, titleColor: UIColor? = nil, font: UIFont) {
        self.init(type: type)
        self.translatesAutoresizingMaskIntoConstraints = false

        titleLabel?.font = font

        if let titleColor = titleColor {
            setTitleColor(titleColor, for: .normal) // for .title
            titleLabel?.textColor = titleColor      // for .attributedTitle
        }

        if let title = title {
            setTitle(title.localized, for: .normal)
        } else if let attributedTitle = attributedTitle {
            setAttributedTitle(attributedTitle, for: .normal)
        }
    }
}
