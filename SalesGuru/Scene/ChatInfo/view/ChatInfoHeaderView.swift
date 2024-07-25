//
//  ChatInfoHeaderView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/14/24.
//

import UIKit

protocol ChatInfoHeaderViewDelegate: AnyObject {
    func emailButtonDidTouched()
    func phoneButtonDidTouched()
    func backButtonDidTouched()
}

class ChatInfoHeaderView: UIView {
    // MARK: - properties
    private let backButton = UIButton(image: .get(image: .back)?.withRenderingMode(.alwaysTemplate))
    private let imageView = UIImageView()
    private let backImageView = GradientView()
    private let usernameLabel = UILabel(font: .Quicksand.bold(24), textColor: .white, alignment: .center)
    private let emailLabel = UILabel(font: .Fonts.medium(12), textColor: .white, alignment: .left)
    private let phoneLabel = UILabel(font: .Fonts.medium(12), textColor: .white, alignment: .left)
    private var stack: UIStackView!
    private var buttonStack: UIStackView!
    weak var delegate: ChatInfoHeaderViewDelegate?
    
    
    private lazy var emailButton: UITextImageButton = {
        let btn = UITextImageButton(image: .get(image: .email), label: emailLabel)
        btn.applyCorners(to: .all, with: 4)
        btn.backgroundColor = .white.withAlphaComponent(0.05)
        btn.iconColor = .white
        btn.stackSpacing = 10
        btn.edgeSpacing = .init(top: 8, left: 8, bottom: -8, right: 24)
        btn.setupUI(axis: .horizontal, iconPosition: .left, distribution: .equalSpacing)
        return btn
    }()
    
    private lazy var phoneButton: UITextImageButton = {
        let btn = UITextImageButton(image: .get(image: .phone), label: phoneLabel)
        btn.applyCorners(to: .all, with: 4)
        btn.backgroundColor = .white.withAlphaComponent(0.05)
        btn.iconColor = .white
        btn.stackSpacing = 10
        btn.edgeSpacing = .init(top: 8, left: 8, bottom: -8, right: 24)
        btn.setupUI(axis: .horizontal, iconPosition: .left, distribution: .equalSpacing)
        return btn
    }()
    private var primaryColor: UIColor = .ui.primaryBlue {
        didSet {
            self.backgroundColor = primaryColor
            self.backImageView.startColor = primaryColor
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
        applyCorners(to: .bottom, with: 40)
        setupStack()
        setupBackButton()
        setupConstraints()
    }
    
    
    private func setupStack() {
        setupButtons()
        setupIcon()
        stack = .init(axis: .vertical, alignment: .center, distribution: .equalSpacing, spacing: 10, arrangedSubviews: [
            backImageView,
            usernameLabel,
            buttonStack
        ])
        stack.setCustomSpacing(18, after: usernameLabel)
        addSubview(stack)
    }
    
    private func setupIcon() {
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        backImageView.applyCorners(to: .all, with: 20)
        backImageView.addBorder(color: .white, thickness: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        backImageView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(24)
            make.size.equalTo(48)
        }
    }
    
    private func setupButtons() {
        buttonStack = .init(distribution: .fillEqually, spacing: 8, arrangedSubviews: [emailButton, phoneButton])
        emailButton.addTarget(self, action: #selector(emailButtonDidTouched), for: .touchUpInside)
        phoneButton.addTarget(self, action: #selector(phoneButtonDidTouched), for: .touchUpInside)
    }
    
    private func setupBackButton() {
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(backButtonDidTouched), for: .touchUpInside)
        addSubview(backButton)
    }
    
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIView.topOrLeftSafeAreaConstant + 12)
            make.leading.equalToSuperview().inset(12)
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(backButton)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(32)
        }
    }
    
    
    func config(view with: UIMChatInfo) {
        self.usernameLabel.text = with.userName
        self.emailLabel.text = with.email
        self.phoneLabel.text = with.phone
        
        self.imageView.image = with.lead.image
        self.primaryColor = with.lead.color
        self.backImageView.endColor = with.lead.secondaryColor
    }
    
    func loading(is loading: Bool) {
        if loading {
            self.backImageView.lock()
        } else {
            self.backImageView.unlock()
        }
    }
}

// MARK: - objc
extension ChatInfoHeaderView {
    @objc private func emailButtonDidTouched() {
        delegate?.emailButtonDidTouched()
    }
    
    @objc private func phoneButtonDidTouched() {
        delegate?.phoneButtonDidTouched()
    }
    
    @objc private func backButtonDidTouched() {
        delegate?.backButtonDidTouched()
    }
}
