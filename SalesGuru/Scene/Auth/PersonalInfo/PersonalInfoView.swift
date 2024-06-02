//
//  PersonalInfoView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/27/24.
//

import UIKit
import M13Checkbox

protocol PersonalInfoViewDelegate: AnyObject {
    func submitButtonDidTouched(with firstName: String, lastName: String,
                                privacyAccepted: Bool,
                                sender: UIButton)
    func signInButtonDidTouched()
}

class PersonalInfoView: UIView {
    // MARK: - properties
    private let imageView = UIImageView(image: .get(image: .personalInfo))
    private let title = UILabel(text: "Enter Your personal info", font: .Quicksand.bold(24), textColor: .ui.darkColor, alignment: .center)
    private let subtitle = UILabel(text: "Please confirm your country code and enter your phone number", font: .Quicksand.light(14), textColor: .ui.darkColor, alignment: .center)
    private var titleStack: UIStackView!
    private var stack: UIStackView!
    public let firstnameTextField = AuthTextFieldBox(placeholder: "Fist Name", title: "name")
    public let lastnameTextField = AuthTextFieldBox(placeholder: "Last Name", title: "Last Name")
    private let submitButton = CustomButton(style: .fill, size: .init(width: 0, height: 52), textColor: .white, fillColor: .ui.primaryBlue, text: Text(text: "Submit", font: .Quicksand.semiBold(20), textColor: .white, alignment: .center))
    private var signUpButton: UIButton!
    private var privacyCheckBox: M13Checkbox!
    public var privacyLabel: UITextView!
    private var privacyStackView: UIStackView!
    weak var delegate: PersonalInfoViewDelegate?
    
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
        backgroundColor = .white
        setupImageView()
        setupTitleStack()
        setupSubmitButton()
        setupStack()
        setupSignUpButton()
        setupPrivacyStackView()
        setupConstraints()
    }
    
    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
    }
    
    private func setupTitleStack() {
        subtitle.numberOfLines = 2
        titleStack = .init(axis: .vertical, alignment: .center, distribution: .equalSpacing, spacing: 8, arrangedSubviews: [title, subtitle])
        addSubview(titleStack)
    }
    
    private func setupStack() {
        stack = .init(axis: .vertical,
                         alignment: .fill,
                         spacing: 16,
                         arrangedSubviews: [firstnameTextField, lastnameTextField])
        addSubview(stack)
    }
    
    private func setupSignUpButton() {
        let attr = "Have an Account? <em>Sign In</em>"
            .highlightingTag("em", font: .Quicksand.semiBold(12), color: .ui.primaryBlue)
        signUpButton = UIButton(type: .system, attributedTitle: attr, titleColor: .ui.darkColor4.withAlphaComponent(0.72), font: .Quicksand.medium(12))
        
        signUpButton.addTarget(self, action: #selector(signInButtonDidTouched), for: .touchUpInside)
        addSubview(signUpButton)
    }
    
    private func setupSubmitButton() {
        submitButton.addTarget(self, action: #selector(submitButtonDidTouched), for: .touchUpInside)
        addSubview(submitButton)
    }
    
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(0.126 * K.size.portrait.height)
            make.centerX.equalToSuperview()
        }
        
        titleStack.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(45)
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(titleStack.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        privacyStackView.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(24)
            make.leading.trailing.equalTo(stack)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(privacyStackView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(stack)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(submitButton.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - privacy view
extension PersonalInfoView {
    private func setupPrivacyStackView() {
        setupPrivacyCheckBox()
        setupPrivacyLabel()
        privacyStackView = UIStackView(alignment: .top,
                                       distribution: .fill,
                                       spacing: 10,
                                       arrangedSubviews: [privacyCheckBox, privacyLabel])
        addSubview(privacyStackView)
    }
    
    
    private func setupPrivacyCheckBox() {
        privacyCheckBox = M13Checkbox()
        privacyCheckBox.translatesAutoresizingMaskIntoConstraints = false
        privacyCheckBox.boxType = .square
        privacyCheckBox.markType = .checkmark
        privacyCheckBox.tintColor = .ui.primaryBlue
        privacyCheckBox.layer.borderColor = UIColor.ui.primaryBlue.cgColor
        privacyCheckBox.secondaryTintColor = .ui.primaryBlue
        privacyCheckBox.secondaryCheckmarkTintColor = .white
        privacyCheckBox.boxLineWidth = 2
        
        privacyCheckBox.snp.makeConstraints { make in
            make.size.equalTo(18)
        }
    }
    
    private func setupPrivacyLabel() {
        privacyLabel = UITextView()
        privacyLabel.backgroundColor = .clear
        privacyLabel.isScrollEnabled = false
        privacyLabel.isEditable = false
        privacyLabel.isUserInteractionEnabled = true
        privacyLabel.translatesAutoresizingMaskIntoConstraints = false
        privacyLabel.font = .Quicksand.medium(13)
        setTermsLabel(color: .ui.primaryBlue)
        privacyLabel.sizeToFit()
        privacyLabel.textContainerInset.top = 0
        privacyLabel.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(34)
        }
    }
    
    func setTermsLabel(color: UIColor) {
        let text = "I Agree With Privacy Policy And Terms \nof Service  In Pirelly"
        let regularText = NSMutableAttributedString(string: text,
                                                    attributes: [NSAttributedString.Key.font: UIFont.Quicksand.medium(13),
                                                                 NSAttributedString.Key.foregroundColor: UIColor.ui.darkColor4.withAlphaComponent(0.72)])
        let range1 = (text as NSString).range(of: "Terms \nof Service")
        let range2 = (text as NSString).range(of: "Privacy Policy")
        regularText.addAttribute(NSAttributedString.Key.link, value: "terms", range: range1)
        regularText.addAttribute(NSAttributedString.Key.link, value: "privacy", range: range2)
        regularText.addAttribute(NSAttributedString.Key.font, value: UIFont.Quicksand.bold(12), range: range1)
        regularText.addAttribute(NSAttributedString.Key.font, value: UIFont.Quicksand.bold(12), range: range2)
        regularText.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range1)
        regularText.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range2)
        privacyLabel.linkTextAttributes = [NSAttributedString.Key.foregroundColor: color]
        privacyLabel.attributedText = regularText
        privacyCheckBox.tintColor = color
        privacyCheckBox.layer.borderColor = color.cgColor
        privacyCheckBox.secondaryTintColor = color
    }
}


// MARK: - @objc
extension PersonalInfoView {
    @objc private func signInButtonDidTouched() {
        delegate?.signInButtonDidTouched()
    }
    
    @objc private func submitButtonDidTouched() {
        delegate?.submitButtonDidTouched(with: firstnameTextField.text,
                                         lastName: lastnameTextField.text,
                                         privacyAccepted: privacyCheckBox.checkState == .checked,
                                         sender: submitButton
                                         
        )
    }
}

