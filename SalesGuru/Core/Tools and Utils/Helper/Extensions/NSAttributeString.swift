//
//  NSAttributeString.swift
//  BaseModule
//
//  Created by mmdMoovic on 5/14/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

public extension NSAttributedString {

    // MARK: - Spacing
    func addingLineSpacing(_ spacing: CGFloat, isCentered: Bool = false) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.alignment = isCentered ? .center : .natural
        paragraphStyle.lineSpacing = spacing

        return addingParagraphStyle(paragraphStyle)
    }

    func addingCharSpacing(_ spacing: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let allRange = NSRange(location: 0, length: length - 1)

        attributedString.addAttribute(.kern, value: spacing, range: allRange)

        return attributedString
    }

    private func addingParagraphStyle(_ paragraphStyle: NSParagraphStyle) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let allRange = NSRange(location: 0, length: length)

        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: allRange)

        return attributedString
    }

    // MARK: - Style
    func highlightingWords(_ words: [String], font: UIFont? = nil, color: UIColor? = nil) -> NSAttributedString {
        let mutableString = NSMutableAttributedString(attributedString: self)
        var attrs = [NSAttributedString.Key: Any]()

        if let font = font { attrs[.font] = font }
        if let color = color { attrs[.foregroundColor] = color }

        words.forEach {
            mutableString.addAttributes(attrs, range: (string as NSString).range(of: $0))
        }

        return mutableString
    }
}

