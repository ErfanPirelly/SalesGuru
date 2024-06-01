//
//  SentConversationMessageTVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/30/24.
//

import UIKit
import SnapKit

class SentConversationMessageTVC: UITableViewCell, ConversationMessageCell {
    // MARK: - properties
    static let CellID = "SentConversationMessageTVC"
    private let dateLabel = UILabel(font: .Quicksand.medium(11), textColor: .ui.silverGray2, alignment: .left)
    private let card = UIView()
    private let contentLabel = UILabel(font: .Fonts.light(14), textColor: .white, alignment: .left)
    private var stack: UIStackView!
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
        dateLabel.text = ""
        contentLabel.text = ""
    }
    
    // MARK: - prepare UI
    private func setupView() {
        setupCardView()
        setupContent()
        setupConstraints()
    }
    
    private func setupContent() {
        contentLabel.numberOfLines = 0
        card.addSubview(contentLabel)
    }
    
    private func setupCardView() {
        card.backgroundColor = .ui.primaryBlue
        card.translatesAutoresizingMaskIntoConstraints = false
        card.applyCorners(to: .all, with: 10)
        stack = .init(axis: .vertical, alignment: .trailing, distribution: .equalSpacing, spacing: 4, arrangedSubviews: [card, dateLabel])
        contentView.addSubview(stack)
    }
    
    private func setupConstraints() {
        stack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.trailing.equalToSuperview().inset(24)
        }

        card.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(48)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.width.greaterThanOrEqualTo(15)
            make.width.lessThanOrEqualTo(0.7 * K.size.portrait.width)
            make.top.bottom.equalToSuperview().inset(14)
        }
    }
    
    private func setMessagePosition(position: MessagePosition) {
        if position == .single {
            self.dateLabel.isHidden = false
        } else {
            self.dateLabel.isHidden = position != .last
        }
    }
    
    func fill(cell with: RMMessage, leadState: LeadState, position: MessagePosition) {
        self.message = with
        self.setMessagePosition(position: position)
        self.contentLabel.text = with.content
        var dateStr = with.date.toFormattedString(format: "hh:mm a").capitalized
        if with.sender == "AI" {
            dateStr += " AI"
        }
        self.dateLabel.text = dateStr
    }
}
