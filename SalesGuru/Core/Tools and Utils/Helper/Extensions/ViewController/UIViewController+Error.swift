//
//  UIViewController+Error.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/25/24.
//

import UIKit

extension UIViewController {
    func showError(message: String) {
        CustomToast(view: self.view).show(error: message)
    }
}
