//
//  RecivedConversationMessageTVC.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/29/24.
//

import UIKit
import SnapKit

enum MessagePosition {
    case first
    case middle
    case last
}

class RecivedConversationMessageTVC: UITableViewCell {
    // MARK: - properties
    static let CellID = "RecivedConversationMessageTVC"
    private let statusView = UIView()
    private let avatar = UIImageView()
    private let dateLabel = UILabel(font: .Fonts.medium(11), textColor: .ui.darkColor3, alignment: .left)
    private let card = UIView()
    private let contentLabel = UILabel(font: .Fonts.light(14), textColor: .ui.darkColor, alignment: .left)
    private var stack: UIStackView!
    private var bottomSpacing: Constraint!
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
        setupCardView()
        setupAvatar()
        setupStatusView()
        setupContent()
        setupConstraints()
    }
    
    private func setupAvatar() {
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.backgroundColor = .ui.primaryBlue
        avatar.applyCorners(to: .all, with: 10)
        contentView.addSubview(avatar)
    }
    
    private func setupStatusView() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.applyCorners(to: .all, with: 3)
        statusView.backgroundColor = .ui.green
        view.applyCorners(to: .all, with: 5)
        view.backgroundColor = .white
        view.addSubview(statusView)
        contentView.addSubview(view)
    }
    
    private func setupContent() {
        contentLabel.numberOfLines = 0
        card.addSubview(contentLabel)
    }
    
    private func setupCardView() {
        card.backgroundColor = .ui.darkColor3.withAlphaComponent(0.1)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.applyCorners(to: .all, with: 10)
        stack = .init(axis: .vertical, alignment: .leading, distribution: .equalSpacing, spacing: 4, arrangedSubviews: [card, dateLabel])
        contentView.addSubview(stack)
    }
    
    private func setupConstraints() {
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
            make.leading.equalTo(avatar).inset(56)
            make.height.greaterThanOrEqualTo(48)
            bottomSpacing = make.bottom.equalToSuperview().constraint
        }
        
        avatar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(24)
            make.size.equalTo(40)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.width.greaterThanOrEqualTo(15)
            make.width.lessThanOrEqualTo(0.7 * K.size.portrait.width)
            make.top.bottom.equalToSuperview().inset(14)
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
    }
    
    private func setMessagePosition(position: MessagePosition) {
        self.avatar.isHidden = position != .first
        self.statusView.superview?.isHidden = position != .first
        self.dateLabel.isHidden = position != .last
        bottomSpacing.update(offset: position == .last ? 24 : 0)
    }
    
    func fill(cell with: RMConversationMessages, position: MessagePosition) {
        self.setMessagePosition(position: position)
        self.contentLabel.text = with.content
        self.dateLabel.text = with.date
    }
}
