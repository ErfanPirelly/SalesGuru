//
//  BaseProfileInfoCell.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/3/24.
//

import UIKit

enum ProfileInfoCellType {
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
    static let CellID = "BaseProfileInfoCell"
    private var stack: UIStackView!
    private let title = UILabel(font: .Quicksand.normal(17),
                                textColor: .ui.darkColor1,
                                alignment: .left)
    open var rightStacK: UIStackView!
    private let rightIcon = UIImageView(image: .init(systemName: "chevron.right"))
    private let lightLabel = UILabel(font: .Quicksand.normal(17),
                                     textColor: .ui.darkColor1.withAlphaComponent(0.35),
                                     alignment: .center)
    private let leadIcon = UIImageView()
    private let darkLabel = UILabel(font: .Quicksand.medium(12),
                                    textColor: .ui.darkColor1,
                                    alignment: .center)
    private let rightButton = NavBatButton(type: .system)
    
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
        leadIcon.isHidden = true
        darkLabel.isHidden = true
        rightButton.isHidden = true
        lightLabel.isHidden = true
        rightIcon.isHidden = true
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
    
    
    func fill(cell with: ProfileInfoCellType) {
        switch with {
        case .lead:
            leadIcon.isHidden = false
            lightLabel.isHidden = false
            rightIcon.isHidden = false
            
        case .singleRightIcon:
            rightIcon.isHidden = false
            
        case .solid:
            darkLabel.isHidden = false
            
        case .singleButton:
            rightButton.isHidden = false
            
        case .textButton:
            rightButton.isHidden = false
            lightLabel.isHidden = false
            
        case .textRightIcon:
            rightIcon.isHidden = false
            lightLabel.isHidden = false
            
        case .empty: break
        }
    }
}
