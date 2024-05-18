//
//  UIView+Layer.swift
//  Pirelly
//
//  Created by Mohammad Takbiri on 6/14/23.
//
import UIKit

extension UIView {
    func addCorner(_ corner: CGFloat) {
        layer.cornerRadius = corner
        layer.masksToBounds = true
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = layer.cornerRadius
        self.layer.shadowOffset = CGSize(width: 1, height: -3)
        self.layer.shadowOpacity = 0.25
        
    }
}
