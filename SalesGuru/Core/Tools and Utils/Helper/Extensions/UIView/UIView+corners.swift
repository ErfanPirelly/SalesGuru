//
//  UIView+corners.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/9/23.
//

import UIKit

public enum Corners {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    case leftSide
    case top
    case rightSide
    case bottom
    case all
    case none
    
    var corners: CACornerMask? {
        var result: CACornerMask?
        
        switch self {
        case .topLeft:
            result = [.layerMinXMinYCorner]
            
        case .topRight:
            result = [.layerMaxXMinYCorner]
            
        case .bottomLeft:
            result = [.layerMinXMaxYCorner]
            
        case .bottomRight:
            result = [.layerMaxXMaxYCorner]
            
        case .leftSide:
            result = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            
        case .top:
            result = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
        case .rightSide:
            result = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            
        case .bottom:
            result = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            
        case .all:
            result = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
            
        default:
            result = []
        }
        
        return result
    }
}

extension UIView {
    func applyCorners(to corners: Corners, with radius: CGFloat) {
        guard let corners = corners.corners else { return }
        self.layer.maskedCorners = corners
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
