//
//  UIViewController+Error.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/25/24.
//

import UIKit
import Toast_Swift

extension UIViewController {
   @objc func showError(message: String, duration: TimeInterval = ToastManager.shared.duration) {
        CustomToast(view: self.view).show(error: message, duration)
    }
}
