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
    private let unreadMessages = UILabel(font: .Fonts.medium(10), textColor: .white, alignment: .center)
    private let contentLabel = UILabel(font: .Fonts.light(12), textColor: .ui.darkColor2, alignment: .left)
    private var titleStack: UIStackView!
    private var dateStack: UIStackView!
    private let card = UIView()
    private let separator = UIView()
    
    private var unread = true {
        didSet {
            username.textColor = unread ? .ui.darkColor : .ui.darkColor3
            contentLabel.textColor = unread ? .ui.darkColor2 : .ui.darkColor3
            dateLabel.textColor = unread ? .ui.darkColor : .ui.darkColor3
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
        
        unreadMessages.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(18)
            make.height.equalTo(18)
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
            make.centerY.equalTo(username)
        }
        
        separator.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
            make.leading.trailing.equalTo(card)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.dateLabel.text = ""
        self.unread = false
        self.unreadMessages.text = ""
    }
    
    func fill(cell with: RMChat) {
        self.title.text = "From " + (with.source ?? "Unknown")
        self.username.text = with.name
        
        self.dateLabel.text = Date(timeIntervalSince1970: with.timestamp).conversationDateFormatter()
        self.contentLabel.text = with.lastMessage?.content
        if let unreadCounter = with.unreadCounter, unreadCounter != 0 {
            self.unread = true
            self.unreadMessages.text = " \(unreadCounter) "
        } else {
            self.unread = false
        }
        fillImageView(with: with.leadState ?? .cold)
    }
    
    func fillImageView(with lead: LeadState) {
        avatar.image = lead.image
        avatar.tintColor = .white
        avatarBackView.backgroundColor = lead.color
    }
}
