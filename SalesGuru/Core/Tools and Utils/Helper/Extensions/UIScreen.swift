//
//  UIScreen.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/11/23.
//

import UIKit

extension UIScreen {
    var displayCornerRadius: CGFloat {
        guard let radius = value(forKey: "_displayCornerRadius") as? CGFloat else {
            return 0
        }
        return radius
    }
}
