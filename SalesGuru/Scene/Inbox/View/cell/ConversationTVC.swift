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
    private let title = UILabel(font: .Fonts.medium(10), textColor: .ui.darkColor3, alignment: .left)
    private let dateLabel = UILabel(font: .Fonts.medium(10), textColor: .ui.darkColor3, alignment: .left)
    private let username = UILabel(font: .Fonts.medium(14), textColor: .ui.darkColor, alignment: .left)
    private let unreadMessages = UILabel(font: .Fonts.medium(10), textColor: .white, alignment: .left)
    private let contentLabel = UILabel(font: .Fonts.light(12), textColor: .ui.darkColor2, alignment: .left)
    private var titleStack: UIStackView!
    private var usernameStack: UIStackView!
    private let statusView = UIView()
    private let card = UIView()
    private let separator = UIView()
    
    private var unread = true {
        didSet {
            username.textColor = unread ? .ui.darkColor : .ui.darkColor3
            unreadMessages.isHidden = !unread
            statusView.backgroundColor = unread ? .ui.green : .ui.red
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
        setupUsernameStack()
        setupContent()
        setupAvatar()
        setupStatusView()
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
        titleStack = .init(axis: .horizontal, alignment: .center, distribution: .fill, spacing: 10, arrangedSubviews: [title, dateLabel])
        card.addSubview(titleStack)
    }
    
    private func setupUsernameStack() {
        unreadMessages.backgroundColor = .ui.primaryBlue
        unreadMessages.applyCorners(to: .all, with: 4)
        usernameStack = .init(axis: .horizontal, alignment: .center, distribution: .equalSpacing, spacing: 8, arrangedSubviews: [username, unreadMessages])
        card.addSubview(usernameStack)
    }
    
    private func setupAvatar() {
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.backgroundColor = .ui.primaryBlue
        avatar.applyCorners(to: .all, with: 10)
        card.addSubview(avatar)
    }
    
    private func setupStatusView() {
        let view = UIView()
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.applyCorners(to: .all, with: 3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.applyCorners(to: .all, with: 5)
        view.backgroundColor = .white
        view.addSubview(statusView)
        card.addSubview(view)
    }
    
    private func setupContent() {
        contentLabel.numberOfLines = 2
        card.addSubview(contentLabel)
    }
    
    private func setupConstraints() {
        card.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        avatar.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(18)
            make.size.equalTo(40)
        }
        
        titleStack.snp.makeConstraints { make in
            make.top.equalTo(avatar).offset(-2)
            make.leading.equalTo(avatar.snp.trailing).inset(-20)
            make.trailing.equalToSuperview().inset(24)
        }
        
        usernameStack.snp.makeConstraints { make in
            make.top.equalTo(titleStack.snp.bottom)
            make.leading.equalTo(titleStack)
            make.width.lessThanOrEqualTo(titleStack)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleStack)
            make.top.equalTo(usernameStack.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(20)
        }
        
        statusView.superview?.snp.makeConstraints { make in
            make.centerX.equalTo(avatar.snp.trailing).inset(2)
            make.centerY.equalTo(avatar.snp.bottom).inset(2)
            make.size.equalTo(10)
        }
        
        statusView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(6)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalToSuperview()
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
    }
}
