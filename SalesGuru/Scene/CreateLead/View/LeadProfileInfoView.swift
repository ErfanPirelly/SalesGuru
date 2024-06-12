//
//  LeadProfileInfoView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/5/24.
//

import UIKit

class LeadProfileInfoView: UIView {
    // MARK: - properties
    private let fullNameTextField = AuthTextFieldBox(placeholder: "Full Name", title: "Full Name")
    private let phoneNumberTextField = AuthTextFieldBox(placeholder: "Phone Number", title: "Phone")
    private let emailTextField = AuthTextFieldBox(placeholder: "Email (Optional)", title: "Email")
    private var stack: UIStackView!
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup UI
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        setupStack()
        setupConstraints()
    }
    
    private func setupStack() {
        emailTextField.textField.keyboardType = .emailAddress
        phoneNumberTextField.textField.keyboardType = .phonePad
        stack = .init(axis: .vertical, alignment: .fill, distribution: .equalSpacing, spacing: 17, arrangedSubviews: [fullNameTextField, phoneNumberTextField, emailTextField])
        
        addSubview(stack)
    }
    
    private func setupConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(265)
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
        }
    }
    
    func getValue() -> IMLeadProfileInfo? {
        let name = fullNameTextField.text
        let phone = phoneNumberTextField.text
        let email = emailTextField.text
        var data: IMLeadProfileInfo?
        let textValidator = Validator.textLimit(min: 3, max: nil)
        let phoneValidator = Validator.phone
        let emailValidator = Validator.email
        
        if !textValidator.validate(value: name) {
            self.fullNameTextField.showError()
            CustomToast(view: self).show(error: "name must be greater than 3")
        } else if !phoneValidator.validate(value: phone) {
            self.phoneNumberTextField.showError()
            CustomToast(view: self).show(error: "Wrong number")
            
        } else if !email.isEmpty && !emailValidator.validate(value: email){
            self.emailTextField.showError()
            CustomToast(view: self).show(error: "Invalid Email")
            
        } else {
            self.fullNameTextField.clearError()
            self.phoneNumberTextField.clearError()
            data = .init(fullName: name, phoneNumber: phone, email: emailTextField.text)
        }
        return data
    }
}
