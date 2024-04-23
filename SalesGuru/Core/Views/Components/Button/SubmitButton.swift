//
//  SubmitButton.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/8/23.
//

import UIKit

class CustomButton: UIButton {
    // MARK: - properties
    private let style: Style
    private let size: CGSize
    private let fillColor: UIColor?
    private let textColor: UIColor?
    private let text: Text
    override var buttonType: UIButton.ButtonType {
        return .system
    }
    
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.75 : 1
        }
    }
    // MARK: - init
    init(style: Style,
         size: CGSize,
         textColor: UIColor?,
         fillColor: UIColor?,
         text: Text
    ) {
        self.style = style
        self.size = size
        self.textColor = textColor
        self.fillColor = fillColor
        self.text = text
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup UI
   private func setupUI() {
        // Text
        setupText()
        // style
        addCorner(12)
        switch style {
        case .fill: fillStyle()
        case .stroke: strokeStyle()
        }
        //constraints
        var constraints: [NSLayoutConstraint] = [
            heightAnchor.constraint(equalToConstant: size.height),
        ]
        if size.width != .zero {
            constraints.append(widthAnchor.constraint(equalToConstant: size.width))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func strokeStyle() {
        addBorder(color: fillColor ?? .clear, thickness: 1)
        tintColor = fillColor
        backgroundColor = .clear
        setTitleColor(fillColor, for: .normal)
        titleLabel?.textColor = fillColor
    }
    
    private func fillStyle() {
        tintColor = textColor
        backgroundColor = fillColor
        setTitleColor(textColor, for: .normal)
        titleLabel?.textColor = textColor
    }
    
    private func setupText() {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = text.font
        
        if let titleColor = text.textColor {
            setTitleColor(titleColor, for: .normal) // for .title
            titleLabel?.textColor = titleColor      // for .attributedTitle
        }
        
        if let title = text.text {
            setTitle(title.localized, for: .normal)
        } else if let attributedTitle = text.attributedText {
            setAttributedTitle(attributedTitle, for: .normal)
        }
    }
}

extension CustomButton {
    enum Style {
        case stroke
        case fill
    }
}
