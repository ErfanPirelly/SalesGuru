//
//  UIFont+Archive.swift
//  Pirelly
//
//  Created by Mohammad Takbiri on 5/29/23.
//

import UIKit

extension UIFont {
    struct Fonts {
        static func bold(_ size: CGFloat) -> UIFont {
            return UIFont(name: "DMSans-Bold", size: size)!
        }
        
        static func semiBold(_ size: CGFloat) -> UIFont {
            return UIFont(name: "DMSans-SemiBold", size: size)!
        }
        
        static func medium(_ size: CGFloat) -> UIFont {
            return UIFont(name: "DMSans-Medium", size: size)!
        }
        
        static func normal(_ size: CGFloat) -> UIFont {
            return UIFont(name: "DMSans-Regular", size: size)!
        }
        
        static func light(_ size: CGFloat) -> UIFont {
            return UIFont(name: "DMSans-Light", size: size)!
        }
        
    }
}

