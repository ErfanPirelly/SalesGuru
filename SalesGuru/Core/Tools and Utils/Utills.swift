//
//  Utils.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/20/23.
//

import UIKit
import CoreTelephony

struct Utils {
    // MARK: - variables
    static let termsPath = "https://app.termly.io/document/terms-of-service/1d70d89a-4892-44b9-9886-17ffa42ae7b8"
    static let privacyPath = "https://app.termly.io/document/privacy-policy/3c130672-1d9e-4d9b-b91f-1c827bfe918a"
    static let appStoreUrl = "https://apps.apple.com/us/app/drivee-car-photography/id6474120661"
    static let googleAppId = "1:187498481907:ios:ecab01d499f3126da00f86"

    private static let infoDict = Bundle.main.infoDictionary
    
    static var buildNumber: String {
        if let infoDict = infoDict {
            return infoDict["CFBundleVersion"] as? String ?? ""
        }
        return ""
    }
    
    static var appVersion: String {
        if let infoDict = infoDict {
            return infoDict["CFBundleShortVersionString"] as? String ?? ""
        }
        return ""
    }
    
    static let versionString = "Version \(appVersion)" + " (\(buildNumber))"
    
    // MARK: - functions
    static func byteSizeString(from data: Data) -> String {
        let byteCount = Double(data.count)
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useBytes, .useKB, .useMB, .useGB]
        formatter.countStyle = .file

        return formatter.string(fromByteCount: Int64(byteCount))
    }
    
    static func byteSizeString(from byteCount: Double) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useBytes, .useKB, .useMB, .useGB]
        formatter.countStyle = .file

        return formatter.string(fromByteCount: Int64(byteCount))
    }
    
    static  func topViewController(with rootViewController: UIViewController?) -> UIViewController? {
        guard let rootViewController = rootViewController else { return nil }
        
        if (rootViewController.isKind(of: UITabBarController.self)) {
            
            return topViewController(with: (rootViewController as! UITabBarController).selectedViewController)
        } else if (rootViewController.isKind(of: UINavigationController.self)) {
            
            return topViewController(with: (rootViewController as! UINavigationController).visibleViewController)
        } else if (rootViewController.presentedViewController != nil) {
            
            return topViewController(with: rootViewController.presentedViewController)
        }
        
        return rootViewController
    }
    
    static func timestamp(to timeResult: TimeInterval, style: DateFormatter.Style) -> String {
        let date = Date(timeIntervalSince1970: timeResult)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = style
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    static func generateRandomString(length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        
        for _ in 0..<length {
            let randomIndex = Int.random(in: 0..<characters.count)
            let character = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
            randomString.append(character)
        }
        
        return randomString
    }
    
   static func getLocalTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        let localTime = dateFormatter.string(from: Date())
        return localTime
    }
    
    static func timeAgoString(from timestamp: Double) -> String {
        let components = transform(timestamp: timestamp)
        
        if let week = components.weekOfYear, week > 0 {
            return "\(week) week\(week == 1 ? "" : "s") ago"
        } else if let day = components.day, day > 0 {
            return "\(day) day\(day == 1 ? "" : "s") ago"
        } else if let hour = components.hour, hour > 0 {
            return "\(hour) hour\(hour == 1 ? "" : "s") ago"
        } else if let minute = components.minute, minute > 0 {
            return "\(minute) min\(minute == 1 ? "" : "s") ago"
        } else if let second = components.second, second >= 10 {
            return "\(second) seconds ago"
        } else {
            return "Now"
        }
    }
    
    static func transform(timestamp: Double) -> DateComponents {
        let currentDate = Date()
        let date = Date(timeIntervalSince1970: timestamp)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.second, .minute, .hour, .day, .weekOfYear], from: date, to: currentDate)
        return components
    }
    
    static func getCountryCode() -> String {
        guard let carrier = CTTelephonyNetworkInfo().subscriberCellularProvider,
              let countryCode = carrier.isoCountryCode else { return "US" }
        return countryCode.uppercased()
    }
}

extension Data {
    func byteSizeString() -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useBytes, .useKB, .useMB, .useGB]
        formatter.countStyle = .file

        return formatter.string(fromByteCount: Int64(count))
    }
}


extension CGSize {
    func calculateCropRect(targetAspectRatio: CGFloat) -> CGRect {
        let originalSize = self
        let originalAspectRatio = originalSize.width / originalSize.height

        if originalAspectRatio > targetAspectRatio {
            // The original image is wider than the target aspect ratio.
            let newWidth = originalSize.height * targetAspectRatio
            let xOffset = (originalSize.width - newWidth) / 2.0
            return CGRect(x: xOffset, y: 0, width: newWidth, height: originalSize.height)
        } else {
            // The original image is taller than the target aspect ratio.
            let newHeight = originalSize.width / targetAspectRatio
            let yOffset = (originalSize.height - newHeight) / 2.0
            return CGRect(x: 0, y: yOffset, width: originalSize.width, height: newHeight)
        }
    }
}
