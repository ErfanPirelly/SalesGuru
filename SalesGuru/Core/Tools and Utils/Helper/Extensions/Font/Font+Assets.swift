//
//  Font+Assets.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/22/24.
//


import SwiftUI

protocol SwiftUIFonts {
    func Convert() -> Font
}

extension UIFont: SwiftUIFonts {
    func Convert() -> Font {
        return .init(self)
    }
}

extension Font {
    struct Sans{
        static func bold(_ size: CGFloat) -> Font {
            return UIFont(name: "DMSans-Bold", size: size)!.Convert()
        }
        
        static func semiBold(_ size: CGFloat) -> Font {
            return UIFont(name: "DMSans-SemiBold", size: size)!.Convert()
        }
        
        static func medium(_ size: CGFloat) -> Font {
            return UIFont(name: "DMSans-Medium", size: size)!.Convert()
        }
        
        static func normal(_ size: CGFloat) -> Font {
            return UIFont(name: "DMSans-Regular", size: size)!.Convert()
        }
        
        static func light(_ size: CGFloat) -> Font {
            return UIFont(name: "DMSans-Light", size: size)!.Convert()
        }
    }
    
    struct Quicksand {
        static func bold(_ size: CGFloat) -> Font {
            return UIFont(name: "Quicksand-Bold", size: size)!.Convert()
        }
        
        static func semiBold(_ size: CGFloat) -> Font {
            return UIFont(name: "Quicksand-SemiBold", size: size)!.Convert()
        }
        
        static func medium(_ size: CGFloat) -> Font {
            return UIFont(name: "Quicksand-Medium", size: size)!.Convert()
        }
        
        static func normal(_ size: CGFloat) -> Font {
            return UIFont(name: "Quicksand-Regular", size: size)!.Convert()
        }
        
        static func light(_ size: CGFloat) -> Font {
            return UIFont(name: "Quicksand-Light", size: size)!.Convert()
        }
    }
    
}
