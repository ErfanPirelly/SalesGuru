//
//  AuthTextFieldBox.swift
//  Pirelly
//
//  Created by mmdMoovic on 10/27/23.
//

import UIKit

protocol TextFieldResponderDelegate: AnyObject {
    func didBecomeFirstResponder()
    func didResignFirstResponder()
}

class BoxTextField: UITextField {
    weak var responderDelegate: TextFieldResponderDelegate?
    
    override func becomeFirstResponder() -> Bool {
        responderDelegate?.didBecomeFirstResponder()
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        responderDelegate?.didResignFirstResponder()
        return super.resignFirstResponder()
    }
}

class AuthTextFieldBox: UIView {
    let textField = BoxTextField()
    let title = UILabel(font: .Quicksand.normal(12), textColor: UIColor(p3: "#8B8989"), alignment: .center)
    private let borderColor = UIColor(p3: "#E0E4F5")
    
    var text: String {
        set {
            self.textField.text = newValue
        }
        
        get {
            self.textField.text ?? ""
        }
    }
    
    // MARK: - init
    init(placeholder: String, title: String) {
        super.init(frame: .zero)
        self.title.text = title
        textField.responderDelegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.ui.silverGray3
            ]
        )
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup UI
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        title.isHidden = true
        
        addSubview(textField)
        addSubview(title)

        textField.backgroundColor = .init(p3: "#F7F7FC")
        textField.applyCorners(to: .all, with: 18)
        textField.textColor = .ui.darkColor
        textField.textAlignment = .left
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.font = .Quicksand.semiBold(14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 62))
        leftView.backgroundColor = .clear
        
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        textField.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(title.snp.centerY)
            make.height.equalTo(52)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(24)
            make.leading.equalToSuperview().inset(24)
        }
    }
    
    func showError() {
        self.textField.layer.borderColor = UIColor.ui.red.cgColor
        self.title.isHidden = false
        self.title.textColor = .ui.red
    }
    
    func clearError() {
        self.textField.layer.borderColor = borderColor.cgColor
        self.title.isHidden = true
        self.title.textColor = UIColor(p3: "#8B8989")
    }
}

extension AuthTextFieldBox: TextFieldResponderDelegate {
    func didBecomeFirstResponder() {
        self.textField.layer.borderColor = UIColor.ui.primaryBlue.cgColor
        self.title.textColor = UIColor(p3: "#8B8989")
        self.title.isHidden = false
    }
    
    func didResignFirstResponder() {
        self.textField.layer.borderColor = borderColor.cgColor
        self.title.isHidden = true
        self.title.textColor = UIColor(p3: "#8B8989")
    }
    
    
}
