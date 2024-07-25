//
//  DisableAIVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/2/24.
//

import UIKit

protocol DisableAIVCDelegate: AnyObject {
    func toggleTempAI()
}

class DisableAIVC: UIViewController {
    // MARK: - properties
    private let customView = DisableAIView()
    private let userManager: UserManager = inject()
    weak var delegate: DisableAIVCDelegate?
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    // MARK: - prepare UI
    private func prepareUI() {
        customView.delegate = self
        view.addSubview(customView)
        customView.pinToEdge(on: view)
    }
}

// MARK: - DisableAIViewDelegate
extension DisableAIVC: DisableAIViewDelegate {
    func didTapCancelButton() {
        dismiss(animated: true)
    }
    
    func didTapSubmitButton(with checkBoxActive: Bool) {
        userManager.tempAIDisableConfirmation = checkBoxActive
        delegate?.toggleTempAI()
        dismiss(animated: true)
    }
}
