//
//  LoginVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/24/24.
//

import UIKit

class LoginVC: AuthViewController {
    // MARK: - properties
    private let customView = LoginView()
    private let viewModel = LoginVM()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - prepare UI
    private func prepareUI() {
        view.addSubview(customView)
        customView.pinToEdge(on: view)
        customView.delegate = self
    }
}

extension LoginVC: LoginViewDelegate {
    func signInButtonDidTouched(sender: UIButton, email: String, password: String) {
        sender.lock()
        self.viewModel.login(with: .init(email: email, password: password)) { [weak self] response, error in
            guard let self = self else { return }
            sender.unlock()
            if error == nil {
                self.parseAuthData(with: .success(response))
            } else {
                self.showError(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func signInWithGoogleDidTouched(sender: UIButton) {
        
    }
    
    func signInWithAppleDidTouched(sender: UIButton) {
        
    }
    
    func signUpDidTouched() {
        
    }
}
