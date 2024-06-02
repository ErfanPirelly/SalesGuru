//
//  NotificationCell.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/1/24.
//

import UIKit

class NotificationCell: UITableViewCell {
    // MARK: - properties
    static let CellID = "NotificationCell"
    private let imageBackView = UIView()
    private let image = UIImageView()
    private let username = UILabel(font: .Quicksand.bold(14), textColor: .ui.darkColor, alignment: .left)
    private let subtitle = UILabel(font: .Quicksand.bold(10), textColor: .ui.silverGray2, alignment: .left)
    private let dateLabel = UILabel(font: .Quicksand.semiBold(11), textColor: .ui.silverGray, alignment: .center)
    private var stack: UIStackView!
    private let card = UIView()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        username.text = ""
        subtitle.text = ""
        dateLabel.text = ""
    }
    
    // MARK: - prepare UI
    func setupView() {
        setupCardView()
        setupStack()
        setupImageView()
        setupDateLabel()
        setupConstraints()
    }
    
    private func setupCardView() {
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .clear
        contentView.addSubview(card)
    }
    
    private func setupStack() {
        subtitle.numberOfLines = 0
        stack = .init(axis: .vertical, alignment: .leading, distribution: .equalSpacing, spacing: 5, arrangedSubviews: [username, subtitle])
        card.addSubview(stack)
    }
    
    private func setupImageView() {
        imageBackView.translatesAutoresizingMaskIntoConstraints = false
        imageBackView.applyCorners(to: .all, with: 10)
        image.translatesAutoresizingMaskIntoConstraints = false
        imageBackView.addSubview(image)

        card.addSubview(imageBackView)
    }
    
    private func setupDateLabel() {
        card.addSubview(dateLabel)
    }
    
    private func setupConstraints() {
        card.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(13.5)
            make.leading.trailing.equalToSuperview()
        }
        
        imageBackView.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.leading.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(4)
        }
        
        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(imageBackView).inset(3)
            make.leading.equalTo(imageBackView.snp.trailing).offset(14)
            make.height.greaterThanOrEqualTo(40)
            make.bottom.equalToSuperview().inset(4)
            make.trailing.equalTo(dateLabel.snp.leading).inset(8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageBackView)
            make.trailing.equalToSuperview().inset(24)
        }

    }
    
    func fill(cell with: RMNotification) {
        self.username.text = with.username
        self.subtitle.text = with.content
        self.dateLabel.text = with.date
        
        fillImageView(with: .engaged)
    }
    
    private func fillImageView(with lead: LeadState) {
        image.image = lead.image
        image.tintColor = .white
        imageBackView.backgroundColor = lead.color
    }
}
