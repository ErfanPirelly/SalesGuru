//
//  UIColor+Asset.swift
//  Pirelly
//
//  Created by Mohammad Takbiri on 5/29/23.
//

import UIKit

extension UIColor {
    static let ui = UIColor.UI()

    struct UI {
        let primaryBlue = UIColor(named: "primaryBlue")
        let subtitleDarkGray = UIColor(named: "subtitleDarkGray")
        let textFieldsBG = UIColor(named: "textFieldsBG")
        let red = UIColor(named: "red")
        let darkText = UIColor(named: "darkText")
        let darkColor = UIColor(named: "darkColor")
        let grayHalfAlpha = UIColor(named: "grayHalfAlpha")
        let redError = UIColor(named: "redError")
        let green = UIColor(named: "green")
        let lightGray = UIColor(named: "lightGray")
        let darkYellow = UIColor(named: "darkYellow")
        let white = UIColor.white
        let clear = UIColor.clear
        let black = UIColor.black
        let label = UIColor.label
        let secondaryLabel = UIColor.secondaryLabel
        let tertiaryLabel = UIColor.tertiaryLabel
        let primaryBack = UIColor.systemBackground
        let secondaryBack = UIColor.secondarySystemBackground
        let tertiaryBack = UIColor.tertiarySystemBackground
        let cancel = #colorLiteral(red: 0.9411764706, green: 0.251555751, blue: 0.3019607843, alpha: 1)
        let set = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        // MARK: - hex colors
        /// B8BABF
        let silverGray = UIColor(p3: "#B8BABF")
        
        /// 141414
        let darkColor2 = UIColor(p3: "#141414")
        
        /// 171717
        let darkColor3 = UIColor(p3: "#171717")
        
        /// 131313
        let darkColor4 = UIColor(p3: "#131313")
        
        /// D89106
        let darkYellowColor = UIColor(p3: "#D89106")
        
        /// E1E1E1
        let whiteTextColor = UIColor(p3: "#E1E1E1")
        
        /// EFEFEF
        let backgroundColor1 = UIColor(p3: "#EFEFEF")
        
        /// FAFAFA
        let backgroundColor2 = UIColor(p3: "#FAFAFA")
        
        /// #F5F6FA
        let backgroundColor3 = UIColor(p3: "#F5F6FA")
    }
}
