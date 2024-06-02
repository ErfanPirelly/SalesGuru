//
//  ConversationNavigationBarView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/24/24.
//

import UIKit

protocol ConversationNavigationBarViewDelegate: AnyObject {
    func backButtonDidTouched()
    func moreButtonDidTouched()
    func aiButtonDidTouched()
}

class ConversationNavigationBarView: UIView {
    // MARK: - properties
    private let avatarBackView = UIView()
    private let avatar = UIImageView()
    private let username = UILabel(font: .Quicksand.bold(17), textColor: .ui.black, alignment: .left)
    private let subtitle = UILabel(font: .Quicksand.medium(13), textColor: .black.withAlphaComponent(0.35), alignment: .left)
    private let backButton = UIButton(image: .get(image: .back)!.withRenderingMode(.alwaysTemplate))
    public let moreButton = NavBatButton(image: .get(image: .dots)!.withRenderingMode(.alwaysTemplate))
    private let searchButton = UIButton(image: .get(image: .search)!.withRenderingMode(.alwaysTemplate))
    private let aiButton = UIButton(image: .get(image: .folderAi)!.withRenderingMode(.alwaysTemplate))
    private var buttonsStack: UIStackView!
    private var stack: UIStackView!
    private var avatarStack: UIStackView!
    weak var delegate: ConversationNavigationBarViewDelegate?
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupUi
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white.withAlphaComponent(0.6)
        setupButtonStack()
        setupStack()
        setupAvatar()
        setupConstraints()
    }
    
    private func setupButtons() {
        [moreButton, aiButton, searchButton].forEach({
            $0.backgroundColor = .ui.primaryBlue.withAlphaComponent(0.05)
            $0.applyCorners(to: .all, with: 16)
            $0.tintColor = .ui.primaryBlue
        })
        aiButton.addTarget(self, action: #selector(aiButtonDidTouched), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(searchButtonDidTouched), for: .touchUpInside)
        setupMoreButton()
    }
    
    private func setupMoreButton() {
        moreButton.onSelected { button in
            button.backgroundColor = .ui.primaryBlue
            button.tintColor = .white
        }.onDeselected { button in
            button.backgroundColor = .ui.primaryBlue.withAlphaComponent(0.05)
            button.tintColor = .ui.primaryBlue
        }.onTouchUpInside {[weak self] _ in
            self?.moreButtonDidTouched()
        }
    }

    private func setupButtonStack() {
        setupButtons()
        buttonsStack = .init(spacing: 12, arrangedSubviews: [aiButton, searchButton, moreButton])
        addSubview(buttonsStack)
    }
    
    private func setupStack() {
        stack = .init(axis: .vertical, alignment: .leading, distribution: .equalSpacing, spacing: 5, arrangedSubviews: [username, subtitle])
        addSubview(stack)
    }
    
    private func setupAvatar() {
        backButton.addTarget(self, action: #selector(backButtonDidTouched), for: .touchUpInside)
        backButton.tintColor = .ui.primaryBlue
        backButton.imageEdgeInsets = .init(top: 8, left: 11.33, bottom: 8, right: 11.33)
        
        avatarBackView.translatesAutoresizingMaskIntoConstraints = false
        avatarBackView.applyCorners(to: .all, with: 10)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatarBackView.addSubview(avatar)
        
        avatarStack = .init(axis: .horizontal, distribution: .equalSpacing, spacing: 4, arrangedSubviews: [backButton, avatarBackView])
        addSubview(avatarStack)
    }
    
    private func setupConstraints() {
        [moreButton, aiButton, searchButton, backButton].forEach({
            $0.snp.makeConstraints { make in
                make.size.equalTo(32)
            }
        })
        
        avatarStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(UIView.topOrLeftSafeAreaConstant + 8)
            make.bottom.equalToSuperview().inset(12)
        }
        
        avatarBackView.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
        
        avatar.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(avatarStack).inset(3)
            make.leading.equalTo(avatarStack.snp.trailing).offset(14)
        }
        
        buttonsStack.snp.makeConstraints { make in
            make.centerY.equalTo(avatarStack)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    func config(with chat: RMChat) {
        self.username.text = chat.name
        self.subtitle.text = chat.leadState?.title ?? ""
        fillImageView(with: chat.leadState ?? .cold)
    }
    
    private func fillImageView(with lead: LeadState) {
        avatar.image = lead.image
        avatar.tintColor = .white
        avatarBackView.backgroundColor = lead.color
    }
}

// MARK: - @objc
extension ConversationNavigationBarView {
    @objc private func backButtonDidTouched() {
        delegate?.backButtonDidTouched()
    }
    
    @objc private func moreButtonDidTouched() {
        delegate?.moreButtonDidTouched()
    }
    
    @objc private func searchButtonDidTouched() {
        
    }
    
    @objc private func aiButtonDidTouched() {
        delegate?.aiButtonDidTouched()
    }
}
