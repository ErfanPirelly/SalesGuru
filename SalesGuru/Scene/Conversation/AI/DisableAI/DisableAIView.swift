//
//  DisableAIView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/2/24.
//

import UIKit
import M13Checkbox

class DisableAIView: UIView {
    // MARK: - properties
    private let title = UILabel(text: "AI will be disabled off for 3 minutes and then will resume operation", font: .Quicksand.semiBold(16), textColor: .init(p3: "#474747"), alignment: .center)
    private let checkBox = M13Checkbox()
    private let subtitle = UILabel(text: "Do not show this message again",
                                   font: .Quicksand.normal(12),
                                   textColor: .ui.darkColor1,
                                   alignment: .left)
    private let cancelButton = UIButton(title: "Cancel",
                                        titleColor: .init(p3: "#FB273E"),
                                        font: .Quicksand.semiBold(16))
    private let submitButton = UIButton(title: "Ok",
                                        titleColor: .init(p3: "#474747"),
                                        font: .Quicksand.semiBold(16))
    private let horizontalLine = UIView()
    private let verticalLine = UIView()
    private var buttonStack: UIStackView!
    private var checkBoxStack: UIStackView!
    
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
        backgroundColor = .white
        applyCorners(to: .all, with: 16)
        setupTitle()
        setupLines()
        setupButtonStack()
        setupCheckBoxStack()
        setupConstraints()
    }
    
    private func setupTitle() {
        title.numberOfLines = 0
        addSubview(title)
    }
    
    private func setupLines() {
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        horizontalLine.backgroundColor = .init(p3: "#EBEBEB")
        
        verticalLine.translatesAutoresizingMaskIntoConstraints = false
        verticalLine.backgroundColor = .init(p3: "#EBEBEB")
        
        addSubview(horizontalLine)
    }
    
    private func setupButtonStack() {
        buttonStack = .init(spacing: 0, arrangedSubviews: [cancelButton, verticalLine, submitButton])
        addSubview(buttonStack)
    }
    
    private func setupCheckBox() {
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.boxType = .square
        checkBox.markType = .checkmark
        checkBox.tintColor = .ui.primaryBlue
        checkBox.backgroundColor = .init(p3: "#7979791A")
        checkBox.secondaryTintColor = .init(p3: "#7979791A")
        checkBox.boxLineWidth = 1
        
        checkBox.snp.makeConstraints { make in
            make.size.equalTo(18)
        }
    }
    
    private func setupCheckBoxStack() {
        setupCheckBox()
        checkBoxStack = .init(spacing: 8, arrangedSubviews: [checkBox, subtitle])
        addSubview(checkBoxStack)
    }
    
    private func setupConstraints() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(60)
        }
        
        checkBoxStack.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(24)
            make.leading.equalTo(title).inset(12)
        }
        
        horizontalLine.snp.makeConstraints { make in
            make.top.equalTo(checkBoxStack.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(0.7)
        }
        
        verticalLine.snp.makeConstraints { make in
            make.width.equalTo(0.7)
            make.height.equalTo(56)
        }
        
        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(horizontalLine.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo((K.size.portrait.width - 69)/2)
            make.height.equalTo(73)
        }
        
        submitButton.snp.makeConstraints { make in
            make.size.equalTo(cancelButton)
        }
        
        snp.makeConstraints { make in
            make.width.equalTo(K.size.portrait.width - 70)
        }
    }
}
