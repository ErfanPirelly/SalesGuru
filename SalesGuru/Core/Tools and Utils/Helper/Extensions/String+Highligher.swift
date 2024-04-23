//
//  String+Highligher.swift
//  BaseModule
//
//  Created by mmdMoovic on 5/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

public extension String {

     static let sizeTokens = [" KB", " MB", " GB"]

    // MARK: - Spacing
    func addingCharSpacing(_ spacing: CGFloat) -> NSAttributedString {
        return NSAttributedString(string: self).addingCharSpacing(spacing)
    }

    func addingLineSpacing(_ spacing: CGFloat, isCentered: Bool = false) -> NSAttributedString {
        return NSAttributedString(string: self).addingLineSpacing(spacing, isCentered: isCentered)
    }

    // MARK: - Tags
    func colorizeTag(text: String, toColor: UIColor,from color: UIColor? = nil) -> NSAttributedString {
        let _color = color ?? .white
        let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.foregroundColor: _color])
        let ColoredAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: toColor]
        let range = (self as NSString).range(of: text)
        fullString.addAttributes(ColoredAttribute, range: range)
        return fullString
    }
    
    func highlightingTag(_ tag: String, color: UIColor) -> NSAttributedString {
        let matches = findTags(tag, in: self)
        var fullString = self
        var subStrings = [String]()

        for match in matches {
            let subStringWithTag = (self as NSString).substring(with: match.range(at: 0))
            let subStringWithoutTag = (self as NSString).substring(with: match.range(at: 1))

            fullString = fullString.replacingOccurrences(of: subStringWithTag, with: subStringWithoutTag)
            subStrings.append(subStringWithoutTag)
        }

        return NSMutableAttributedString(string: fullString).highlightingWords(subStrings, color: color)
    }
    
    func highlightingTag(_ tag: String, font: UIFont, color: UIColor) -> NSAttributedString {
        let matches = findTags(tag, in: self)
        var fullString = self
        var subStrings = [String]()

        for match in matches {
            let subStringWithTag = (self as NSString).substring(with: match.range(at: 0))
            let subStringWithoutTag = (self as NSString).substring(with: match.range(at: 1))

            fullString = fullString.replacingOccurrences(of: subStringWithTag, with: subStringWithoutTag)
            subStrings.append(subStringWithoutTag)
        }

        return NSMutableAttributedString(string: fullString).highlightingWords(subStrings, font: font, color: color)
    }

    func findTags(_ tag: String, in string: String) -> [NSTextCheckingResult] {
        let pattern = "<\(tag)>(.*?)</\(tag)>"

        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            return regex.matches(in: string, range: NSRange(location: 0, length: string.count))
        } catch {
            return []
        }
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont, for width: CGFloat? = nil) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        var numberOfLines = CGFloat(1)
//        if let width = width {
//            let txtWidth = size.width
//            numberOfLines = CGFloat(txtWidth/width) + 1
//        }
        return size.height * numberOfLines
    }
    
    func size(font: UIFont, width: CGFloat) -> CGSize {
        let attrString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.font: font])
        let bounds = attrString.boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
          let size = CGSize(width: bounds.width, height: bounds.height + 20)
          return size
      }
    
    func toColor(text: String,toColor:UIColor,color: UIColor? = nil) -> NSAttributedString {
        let _color = color ?? .black
        let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.foregroundColor: _color])
        let ColoredAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: toColor]
        let range = (self as NSString).range(of: text)
        fullString.addAttributes(ColoredAttribute, range: range)
        return fullString
    }
}
