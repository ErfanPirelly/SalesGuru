//  UploadingView.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/17/23.
//

import Foundation

public extension UserDefaults {
    subscript<T>(key: String) -> T? {
        get {
            return value(forKey: key) as? T
        }
        set {
            set(newValue, forKey: key)
        }
    }
}
