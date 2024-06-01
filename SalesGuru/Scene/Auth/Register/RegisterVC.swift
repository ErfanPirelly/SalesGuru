//
//  RegisterVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/1/24.
//

import UIKit

class RegisterVC: AuthViewController {
    // MARK: - properties
    private let customView = RegisterWithEmailPasswordView()
    private let viewModel = RegisterVM()
    
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

extension RegisterVC: RegisterViewDelegate {
    func signUpButtonDidTouched(sender: UIButton, email: String, password: String) {
        sender.lock()
        self.viewModel.register(with: .init(email: email, password: password)) { [weak self] response, error in
            guard let self = self else { return }
            sender.unlock()
            if error == nil {
                self.parseAuthData(with: .success(response))
            } else {
                self.showError(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func signInDidTouched() {
        
    }
}
