//
//  ChatHeaderTVH.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/24/24.
//

import UIKit

class ChatHeaderTVH: UITableViewHeaderFooterView {
    static let ViewID = "ChatHeaderTVH"
    
    // MARK: - properties
    let dateLabel = UILabel(font: .Fonts.medium(11), textColor: .ui.darkColor2, alignment: .center)
    let card = UIView()
    
    // MARK: - init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup UI
    private func setupUI() {
        card.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(dateLabel)
        card.backgroundColor = .ui.primaryBlue.withAlphaComponent(0.1)
        card.applyCorners(to: .all, with: 15)
        contentView.addSubview(card)
        setupConstraints()
    }
    
    private func setupConstraints() {
        card.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.center.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func fillView(with date: String) {
        self.dateLabel.text = date
    }
}
