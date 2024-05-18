//
//  ConversationUserView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/30/24.
//

import UIKit

protocol ConversationUserViewDelegate: AnyObject {
    func didTapMoreButton()
}

class ConversationUserView: UIView {
    // MARK: - properties
    private let statusView = UIView()
    private let avatar = UIImageView()
    private let title = UILabel(font: .Fonts.bold(16), textColor: .ui.darkColor, alignment: .left)
    private let dateLabel = UILabel(font: .Fonts.bold(12), textColor: .ui.darkColor.withAlphaComponent(0.8), alignment: .left)
    private let moreButton = UIButton(image: .get(image: .dots)!.withRenderingMode(.alwaysTemplate))
    private var stack: UIStackView!
    weak var delegate: ConversationUserViewDelegate?
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupui
    private func setupUI() {
        backgroundColor = .clear
        setupAvatar()
        setupStatusView()
        setupStackView()
        setupMoreButton()
        setupConstraints()
    }
    
    private func setupAvatar() {
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.backgroundColor = .ui.primaryBlue
        avatar.applyCorners(to: .all, with: 10)
        addSubview(avatar)
    }
    
    private func setupStatusView() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.applyCorners(to: .all, with: 4)
        statusView.backgroundColor = .ui.green
        view.applyCorners(to: .all, with: 6)
        view.backgroundColor = .white
        view.addSubview(statusView)
        addSubview(view)
    }
    
    private func setupStackView() {
        stack = .init(axis: .vertical, alignment: .leading, distribution: .equalSpacing, spacing: 0, arrangedSubviews: [title, dateLabel])
        addSubview(stack)
    }
    private func setupMoreButton() {
        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        moreButton.imageEdgeInsets = .init(top: 12, left: 18, bottom: 12, right: 18)
        moreButton.tintColor = .ui.darkColor
        addSubview(moreButton)
    }

    private func setupConstraints() {
        avatar.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(24)
            make.size.equalTo(48)
        }
        
        statusView.superview?.snp.makeConstraints { make in
            make.centerX.equalTo(avatar.snp.trailing).inset(4)
            make.centerY.equalTo(avatar.snp.bottom).inset(4)
            make.size.equalTo(12)
        }
        
        statusView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(8)
        }
        
        stack.snp.makeConstraints { make in
            make.top.bottom.equalTo(avatar)
            make.leading.equalTo(avatar.snp.trailing).inset(-16)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(12)
            make.size.equalTo(40)
        }
    }
    
    func config(with user: Any?) {
        self.title.text = "Shaun Zam"
        self.dateLabel.text = "10:48 PM"
    }
}

// MARK: - objc
private extension ConversationUserView {
    @objc func didTapMoreButton() {
        delegate?.didTapMoreButton()
    }
}
