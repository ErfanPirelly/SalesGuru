//
//  KeyboardManager.swift
//  Pirelly
//
//  Created by shndrs on 8/12/23.
//

import IQKeyboardManagerSwift

struct KeyboardManager {
    
    public static func applyConfig() {
        let keyboardManager = IQKeyboardManager.shared
        keyboardManager.enabledTouchResignedClasses = [UIViewController.self]
        keyboardManager.shouldResignOnTouchOutside = true
        keyboardManager.enable = true
        keyboardManager.toolbarTintColor = .ui.label
        keyboardManager.toolbarBarTintColor = .ui.primaryBack
        keyboardManager.toolbarDoneBarButtonItemText = "Done"
        keyboardManager.enableAutoToolbar = true
    }
    
}
