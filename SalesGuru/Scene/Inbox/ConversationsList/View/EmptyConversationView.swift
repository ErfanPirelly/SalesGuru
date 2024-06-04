//
//  EmptyConversationView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/29/24.
//

import UIKit

protocol EmptyConversationViewDelegate: AnyObject {
    func addLeadDidTouched()
}

class EmptyConversationView: UIView {
    // MARK: - properties
    private let icon = UIImageView(image: .get(image: .noMessage))
    private let backgroundIcon = UIImageView(image: .get(image: .noMessageBackground))
    private let title = UILabel(text: "No message here", font: .Quicksand.bold(24), textColor: .ui.darkColor, alignment: .center)
    private let subtitle = UILabel(text: "You have not created any leads. Create your first lead now.",
                                   font: .Quicksand.normal(14),
                                   textColor: .ui.darkColor,
                                   alignment: .center)
    
    private let addButton = UIButton(type: .system,
                                     title: "+ Add Lead",
                                     titleColor: .ui.primaryBlue,
                                     font: .Quicksand.semiBold(20))
    private var stack: UIStackView!
    weak var delegate: EmptyConversationViewDelegate?
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup UI
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        setupImageView()
        setupStack()
        setupAddButton()
        setupConstraints()
    }
    
    private func setupImageView() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        backgroundIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundIcon)
        addSubview(icon)
    }
    
    private func setupStack() {
        stack = .init(axis: .vertical, alignment: .center, distribution: .equalSpacing, spacing: 8, arrangedSubviews: [title, subtitle])
        addSubview(stack)
    }
    
    
    private func setupAddButton() {
        addButton.addTarget(self, action: #selector(addLeadDidTouched), for: .touchUpInside)
        addSubview(addButton)
    }
    
    private func setupConstraints() {
        backgroundIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(35)
            make.centerX.equalToSuperview()
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
    }
}

// MARK: - objc
extension EmptyConversationView {
    @objc private func addLeadDidTouched() {
        delegate?.addLeadDidTouched()
    }
}
