//
//  CompanyInfoBoxView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/1/24.
//

import UIKit

enum CompanyInformationBox: String {
    case dealer = "Dealer type"
    case sales = "Sales volume"
    case inventory = "Inventory"
}

protocol CompanyInformationSelectionBoxViewDelegate: AnyObject {
    func didSelectBox(with type: CompanyInformationBox)
}

class CompanyInformationSelectionBoxView: UIView {
    // MARK: - properties
    private let image = UIImageView(image: .init(systemName: "chevron.down"))
    private let title = UILabel(font: .Fonts.normal(12), textColor: UIColor(p3: "#8B8989"), alignment: .center)
    private let card = UIView()
    private let label = UILabel(font: .Fonts.normal(14),
                                textColor: .ui.silverGray,
                                alignment: .left)
    let type: CompanyInformationBox
    weak var delegate: CompanyInformationSelectionBoxViewDelegate?
    
    // MARK: - init
    init(type: CompanyInformationBox) {
        self.type = type
        super.init(frame: .zero)
        self.label.text = type.rawValue
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupUI
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(boxDidTouched)))
        backgroundColor = .white
        
        title.backgroundColor = .white
        title.isHidden = true
        title.text = type.rawValue
        
        setupStack()
        addSubview(title)
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(24)
            make.leading.equalToSuperview().inset(24)
        }
        
        card.snp.makeConstraints { make in
            make.height.equalTo(62)
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(title.snp.centerY)
        }
    }
    
    private func setupStack() {
        card.translatesAutoresizingMaskIntoConstraints = false
        card.addBorder(color: UIColor(p3: "#E0E4F5"), thickness: 2)
        card.applyCorners(to: .all, with: 18)
        addSubview(card)
        
        image.tintColor = .ui.silverGray
        let stack = UIStackView(arrangedSubviews: [label, image])
        
        image.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        
        card.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc private func boxDidTouched() {
        self.delegate?.didSelectBox(with: type)
    }
    
    public func showError() {
        self.title.isHidden = false
        self.card.layer.borderColor = UIColor.ui.red.cgColor
        self.title.textColor = .ui.red
    }
    
    public func clearError() {
        self.card.layer.borderColor = UIColor(p3: "#E0E4F5").cgColor
        self.title.isHidden = true
    }
}

// MARK: - public logics
extension CompanyInformationSelectionBoxView {
    public func setValue(value: String) {
        label.text = value
        label.textColor = .black
    }
}
