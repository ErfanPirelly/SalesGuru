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
    func didEndTimer()
}

class ChatInputBarView: UIView {
    // MARK: - properties
    private let sendButton = UIButton(image: .init(systemName: "paperplane.fill"))
    private let aiTimerButton = UIButton(image: .get(image: .aiTimer)?.withRenderingMode(.alwaysOriginal))
    private let aiTimerLabel = UILabel(font: .Fonts.bold(8), textColor: .ui.primaryBlue, alignment: .center)
    public let textView = UITextView()
    private var stack: UIStackView!
    private let emptyTextColor = UIColor(p3: "#ADB5BD")
    private let placeholder = "type something.."
    weak var delegate: ChatInputBarViewDelegate?
    private var timer: Timer?
    private var remaining: Int?
    
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
        setupAiButton()
        sendButton.tintColor = .ui.primaryBlue
        sendButton.addTarget(self, action: #selector(sendButtonDidTouched), for: .touchUpInside)
    }
    
    func setupAiButton() {
        aiTimerButton.addTarget(self, action: #selector(aiTimerButtonDidTouched), for: .touchUpInside)
        aiTimerButton.imageEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        aiTimerLabel.isUserInteractionEnabled = false
//        aiTimesLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(aiTimerButtonDidTouched)))
        addSubview(aiTimerLabel)
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
        
        aiTimerLabel.snp.makeConstraints { make in
            make.leading.equalTo(aiTimerButton.snp.centerX)
            make.bottom.equalTo(aiTimerButton)
        }
        
        sendButton.snp.makeConstraints { make in
            make.size.equalTo(32)
        }
    }
}

// MARK: - timer
extension ChatInputBarView {
    func configTempAI(disabled: Bool, remaining: Int?) {
        self.aiTimerLabel.isHidden = !disabled
        let image: UIImage? = .get(image: disabled ? .aiDisableTimer : .aiTimer)
        self.aiTimerButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        if let time = remaining, disabled {
            self.remaining = time
            setupTimer(start: true)
        } else {
            setupTimer(start: false)
        }
    }
    
    private func setupTimer(start: Bool) {
        if !start {
            self.timer?.invalidate()
            self.timer = nil
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func timerAction() {
        guard let remaining = remaining else {
            setupTimer(start: false)
            return
        }
        
        self.remaining! -= 1
        if remaining >= 1 {
            let min = remaining / 60
            let seconds = remaining % 60
            self.aiTimerLabel.text = String(format: "%d:%02d", min, seconds)
        } else {
            self.configTempAI(disabled: false, remaining: nil)
            delegate?.didEndTimer()
        }
        
    }
}

// MARK: - objc
extension ChatInputBarView {
    @objc private func aiTimerButtonDidTouched() {
        delegate?.aiTimerDidTap()
    }
    
    @objc private func sendButtonDidTouched() {
        guard textView.textColor != emptyTextColor else {return}
        self.delegate?.sendMessage(with: textView.text.trimmingCharacters(in: .whitespacesAndNewlines))
        self.textView.text = ""
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
        self.buttonEnabled = !textView.text.isEmpty && textView.textColor != emptyTextColor
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = emptyTextColor
            textView.text = placeholder
        }
    }
}
