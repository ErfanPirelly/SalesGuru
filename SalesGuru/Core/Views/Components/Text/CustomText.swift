//
//  Text.swift
//  Pirelly
//
//  Created by mmdMoovic on 9/19/23.
//

import UIKit

struct CustomText {
    let text: String?
    let attributedText: NSAttributedString?
    let font: UIFont
    let textColor: UIColor?
    let alignment: NSTextAlignment
    
    init(text: String? = nil, attributedText: NSAttributedString? = nil, font: UIFont, textColor: UIColor? = nil, alignment: NSTextAlignment = .left) {
        self.text = text
        self.attributedText = attributedText
        self.textColor = textColor
        self.alignment = alignment
        self.font = font
    }
}
