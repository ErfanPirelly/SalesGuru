//
//  LeadProfileInfoView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/5/24.
//

import UIKit

class LeadProfileInfoView: UIView {
    // MARK: - properties
    public let fullNameTextField = AuthTextFieldBox(placeholder: "Full Name", title: "Full Name")
    public let phoneNumberTextField = AuthTextFieldBox(placeholder: "Phone Number", title: "Phone")
    public let emailTextField = AuthTextFieldBox(placeholder: "Email (Optional)", title: "Email")
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
}
