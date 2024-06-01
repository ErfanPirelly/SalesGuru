//
//  PersonalInformationVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/1/24.
//

import UIKit
import FirebaseAuth

class PersonalInformationVC: AuthViewController {
    // MARK: - properties
    private let validator = UserInfoValidator()
    private let auth: AuthManager = inject()
    private var info: IMPersonalInformation
    
    //MARK: - UI
    private lazy var customView = PersonalInfoView()
        
    //MARK: - Variables
    override var prefersHomeIndicatorAutoHidden: Bool {
        true
    }
    // MARK: - init
    init(info: IMPersonalInformation) {
        self.info = auth.checkUserInfo(info: info)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.delegate = self
        customView.privacyLabel.delegate = self
        view.addSubview(customView)
        customView.pinToEdge(on: view)
    }
}

extension PersonalInformationVC: PersonalInfoViewDelegate {
    func submitButtonDidTouched(with firstName: String, lastName: String, privacyAccepted: Bool, sender: UIButton) {
        sender.lock()
        hideTextFieldMessages()
        self.validate(inputs: .init(name: firstName,
                                    lastName: lastName,
                                    privacyAccepted: privacyAccepted),
                      sender: sender)
    }
    
    func signInButtonDidTouched() {
        
    }
    
    func hideTextFieldMessages() {
        customView.firstnameTextField.clearError()
        customView.lastnameTextField.clearError()
        customView.privacyLabel.hideErrorBorder()
        customView.setTermsLabel(color: .ui.primaryBlue)
    }
    
    func error(in box: UserInfoValidator.TextFields,
               message: String) {
        if let view = getView(for: box), box != .privacyMarked {
            (view as? AuthTextFieldBox)?.showError()
        } else if box == .privacyMarked {
            customView.setTermsLabel(color: .ui.red)
        }
    }
    
    func getView(for box: UserInfoValidator.TextFields) -> UIView? {
        switch box {
        case .name:
            return customView.firstnameTextField
        case .lastName:
            return customView.lastnameTextField
            
        case .privacyMarked:
            return customView.privacyLabel
        }
    }
    
    func validate(inputs: IMPersonalInformation, sender: UIButton) {
        if let error = validator.validate(inputs: inputs), let box = validator.box {
            sender.unlock()
            self.error(in: box, message: error.localizedDescription)
        } else {
            // company information
        }
    }
}

extension PersonalInformationVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "terms"{
            self.action?(.terms)
        } else if URL.absoluteString == "privacy" {
            self.action?(.privacy)
        }
        return false
     }
}

