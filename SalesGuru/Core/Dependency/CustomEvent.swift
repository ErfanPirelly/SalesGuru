//
//  CustomEvent.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/9/24.
//

import UIKit

class CustomEvent {
    // MARK: - properties
    let window: UIWindow?
    
    // MARK: - variables
    var viewController: UIViewController? {
        return window?.rootViewController
    }
    
    // MARK: - init
    init(window: UIWindow?) {
        self.window = window
    }
    
    func present(view: UIViewController) {
        if let navigationController = viewController as? UINavigationController {
            navigationController.pushViewController(view, animated: true)
        } else {
            viewController?.present(view, animated: true)
        }
    }
    
    func presentDeepLink(view: UIViewController) -> Bool {
        var presented = false
        let navigationController = viewController as? UINavigationController
        if let navigationController = navigationController,
           let rootViewController = navigationController.viewControllers.first {
            if view.isKind(of: type(of:navigationController.topViewController!)) {
                return true
            } else if rootViewController is HomeVC {
                navigationController.pushViewController(view, animated: true)
                presented = true
            }
        }
        return presented
    }
}
