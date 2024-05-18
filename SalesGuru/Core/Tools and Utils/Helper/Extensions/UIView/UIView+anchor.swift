//
//  UIView+anchor.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/6/23.
//

import UIKit

// MARK: - UIView
public extension UIView {
    func pinToEdge(on view: UIView) {
        anchorWithConstants(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor)
    }
    
    func anchorWithConstantsToTop(top : NSLayoutYAxisAnchor? = nil,
                                  left : NSLayoutXAxisAnchor? = nil,
                                  right: NSLayoutXAxisAnchor? = nil,
                                  bottom : NSLayoutYAxisAnchor? = nil,
                                  topConstant : CGFloat = 0,
                                  leftConstant : CGFloat = 0,
                                  rightConstant : CGFloat = 0,
                                  bottomConstant : CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top,constant: topConstant).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom,constant: bottomConstant).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left,constant: leftConstant).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right,constant: -rightConstant).isActive = true
        }
        if let top = top {
            topAnchor.constraint(equalTo: top,constant: topConstant).isActive = true
        }
    }
    
    func anchorWithConstants(top : NSLayoutYAxisAnchor? = nil,
                                  leading : NSLayoutXAxisAnchor? = nil,
                                  trailing: NSLayoutXAxisAnchor? = nil,
                                  bottom : NSLayoutYAxisAnchor? = nil,
                                  topConstant : CGFloat = 0,
                                  leftConstant : CGFloat = 0,
                                  rightConstant : CGFloat = 0,
                                  bottomConstant : CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top,constant: topConstant).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom,constant: bottomConstant).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading,constant: leftConstant).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing,constant: -rightConstant).isActive = true
        }
        if let top = top {
            topAnchor.constraint(equalTo: top,constant: topConstant).isActive = true
        }
    }
    
    func adjustHeight(for height: CGFloat, screenHeight: CGFloat) -> CGFloat {
        return (height/screenHeight)*( UIScreen.main.bounds.height)
    }
    
    func adjustWidth(for width: CGFloat, screenWidth: CGFloat) -> CGFloat {
        return (width/screenWidth)*(UIScreen.main.bounds.width)
    }
    
    static var safeArea: UIEdgeInsets {
        return UIApplication.shared.windows[0].safeAreaInsets
    }
    
    static var topOrLeftSafeAreaConstant: CGFloat {
        if safeArea.top > safeArea.left {
            return safeArea.top
        } else {
            return safeArea.left
        }
    }
    
   static func adjustHeight(for height: CGFloat, screenHeight: CGFloat) -> CGFloat {
        return (height/screenHeight)*(UIScreen.main.bounds.height)
    }
}

