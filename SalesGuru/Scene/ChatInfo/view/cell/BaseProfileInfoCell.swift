//
//  BaseProfileInfoCell.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/3/24.
//

import UIKit

enum ChatInfoCellType {
    case lead
    case singleRightIcon
    case solid
    case singleButton
    case textButton
    case textRightIcon
    case empty
}

class BaseProfileInfoCell: UITableViewCell {
    // MARK: - properties
    private var stack: UIStackView!
    let title = UILabel(font: .Quicksand.normal(17),
                                textColor: .ui.darkColor1,
                                alignment: .left)
    open var rightStacK: UIStackView!
    let rightIcon = UIImageView(image: .init(systemName: "chevron.right"))
    let lightLabel = UILabel(font: .Quicksand.normal(17),
                                     textColor: .ui.darkColor1.withAlphaComponent(0.35),
                                     alignment: .center)
    let leadIcon = UIImageView()
    let darkLabel = UILabel(font: .Quicksand.medium(12),
                                    textColor: .ui.darkColor1,
                                    alignment: .center)
    let rightButton = NavBatButton(type: .system)
    var model: UIModelChatProtocol?
    
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
        hideViews()
    }
    
    // MARK: - prepare UI
    func setupView() {
        setupRightButton()
        setupStack()
        setupConstraints()
    }
    
    private func setupConstraints() {
        stack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.bottom.equalToSuperview().inset(15)
        }
        
        rightButton.snp.makeConstraints { make in
            make.size.equalTo(32)
        }
    }
    
    private func setupRightStack() {
        rightIcon.tintColor = .ui.darkColor1.withAlphaComponent(0.2)
        rightButton.isUserInteractionEnabled = false
        rightStacK = .init(distribution: .equalCentering, spacing: 4, arrangedSubviews: [leadIcon, lightLabel, darkLabel, rightButton, rightIcon])
    }
    
    private func setupStack() {
        setupRightStack()
        stack = .init(distribution: .fill, spacing: 8, arrangedSubviews: [title, rightStacK])
        contentView.addSubview(stack)
    }
    
    private func setupRightButton() {
        rightButton.backgroundColor = .ui.darkColor1.withAlphaComponent(0.04)
        rightButton.applyCorners(to: .all, with: 16)
    }
    
    private func hideViews() {
        leadIcon.isHidden = true
        darkLabel.isHidden = true
        rightButton.isHidden = true
        lightLabel.isHidden = true
        rightIcon.isHidden = true
    }
    
    func fill(cell with: UIModelChatProtocol) {
        hideViews()
        self.title.textColor = .ui.darkColor1
        self.title.text = with.title
        self.model = with
    }
}
