//
//  ChatInputBarView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/24/24.
//

import UIKit

protocol ChatInputBarViewDelegate: AnyObject {
    func sendMessage(with text: String)
    func aiTimerDidTap()
}

class ChatInputBarView: UIView {
    // MARK: - properties
    private let sendButton = UIButton(image: .init(systemName: "paperplane.fill"))
    private let aiTimerButton = UIButton(image: .get(image: .aiTimer))
    public let textView = UITextView()
    private var stack: UIStackView!
    private let emptyTextColor = UIColor(p3: "#ADB5BD")
    private let placeholder = "type something.."
    weak var delegate: ChatInputBarViewDelegate?
    
    private var buttonEnabled = false {
        didSet {
            self.sendButton.tintColor = buttonEnabled ? .ui.primaryBlue : .ui.darkColor4
            self.sendButton.isEnabled = buttonEnabled
        }
    }
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
        translatesAutoresizingMaskIntoConstraints = false
        addBorder(color: UIColor(p3: "#EDEDED"), thickness: 1)
        setupButtons()
        setupStackView()
        setupTextView()
        setupConstraints()
    }
    
    private func setupButtons() {
        aiTimerButton.tintColor = .black.withAlphaComponent(0.26)
        aiTimerButton.addTarget(self, action: #selector(aiTimerButtonDidTouched), for: .touchUpInside)
        aiTimerButton.imageEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        
        sendButton.tintColor = .ui.primaryBlue
        sendButton.addTarget(self, action: #selector(sendButtonDidTouched), for: .touchUpInside)
    }
    
    private func setupTextView() {
        textView.font = .Quicksand.semiBold(14)
        textView.textColor = emptyTextColor
        textView.text = placeholder
        textView.delegate = self
        textView.backgroundColor = .init(p3: "#F7F7FC").withAlphaComponent(0.5)
        textView.applyCorners(to: .all, with: 4)
    }
    
    private func setupStackView() {
        stack = .init(axis: .horizontal, alignment: .center, distribution: .fill, spacing: 12, arrangedSubviews: [aiTimerButton, textView, sendButton])
        addSubview(stack)
    }
    
    private func setupConstraints() {
        stack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.bottom.equalToSuperview().inset(16)
        }
        
        textView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(36)
        }
        
        aiTimerButton.snp.makeConstraints { make in
            make.size.equalTo(32)
        }
        
        sendButton.snp.makeConstraints { make in
            make.size.equalTo(32)
        }
    }
}


// MARK: - objc
extension ChatInputBarView {
    @objc private func aiTimerButtonDidTouched() {
        delegate?.aiTimerDidTap()
    }
    
    @objc private func sendButtonDidTouched() {
        guard textView.textColor == emptyTextColor else {return}
        self.delegate?.sendMessage(with: textView.text.trimmingCharacters(in: .whitespacesAndNewlines))
        self.textView.text = placeholder
        self.textView.textColor = emptyTextColor
    }
}

extension ChatInputBarView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == emptyTextColor {
            textView.text = ""
            textView.textColor = .ui.darkColor
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.buttonEnabled = !textView.text.isEmpty && textView.textColor == emptyTextColor
    }
    

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = emptyTextColor
            textView.text = placeholder
        }
    }
}
