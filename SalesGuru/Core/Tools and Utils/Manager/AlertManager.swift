//
//  AlertManager.swift
//  Pirelly
//
//  Created by shndrs on 8/31/23.
//

import UIKit

final class AlertManager: NSObject {
    
    static let `default` = AlertManager()
    
    private override init() {}
    
}

// MARK: - Methods

extension AlertManager {
    
    public func show(title: String = "Something went wrong!",
                     message: String,
                     callback: @escaping Action) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "OK",
                               style: .destructive) {
            (action) in
            alertController.dismiss(animated: true)
            callback()
        }
        alertController.addAction(ok)
        alertController.view.tintColor = .gray
        topViewController()?.present(alertController, animated: true)
    }
    
    public func show(title: String,
                     message: String,
                     confirmText: String,
                     callback: @escaping Action,
                     cancelCallback: Action? = nil) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let cancel = UIAlertAction(title: "No",
                                   style: .destructive) {
            (action) in
            cancelCallback?()
            alertController.dismiss(animated: true)
        }
        let confirm = UIAlertAction(title: confirmText,
                                    style: .default) {
            (action) in
            callback()
        }
        alertController.addAction(confirm)
        alertController.addAction(cancel)
        alertController.view.tintColor = .ui.darkColor
        topViewController()?.present(alertController, animated: true)
    }
    
    private func topViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
}
