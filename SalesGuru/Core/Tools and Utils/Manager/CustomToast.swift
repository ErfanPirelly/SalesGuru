//
//  CustomToast.swift
//  Pirelly
//
//  Created by shndrs on 8/12/23.
//

import UIKit
import Toast_Swift

final class CustomToast: NSObject {
    private var view: UIView!
    
    init(view: UIView) {
        self.view = view
    }
}

// MARK: - Methods

extension CustomToast {
    
    func show(error message: String?,_ duration: TimeInterval = ToastManager.shared.duration) {
        var style = ToastStyle()
        style.backgroundColor = .ui.cancel
        style.titleFont = .Fonts.bold(17)
        style.messageFont = .Fonts.normal(14)
        style.titleAlignment = .center
        style.messageAlignment = .center
        style.messageColor = .ui.white
        style.titleColor = .ui.white
        style.maxWidthPercentage = 0.94
        self.view.makeToast(message ?? "Unknown Error!", duration: duration,
                            position: .bottom,
                            title: "Error",
                            style: style, completion: nil)
    }
    
    func showMessageOnTop(error message: String?,_ duration: TimeInterval = ToastManager.shared.duration) {
        var style = ToastStyle()
        style.backgroundColor = .ui.cancel
        style.titleFont = .Fonts.bold(17)
        style.messageFont = .Fonts.normal(14)
        style.titleAlignment = .center
        style.messageAlignment = .center
        style.messageColor = .ui.white
        style.titleColor = .ui.white
        style.maxWidthPercentage = 0.94
        self.view.makeToast(message ?? "Unknown Error!", duration: duration,
                            position: .top,
                            title: "Error",
                            style: style, completion: nil)
    }
    
    func show(information message: String, duration: TimeInterval = 8.0) {
        var style = ToastStyle()
        style.backgroundColor = .ui.primaryBlue ?? .ui.set
        style.titleFont = .Fonts.semiBold(10)
        style.messageFont = .Fonts.semiBold(10)
        style.titleAlignment = .center
        style.messageAlignment = .center
        style.messageColor = .ui.white
        style.titleColor = .ui.white
        self.view.makeToast(message, duration: duration,
                            position: .bottom,
                            title: nil,
                            style: style)
    }
    
    func success(message: String, duration: TimeInterval = 5) {
        var style = ToastStyle()
        style.backgroundColor = .ui.green ?? .green
        style.titleFont = .Fonts.semiBold(10)
        style.messageFont = .Fonts.semiBold(10)
        style.titleAlignment = .center
        style.messageAlignment = .left
        style.imageSize = .init(width: 20, height: 13.67)
        style.messageColor = .ui.white
        style.titleColor = .ui.white
        self.view.makeToast(message,
                            duration: duration,
                            position: .bottom,
                            title: nil,
                            style: style)
    }
    
}

