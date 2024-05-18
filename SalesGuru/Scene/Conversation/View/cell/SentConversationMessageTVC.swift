//
//  SentConversationMessageTVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/30/24.
//

import UIKit
import SnapKit

class SentConversationMessageTVC: UITableViewCell {
    // MARK: - properties
    static let CellID = "SentConversationMessageTVC"
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
        setupContent()
        setupConstraints()
    }
    
    private func setupContent() {
        contentLabel.numberOfLines = 0
        card.addSubview(contentLabel)
    }
    
    private func setupCardView() {
        card.backgroundColor = .ui.primaryBlue.withAlphaComponent(0.15)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.applyCorners(to: .all, with: 10)
        stack = .init(axis: .vertical, alignment: .trailing, distribution: .equalSpacing, spacing: 4, arrangedSubviews: [card, dateLabel])
        contentView.addSubview(stack)
    }
    
    private func setupConstraints() {
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(24)
            make.height.greaterThanOrEqualTo(48)
            bottomSpacing = make.bottom.equalToSuperview().constraint
        }

        contentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.width.greaterThanOrEqualTo(15)
            make.width.lessThanOrEqualTo(0.7 * K.size.portrait.width)
            make.top.bottom.equalToSuperview().inset(14)
        }
    }
    
    private func setMessagePosition(position: MessagePosition) {
        self.dateLabel.isHidden = position != .last
        bottomSpacing.update(offset: position == .last ? 24 : 0)
    }
    
    func fill(cell with: RMConversationMessages, position: MessagePosition) {
        self.setMessagePosition(position: position)
        self.contentLabel.text = with.content
        self.dateLabel.text = with.date
    }
}
