//
//  ChatMoreView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/2/24.
//

import UIKit

protocol ChatMoreViewDelegate: AnyObject {
    func copyLinkDidTouched()
    func deleteChatDidTouched()
}

class ChatMoreView: UIView {
    // MARK: - properties
    private let topIcon = UIImageView(image: .get(image: .topPolygon))
    private var copyButton: UITextImageButton!
    private var deleteButton: UITextImageButton!
    private let line = UIView()
    private var stack: UIStackView!
    private let card = UIView()
    weak var delegate: ChatMoreViewDelegate?
    
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
        setupCardView()
        setupCopyButton()
        setupDeleteButton()
        setupStack()
        setupPolygon()
        setupLine()
        setupConstraints()
    }
    
    private func setupPolygon() {
        topIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topIcon)
    }
    
    private func setupCopyButton() {
        copyButton = .init(image: .get(image: .copy), label: .init(text: "Copy Link", font: .Quicksand.medium(12), textColor: .ui.darkColor, alignment: .right))
        copyButton.stackSpacing = 10
        copyButton.setupUI(axis: .horizontal, iconPosition: .left, distribution: .equalSpacing)
        copyButton.addTarget(self, action: #selector(copyLinkDidTouched), for: .touchUpInside)
    }
    
    private func setupDeleteButton() {
        let redColor = UIColor(p3: "#D8394C")
        deleteButton = .init(image: .get(image: .delete),
                           label: .init(text: "Delete", font: .Quicksand.medium(12), textColor: redColor, alignment: .right))
        deleteButton.iconColor = redColor
        deleteButton.stackSpacing = 10
        deleteButton.setupUI(axis: .horizontal, iconPosition: .left, distribution: .equalSpacing)
        deleteButton.addTarget(self, action: #selector(deleteButtonDidTouched), for: .touchUpInside)
    }
    
    private func setupStack() {
        stack = .init(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 0, arrangedSubviews: [copyButton, deleteButton])
        card.addSubview(stack)
    }
    
    private func setupLine() {
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .init(p3: "#EBEBEB")
        stack.addSubview(line)
    }
    
    private func setupCardView() {
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .white
        card.applyCorners(to: .all, with: 16)
        addSubview(card)
    }
    
    private func setupConstraints() {
        card.snp.makeConstraints { make in
            make.top.equalTo(topIcon.snp.centerY)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        topIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(14)
        }
        
        stack.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        line.snp.makeConstraints { make in
            make.height.equalTo(0.7)
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - objc
private extension ChatMoreView {
    @objc func copyLinkDidTouched() {
        delegate?.copyLinkDidTouched()
    }
    
    @objc func deleteButtonDidTouched() {
        delegate?.deleteChatDidTouched()
    }
}
