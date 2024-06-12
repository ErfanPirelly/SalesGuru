//
//  CreateLeadMainVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/4/24.
//

import UIKit

class CreateLeadMainVC: UIViewController {
    // MARK: - properties
    private let customView = CreateLeadMainView()
    private let viewModel = CreateLeadVM()
    
    // keyboard
    private let keyboardManager = KeyboardManager()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupKeyboardManager()
    }
    
    // MARK: - prepare UI
    private func prepareUI() {
        view.addSubview(customView)
        customView.delegate = self
        customView.pinToEdge(on: view)
    }
    
    private func setupKeyboardManager() {
        keyboardManager.inputAccessoryView = view
        keyboardManager.bind(inputAccessoryView: view)
    }
}

// MARK: - view delegate
extension CreateLeadMainVC: CreateLeadMainViewDelegate {
    func submitButtonDidTouched(with profile: IMLeadProfileInfo, setting: IMLeadAISetting) {
        viewModel.createLead(with: profile, aiSetting: setting) { [weak self] error in
            guard let self = self else { return }
            self.customView.stopLoading()
            if error == nil {
                self.dismiss(animated: true)
            } else {
                self.showError(message: error!.localizedDescription)
            }
        }
    }
    
    func stateDidUpdated(to state: CreateLeadMainView.State) {
        let presenter = presentationController
        presenter?.containerViewWillLayoutSubviews()
        presenter?.containerViewDidLayoutSubviews()
    }
}
