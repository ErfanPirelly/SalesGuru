//
//  UIView+Frame.swift
//  Pirelly
//
//  Created by mmdMoovic on 2/10/24.
//

import UIKit

extension UIView {
    static func getCaptureArea(ratio: Double, areaToDarken: CGRect) -> CGRect {
        let previewFrame: CGRect = .init(origin: .zero, size: CGSize(width: K.size.landscape.height * ratio, height: K.size.landscape.height))
        var areaToLeaveClear = previewFrame
        areaToLeaveClear.origin = .init(x: (areaToDarken.width - previewFrame.width)/2, y: (areaToDarken.height - previewFrame.height)/2)
        return areaToLeaveClear
    }
}
