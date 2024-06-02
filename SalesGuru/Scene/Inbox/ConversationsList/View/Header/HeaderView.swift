//
//  InboxHeaderView.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/28/24.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func didSelectNotification()
    func didSelectSetting()
}

class HeaderView: UIView {
    // MARK: - properties
    private let indicator = UIActivityIndicatorView(style: .medium)
    private let avatar = UIButton(type: .system)
    private let label = UILabel(text: "Chats", font: .Quicksand.bold(30), textColor: .white, alignment: .left)
    private let settingButton = UIButton(image: .get(image: .setting)!.withRenderingMode(.alwaysOriginal))
    private let notificationButton = UIButton(image: .get(image: .notification)!.withRenderingMode(.alwaysTemplate))
    private var stack: UIStackView!
    private var avatarStack: UIStackView!
    private let maskImage = UIImageView(image: .get(image: .headerShape))
    weak var delegate: HeaderViewDelegate?
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup ui
    private func setupUI() {
        setupStackView()
        setupAvatarStack()
        setupConstraints()
    }

    private func prepareUI() {
        backgroundColor = .ui.primaryBlue
        applyCorners(to: .bottom, with: 50)
        maskImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(maskImage)
        maskImage.pinToEdge(on: self)
    }
    
    private func setupActivityIndicator() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.tintColor = .ui.primaryBlue
        indicator.color = .ui.primaryBlue
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        avatar.addSubview(indicator)
    }
    
    private func setupAvatar() {
        setupActivityIndicator()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.backgroundColor = .white
        avatar.applyCorners(to: .all, with: 10)
        avatar.addTarget(self, action: #selector(avatarDidTouched), for: .touchUpInside)
    }
    
    private func setupNotificationButton() {
        notificationButton.backgroundColor = .black.withAlphaComponent(0.04)
        notificationButton.tintColor = .white
        notificationButton.applyCorners(to: .all, with: 10)
        notificationButton.addTarget(self, action: #selector(notificationBtnDidTouched), for: .touchUpInside)
    }
    
    private func setupSearchButton() {
        settingButton.backgroundColor = .black.withAlphaComponent(0.04)
        settingButton.applyCorners(to: .all, with: 10)
        settingButton.addTarget(self, action: #selector(settingBtnDidTouched), for: .touchUpInside)
    }
    
    private func setupStackView() {
        setupSearchButton()
        setupNotificationButton()
        setupAvatar()
        stack = .init(axis: .horizontal, alignment: .center, distribution: .fillEqually, spacing: 12, arrangedSubviews: [notificationButton, settingButton])
        addSubview(stack)
    }
    
    private func setupAvatarStack() {
        avatarStack = .init(spacing: 12, arrangedSubviews: [avatar, label])
        addSubview(avatarStack)
    }
    
    private func setupConstraints() {
        settingButton.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
        
        notificationButton.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
        
        avatar.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
        
        avatarStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIView.safeArea.top + 12)
            make.bottom.equalToSuperview().inset(38)
            make.leading.equalToSuperview().inset(24)
        }
        
        stack.snp.makeConstraints { make in
            make.centerY.equalTo(avatarStack)
            make.trailing.equalToSuperview().inset(24)
        }
        
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func stopIndicator() {
        self.indicator.stopAnimating()
    }
}

private extension HeaderView {
    @objc func avatarDidTouched() {
        print("avatarDidTouched")
    }
    
    @objc func notificationBtnDidTouched() {
        delegate?.didSelectNotification()
    }
    
    @objc func settingBtnDidTouched() {
        delegate?.didSelectSetting()
    }
}
