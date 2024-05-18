//
//  ConversationTVC.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/28/24.
//

import UIKit

class ConversationTVC: UITableViewCell {
    // MARK: - properties
    static let CellID = "ConversationTVC"
    private let avatar = UIImageView()
    private let avatarBackView = UIView()
    
    private let title = UILabel(font: .Fonts.medium(10), textColor: .ui.darkColor3, alignment: .left)
    private let dateLabel = UILabel(font: .Fonts.medium(10), textColor: .ui.darkColor, alignment: .left)
    private let username = UILabel(font: .Fonts.medium(14), textColor: .ui.darkColor, alignment: .left)
    private let unreadMessages = UILabel(font: .Fonts.medium(10), textColor: .white, alignment: .left)
    private let contentLabel = UILabel(font: .Fonts.light(12), textColor: .ui.darkColor2, alignment: .left)
    private var titleStack: UIStackView!
    private var dateStack: UIStackView!
    private let card = UIView()
    private let separator = UIView()
    
    private var unread = true {
        didSet {
            username.textColor = unread ? .ui.darkColor : .ui.darkColor3
            unreadMessages.isHidden = !unread
        }
    }
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - prepare UI
    private func setupView() {
        contentView.backgroundColor = .white
        backgroundColor = .white
        setupCardView()
        setupSeparator()
        setupTitleStack()
        setupDateStack()
        setupContent()
        setupAvatar()
        setupConstraints()
    }
    
    private func setupCardView() {
        card.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(card)
    }
    
    private func setupSeparator() {
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .ui.darkColor3
        separator.alpha = 0.1
        contentView.addSubview(separator)
    }
    
    private func setupTitleStack() {
        titleStack = .init(axis: .vertical, alignment: .leading, distribution: .equalSpacing, spacing: 10, arrangedSubviews: [title, username])
        card.addSubview(titleStack)
    }
    
    private func setupDateStack() {
        unreadMessages.backgroundColor = .ui.primaryBlue
        unreadMessages.applyCorners(to: .all, with: 4)
        dateStack = .init(axis: .vertical, alignment: .center, distribution: .equalSpacing, spacing: 10, arrangedSubviews: [dateLabel, unreadMessages])
        card.addSubview(dateStack)
    }
    
    private func setupAvatar() {
        avatarBackView.translatesAutoresizingMaskIntoConstraints = false
        avatarBackView.applyCorners(to: .all, with: 10)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatarBackView.addSubview(avatar)
        card.addSubview(avatarBackView)
    }
    
    private func setupContent() {
        contentLabel.numberOfLines = 2
        card.addSubview(contentLabel)
    }
    
    private func setupConstraints() {
        card.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        avatarBackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.leading.equalToSuperview()
            make.size.equalTo(40)
        }
        
        avatar.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        titleStack.snp.makeConstraints { make in
            make.top.equalTo(avatarBackView).offset(-2)
            make.leading.equalTo(avatarBackView.snp.trailing).inset(-20)
            make.width.lessThanOrEqualTo(0.45 * K.size.portrait.width)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleStack)
            make.top.equalTo(titleStack.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(20)
            make.width.lessThanOrEqualTo(0.45 * K.size.portrait.width)
        }
        
        dateStack.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        separator.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
            make.leading.trailing.equalTo(card)
        }
    }
    
    func fill(cell with: RMConversation) {
        self.title.text = with.title
        self.username.text = with.username
        self.dateLabel.text = with.date
        self.contentLabel.text = with.content
        self.unread = with.unread
        self.unreadMessages.text = " \(with.messageCount) "
        fillImageView()
    }
    
    func fillImageView() {
        avatar.image = .get(image: .flame)
        avatar.tintColor = .white
        avatarBackView.backgroundColor = .ui.red1
    }
}
