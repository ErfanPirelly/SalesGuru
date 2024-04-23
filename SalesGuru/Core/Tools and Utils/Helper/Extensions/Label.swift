//
//  Label.swift
//  BaseModule
//
//  Created by mmdMoovic on 5/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

// MARK: - UILabel

public extension UILabel{
    
    func setFontAndSize(fontName: String, size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: fontName , size: size)
        adjustsFontSizeToFitWidth = true
    }
    
    convenience init(text: String? = nil, attributedText: NSAttributedString? = nil, font: UIFont, textColor: UIColor? = nil, alignment: NSTextAlignment = .left) {
        self.init(frame: .null)
        translatesAutoresizingMaskIntoConstraints = false
        self.adjustsFontSizeToFitWidth = false
        self.font = font
        self.textColor = textColor ?? .black
        self.textAlignment = alignment
        if let text = text {
            self.text = text.localized
        } else if let attributedText = attributedText {
            self.attributedText = attributedText
        }
    }
    
    func padedText(text : String) {
        var padCount = (text.count)/2
        
        if text.count < 5 {
            padCount = 4
        }
        
        let paded = text.padding(toLength: text.count + padCount, withPad: " ", startingAt: 0)
        self.text = paded
    }
    
    
    func atachImageAndLable(image: String, lable: String) {
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: image)
        translatesAutoresizingMaskIntoConstraints = false
        let imageOffsetY: CGFloat = -5.0
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 12, height: 12)
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString()
        let textAfterIcon = NSAttributedString(string: lable)
        completeText.append(textAfterIcon)
        completeText.append(attachmentString)
        attributedText = completeText
    }
    
}


public extension UILabel{

    func setFontAndSizee(fontName: String, size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: fontName , size: size)
        adjustsFontSizeToFitWidth = true
    }

    func padedTextt(text : String) {
        var padCount = (text.count)/2

        if text.count < 5 {
            padCount = 4
        }

        let paded = text.padding(toLength: text.count + padCount, withPad: " ", startingAt: 0)
        self.text = paded
    }


    func atachImageAndLablee(image: String, lable: String) {

        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: image)
        translatesAutoresizingMaskIntoConstraints = false
        let imageOffsetY: CGFloat = -5.0
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 12, height: 12)

        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString()
        let textAfterIcon = NSAttributedString(string: lable)
        completeText.append(textAfterIcon)
        completeText.append(attachmentString)
        attributedText = completeText
    }

}
