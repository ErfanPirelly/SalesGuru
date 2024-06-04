//
//  ReceivedConversationMessageTVC.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/29/24.
//

import UIKit
import SnapKit

enum MessagePosition {
    case single
    case first
    case middle
    case last
}

protocol ConversationMessageCell: AnyObject {
    var message: RMMessage? {get set}
    var card: UIView {get}
    var color: UIColor {get}
    func fill(cell with: RMMessage, leadState: LeadState, position: MessagePosition)
}

class ReceivedConversationMessageTVC: UITableViewCell, ConversationMessageCell {
    var color: UIColor = .ui.darkColor3.withAlphaComponent(0.1)
    // MARK: - properties
    static let CellID = "RecivedConversationMessageTVC"
    private let avatarBackView = UIView()
    private let avatar = UIImageView()
    private let dateLabel = UILabel(font: .Quicksand.normal(11), textColor: .ui.silverGray2, alignment: .left)
    var card = UIView()
    private let contentLabel = UILabel(font: .Fonts.light(14), textColor: .ui.darkColor1, alignment: .left)
    private var verticalStack: UIStackView!
    public var message: RMMessage?
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        message = nil
        avatar.image = nil
        dateLabel.text = ""
        contentLabel.text = ""
        
    }
    // MARK: - prepare UI
    private func setupView() {
        setupCardView()
        setupAvatar()
        setupVerticalStack()
        setupConstraints()
    }
    
    private func setupAvatar() {
        avatarBackView.translatesAutoresizingMaskIntoConstraints = false
        avatarBackView.applyCorners(to: .all, with: 10)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatarBackView.addSubview(avatar)
        contentView.addSubview(avatarBackView)
    }

    private func setupContent() {
        contentLabel.numberOfLines = 0
        card.addSubview(contentLabel)
    }
    
    private func setupCardView() {
        setupContent()
        card.backgroundColor = color
        card.translatesAutoresizingMaskIntoConstraints = false
        card.applyCorners(to: .all, with: 10)
    }
    
    private func setupVerticalStack() {
        verticalStack = .init(axis: .vertical, alignment: .leading, distribution: .equalSpacing, spacing: 3, arrangedSubviews: [card, dateLabel])
        contentView.addSubview(verticalStack)
    }
    
    private func setupConstraints() {
        verticalStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.equalTo(avatar.snp.trailing).inset(-16)
        }
        
        avatarBackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(3)
            make.leading.equalToSuperview().inset(24)
            make.size.equalTo(40)
        }
        
        avatar.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.width.greaterThanOrEqualTo(15)
            make.width.lessThanOrEqualTo(0.5 * K.size.portrait.width)
            make.top.bottom.equalToSuperview().inset(14)
        }
        
        card.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(48)
        }
    }
    
    private func setMessagePosition(position: MessagePosition) {
        if position == .single {
            self.avatar.isHidden = false
            self.dateLabel.isHidden = false
        } else {
            self.avatar.isHidden = position != .first
            self.dateLabel.isHidden = position != .last
        }
    }
    
    func fill(cell with: RMMessage, leadState: LeadState, position: MessagePosition) {
        self.message = with
        self.setMessagePosition(position: position)
        self.contentLabel.text = with.content
        let dateStr = with.date.toFormattedString(format: "hh:mm a")
        self.dateLabel.text = dateStr
        fillImageView(with: leadState)
    }
    
    
    func fillImageView(with lead: LeadState) {
        avatar.image = lead.image
        avatar.tintColor = .white
        avatarBackView.backgroundColor = lead.color
    }
}
