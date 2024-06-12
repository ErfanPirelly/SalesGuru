//
//  AuthTextView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/5/24.
//
import UIKit

class BoxTextView: UITextView {
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

class AuthTextView: UIView {
    let textView = BoxTextView()
    let title = UILabel(font: .Quicksand.normal(12), textColor: UIColor(p3: "#8B8989"), alignment: .center)
    var textColor = UIColor.ui.darkColor
    var placeholderColor = UIColor.ui.silverGray3
    
    private let borderColor = UIColor(p3: "#E0E4F5")
    private var placeholder = ""
    
    var text: String {
        set {
            self.textView.text = newValue
        }
        
        get {
            self.textView.text ?? ""
        }
    }
    
    // MARK: - init
    init(placeholder: String, title: String) {
        super.init(frame: .zero)
        self.title.text = title
        self.placeholder = placeholder
        textView.responderDelegate = self
        textView.text = placeholder
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup UI
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        title.isHidden = true
        
        addSubview(textView)
        addSubview(title)

        textView.backgroundColor = .init(p3: "#F7F7FC")
        textView.applyCorners(to: .all, with: 18)
        textView.textColor = placeholderColor
        textView.textAlignment = .left
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.font = .Quicksand.semiBold(14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.contentInset.left = 24
        textView.contentInset.right = 24
        textView.delegate = self
        
        textView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(title.snp.centerY)
            make.height.greaterThanOrEqualTo(141)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(24)
            make.leading.equalToSuperview().inset(24)
        }
    }
    
    func showError() {
        self.textView.layer.borderColor = UIColor.ui.red.cgColor
        self.title.isHidden = false
        self.title.textColor = .ui.red
    }
    
    func clearError() {
        self.textView.layer.borderColor = borderColor.cgColor
        self.title.isHidden = true
        self.title.textColor = UIColor(p3: "#8B8989")
    }
    
    override func becomeFirstResponder() -> Bool {
        _ = self.textView.becomeFirstResponder()
        return super.becomeFirstResponder()
    }
}

// MARK: - responder delegate
extension AuthTextView: TextFieldResponderDelegate {
    func didBecomeFirstResponder() {
        self.textView.layer.borderColor = UIColor.ui.primaryBlue.cgColor
        self.title.textColor = UIColor(p3: "#8B8989")
        self.title.isHidden = false
    }
    
    func didResignFirstResponder() {
        self.textView.layer.borderColor = borderColor.cgColor
        self.title.isHidden = true
        self.title.textColor = UIColor(p3: "#8B8989")
    }
}

// MARK: - text view delegate
extension AuthTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == placeholderColor {
            textView.text = ""
            textView.textColor = textColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = placeholderColor
            textView.text = placeholder
        }
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
    }
}
