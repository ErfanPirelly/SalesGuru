//
//  SettingsTVC.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/29/24.
//
import UIKit

class SettingsTVC: UITableViewCell {
    // MARK: - properties
    static let CellID = "SettingsTVC"
    private let icon = UIImageView()
    private let title = UILabel(font: .Fonts.bold(20), textColor: .ui.silverGray2, alignment: .left)
    private let arrow = UIImageView(image: UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate))
    private var stack: UIStackView!
    private let card = UIView()
    
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
        contentView.backgroundColor = .ui.backgroundColor4
        backgroundColor = .ui.backgroundColor4
        setupCardView()
        setupStackView()
        setupArrow()
        setupConstraints()
    }
    
    private func setupStackView() {
        stack = UIStackView(axis: .horizontal, alignment: .center, distribution: .equalSpacing, spacing: 20, arrangedSubviews: [icon, title])
        card.addSubview(stack)
    }
    
    private func setupArrow() {
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.tintColor = .ui.gray3
        card.addSubview(arrow)
    }
    
    private func setupCardView() {
        card.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(card)
    }
    
    private func setupConstraints() {
        card.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(32)
            make.leading.trailing.equalToSuperview()
        }
        
        stack.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(32)
            make.top.bottom.equalToSuperview()
        }
        
        arrow.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(24)
            make.width.equalTo(8)
            make.height.equalTo(10)
        }
    }
    
    func fill(cell with: SettingItem) {
        self.title.text = with.rawValue
        self.icon.image = with.icon
    }
}
