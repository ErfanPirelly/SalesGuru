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
}
