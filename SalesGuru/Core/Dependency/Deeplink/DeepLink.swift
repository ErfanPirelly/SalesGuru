//
//  DeepLink.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/9/24.
//

import UIKit

class DeepLinkDependency: NSObject {
    // MARK: - properties
    private var deepLink: DeepLink?
    private var unPresentedView: UIViewController?
    private let event: CustomEvent
    
    // MARK: - init
    init(event: CustomEvent) {
        self.event = event
    }
    
    // MARK: - logic
    func handleDeepLink() {
        guard let deepLink = deepLink else { return }
        if let vc = unPresentedView {
            if self.event.presentDeepLink(view: vc) {
                self.dismiss()
            }
        } else {
            switch deepLink {
            case .chat(let view):
                view.getView { vc in
                    if let vc = vc {
                        self.unPresentedView = vc
                        if self.event.presentDeepLink(view: vc) {
                            self.dismiss()
                        }
                    } else {
                        self.dismiss()
                    }
                }
            }
        }
    }
    
    func setDeepLink(deepLink: DeepLink) {
        self.deepLink = deepLink
        handleDeepLink()
    }
    
    private func dismiss() {
        self.deepLink = nil
        self.unPresentedView = nil
    }
}

enum DeepLink{
    // MARK: -  cases
    case chat(view: DeepLinkViewProtocol)
}

extension Notification {
    static var DeepLinkNotification: Notification {
        return Notification(name: .init(rawValue: "DeepLinkNotification"))
    }
}
