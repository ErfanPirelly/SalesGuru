//
//  RegisterWithEmailPasswordView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/27/24.
//
import UIKit

protocol RegisterViewDelegate: LoginViewDelegate {
    func signUpButtonDidTouched(sender: UIButton, email: String, password: String)
    func signInDidTouched()
}

extension RegisterViewDelegate {
    func signUpDidTouched() {}
    func signInButtonDidTouched(sender: UIButton, email: String, password: String) {}
    func signInWithGoogleDidTouched(sender: UIButton) {}
    func signInWithAppleDidTouched(sender: UIButton) {}
}

class RegisterWithEmailPasswordView: UIView {
    // MARK: - properties
    private let imageView = UIImageView(image: .get(image: .login))
    private let title = UILabel(text: "Welome to Drivee 👋", font: .Quicksand.bold(24), textColor: .ui.darkColor, alignment: .center)
    private let subtitle = UILabel(text: "Please enter your mail and set password for your account", font: .Quicksand.normal(14), textColor: .ui.darkColor, alignment: .center)
    private var titleStack: UIStackView!
    private var stack: UIStackView!
    private let emailTextField = AuthTextFieldBox(placeholder: "Email", title: "Email")
    private let passwordTextField = AuthTextFieldBox(placeholder: "Password", title: "Password")
    private let submitButton = CustomButton(style: .fill, size: .init(width: 0, height: 52), textColor: .white, fillColor: .ui.primaryBlue, text: CustomText(text: "Sign Up", font: .Quicksand.semiBold(20), textColor: .white, alignment: .center))
    private var passwordShowStatusImageView: UIImageView!
    private var signUpButton: UIButton!
    
    //MARK: - Variables
    var passwordIsShown: Bool = false
    weak var delegate: RegisterViewDelegate?
    
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
        setupPasswordTextField()
        setupSubmitButton()
        setupStack()
        setupSignUpButton()
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
    
    private func setupPasswordTextField() {
        passwordTextField.textField.isSecureTextEntry = true
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: adjustHeight(for: 62, screenHeight: 853)))
        rightView.backgroundColor = .clear
        
        let gesture = UITapGestureRecognizer()
        gesture.cancelsTouchesInView = false
        gesture.addTarget(self, action: #selector(showPasswordDidTouched))
        rightView.addGestureRecognizer(gesture)
        
        passwordShowStatusImageView = UIImageView(frame: CGRect(x: 0, y: rightView.frame.height/2 - 8, width: 16, height: 16))
        passwordShowStatusImageView.image = .get(image: .passwordHide)
        passwordShowStatusImageView.contentMode = .scaleAspectFit
        rightView.addSubview(passwordShowStatusImageView)

        passwordTextField.textField.rightView = rightView
        passwordTextField.textField.rightViewMode = .always
    }
    
    private func setupStack() {
        emailTextField.textField.keyboardType = .emailAddress
        stack = .init(axis: .vertical,
                         alignment: .fill,
                         spacing: 16,
                         arrangedSubviews: [emailTextField, passwordTextField, submitButton])
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
    }
    
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(0.126 * K.size.portrait.height)
            make.centerX.equalToSuperview()
        }
        
        titleStack.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(60)
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(titleStack.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: -    @objc
extension RegisterWithEmailPasswordView {
    @objc private func showPasswordDidTouched() {
        passwordIsShown.toggle()
        passwordTextField.textField.isSecureTextEntry.toggle()
        
        if !passwordIsShown {
            passwordShowStatusImageView.image = .get(image: .passwordHide)
        } else {
            passwordShowStatusImageView.image = .get(image: .passwordVisibility)
        }
    }
    
    
    @objc private func signInButtonDidTouched() {
        self.delegate?.signInDidTouched()
    }
    
    @objc private func submitButtonDidTouched() {
        delegate?.signUpButtonDidTouched(sender: submitButton,
                                         email: emailTextField.text,
                                         password: passwordTextField.text)
    }
}
