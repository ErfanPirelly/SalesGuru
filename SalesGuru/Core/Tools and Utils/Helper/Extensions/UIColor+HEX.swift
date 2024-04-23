//
//  UIColor+HEX.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/25/23.
//

import UIColor_Hex_Swift
import UIKit
// MARK: - P3 Support
public extension UIColor {

    convenience init(p3: String, defaultColor: UIColor = UIColor.clear) {
        guard let color = try? UIColor(p3_rgba_throws: p3) else {
            self.init(cgColor: defaultColor.cgColor)
            return
        }
        self.init(cgColor: color.cgColor)
    }

    convenience init(p3_rgba_throws rgba: String) throws {
        guard rgba.hasPrefix("#") else {
            throw NSError(domain: "missingHashMarkAsPrefix", code: 0, userInfo: nil)
        }

        let hexString: String = String(rgba[String.Index(utf16Offset: 1, in: rgba)...])
        var hexValue: UInt32 = 0

        guard Scanner(string: hexString).scanHexInt32(&hexValue) else {
            throw NSError(domain: "unableToScanHexValue", code: 0, userInfo: nil)
        }

        switch hexString.count {
        case 3:
            self.init(hex3: UInt16(hexValue))
        case 4:
            self.init(hex4: UInt16(hexValue))
        case 6:
            self.init(p3: hexValue)
        case 8:
            self.init(hex8: hexValue)
        default:
            throw NSError(domain: "mismatchedHexStringLength", code: 0, userInfo: nil)
        }
    }

    convenience init(p3 hex6: UInt32) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        self.init(displayP3Red: red, green: green, blue: blue, alpha: 1)
    }
}
