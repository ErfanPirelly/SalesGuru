//
//  AuthVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/25/24.
//

import UIKit


class AuthViewController: UIViewController, UserFlowPresenter {
    // MARK: - properties
    var didLoad: Action?
    var action: ((UserFlow) -> Void)!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.action = { [weak self] action in
            guard let self = self else { return }
            switch action {
            case .home:
                presentHome()
            default: return
            }
        }
    }
    
    private func presentHome() {
        let view = HomeVC()
        let navigation = CleanNavigation(rootViewController: view)
        self.view.window?.switchRootViewController(navigation, options: .curveEaseInOut)
    }
}
