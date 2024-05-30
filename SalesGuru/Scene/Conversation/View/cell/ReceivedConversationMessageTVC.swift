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

class ReceivedConversationMessageTVC: UITableViewCell {
    // MARK: - properties
    static let CellID = "RecivedConversationMessageTVC"
    private let avatar = UIImageView()
    private let dateLabel = UILabel(font: .Quicksand.light(11), textColor: .ui.silverGray2, alignment: .left)
    private let card = UIView()
    private let contentLabel = UILabel(font: .Fonts.light(14), textColor: .ui.darkColor1, alignment: .left)
    private var verticalStack: UIStackView!
    
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
        setupVerticalStack()
        setupConstraints()
    }
    
    private func setupAvatar() {
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.backgroundColor = .ui.primaryBlue
        avatar.applyCorners(to: .all, with: 10)
        contentView.addSubview(avatar)
    }

    private func setupContent() {
        contentLabel.numberOfLines = 0
        card.addSubview(contentLabel)
    }
    
    private func setupCardView() {
        setupContent()
        card.backgroundColor = .ui.darkColor3.withAlphaComponent(0.1)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.applyCorners(to: .all, with: 10)
    }
    
    private func setupVerticalStack() {
        verticalStack = .init(axis: .vertical, alignment: .leading, distribution: .equalSpacing, spacing: 3, arrangedSubviews: [card, dateLabel])
        contentView.addSubview(verticalStack)
    }
    
    private func setupConstraints() {
        verticalStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(avatar.snp.trailing).inset(-16)
        }
        
        avatar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(3)
            make.leading.equalToSuperview().inset(24)
            make.size.equalTo(40)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.width.greaterThanOrEqualTo(15)
            make.width.lessThanOrEqualTo(0.7 * K.size.portrait.width)
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
    
    func fill(cell with: RMConversationMessages, position: MessagePosition) {
        self.setMessagePosition(position: position)
        self.contentLabel.text = with.content
        self.dateLabel.text = with.date
    }
}
