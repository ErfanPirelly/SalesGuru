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
        
        /// #07A4FC
        let primaryBlue = UIColor(p3: "#07A4FC")

        /// #B73333
        let red = UIColor(p3: "#B73333")

        /// #36B27E
        let green = UIColor(p3: "#36B27E")
        
        /// B8BABF
        let silverGray = UIColor(p3: "#B8BABF")
        
        /// 171717
        let darkColor = UIColor(p3: "#171717")
        
        /// #535353
        let darkColor2 = UIColor(p3: "#535353")
        
        /// 8F92A1
        let darkColor3 = UIColor(p3: "#8F92A1")
        
        /// 131313
        let darkColor4 = UIColor(p3: "#131313")
        
        /// D89106
        let darkYellowColor = UIColor(p3: "#D89106")
        
        /// E1E1E1
        let whiteTextColor = UIColor(p3: "#E1E1E1")
        
        /// FFFFFF
        let backgroundColor1 = UIColor(p3: "#FFFFFF")
        
        /// F5F5F5
        let backgroundColor2 = UIColor(p3: "#F5F5F5")
        
        /// #F9F9FA
        let backgroundColor3 = UIColor(p3: "#F9F9FA")
    }
}
