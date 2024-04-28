//
//  InboxHeaderView.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/28/24.
//

import UIKit

class HeaderView: UIView {
    // MARK: - properties
    private let logo = UIImageView(image: .get(image: .logo1))
    private let avatar = UIImageView()
    private let searchButton = UIButton()
    private let notificationButton = UIButton()
    private var stack: UIStackView!
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - setup ui
    private func setupUI() {
        setupLogo()
        setupStackView()
        setupConstraints()
    }
    
    private func setupLogo() {
        logo.isUserInteractionEnabled = true
        logo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logoDidTouched)))
        addSubview(logo)
    }
    
    private func setupAvatar() {
        avatar.backgroundColor = .ui.silverGray
        avatar.applyCorners(to: .all, with: 10)
        avatar.isUserInteractionEnabled = true
        avatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(avatarDidTouched)))
    }
    
    private func setupNotificationButton() {
        notificationButton.backgroundColor = .ui.backgroundColor2
        notificationButton.applyCorners(to: .all, with: 10)
        notificationButton.addTarget(self, action: #selector(notificationBtnDidTouched), for: .touchUpInside)
    }
    
    private func setupSearchButton() {
        searchButton.backgroundColor = .ui.backgroundColor2
        searchButton.applyCorners(to: .all, with: 10)
        searchButton.addTarget(self, action: #selector(searchBtnDidTouched), for: .touchUpInside)
    }
    
    private func setupStackView() {
        setupSearchButton()
        setupNotificationButton()
        setupAvatar()
        
        stack = .init(axis: .horizontal, alignment: .center, distribution: .fillEqually, spacing: 22, arrangedSubviews: [searchButton, notificationButton, avatar])
        addSubview(stack)
    }
    
    private func setupConstraints() {
        searchButton.snp.makeConstraints { make in
            make.size.equalTo(44)
        }
        
        notificationButton.snp.makeConstraints { make in
            make.size.equalTo(44)
        }
        
        avatar.snp.makeConstraints { make in
            make.size.equalTo(44)
        }
        
        logo.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIView.safeArea.top + 12)
            make.bottom.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(36)
        }
        
        stack.snp.makeConstraints { make in
            make.centerY.equalTo(logo)
            make.trailing.equalToSuperview().inset(32)
        }
    }
}

private extension HeaderView {
    @objc func avatarDidTouched() {
        print("avatarDidTouched")
    }
    
    @objc func logoDidTouched() {
        print("logoDidTouched")
    }
    
    @objc func notificationBtnDidTouched() {
        print("notificationBtnDidTouched")
    }
    
    @objc func searchBtnDidTouched() {
        print("searchBtnDidTouched")
    }
}
