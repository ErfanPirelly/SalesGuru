//
//  UITextImageButton.swift
//  Pirelly
//
//  Created by mmdMoovic on 9/1/23.
//

import UIKit
enum IconSide: Int {
   case left, right
}

class UITextImageButton: UIButton {
    let icon = UIImageView()
    let label: UILabel
    var stack: UIStackView!
    var edgeSpacing: UIEdgeInsets = .zero
    var stackSpacing: CGFloat = 8
    
    override var buttonType: UIButton.ButtonType {
        return .system
    }
    
    override var tintColor: UIColor! {
        set {
            icon.tintColor = newValue
            label.textColor = newValue
        }
        
        get {
            return  icon.tintColor
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            self.subviews.forEach({$0.alpha = isHighlighted ? 0.6 : 1})
            self.alpha = isHighlighted ? 0.6 : 1
        }
    }
    
    var textColor: UIColor? {
        set {
            label.textColor = newValue
        }
        
        get {
            label.textColor
        }
    }
    
    var iconColor: UIColor? {
        set {
            icon.tintColor = newValue
        }
        
        get {
            icon.tintColor
        }
    }

    // MARK: - init
    init(image: UIImage?, label: UILabel) {
        self.label = label
        self.icon.image = image
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup UI
    func setupUI(
        axis: NSLayoutConstraint.Axis = .horizontal,
        iconPosition: IconSide = .left,
        distribution: UIStackView.Distribution = .fillProportionally) {
            icon.tintColor = iconColor
            label.textAlignment = axis == .horizontal ? (iconPosition == .right ? .right : .left) : .center
            let arrangeSubviews: [UIView] = iconPosition == .right ? [label, icon] : [icon, label]
            stack = UIStackView(arrangedSubviews: arrangeSubviews)
            stack.spacing = stackSpacing
            stack.axis = axis
            stack.alignment = .center
            stack.distribution = distribution
            stack.isUserInteractionEnabled = false
            
            addSubview(stack)
            stack.anchorWithConstants(top: topAnchor,
                                      leading: leadingAnchor,
                                      trailing: trailingAnchor,
                                      bottom: bottomAnchor,
                                      topConstant: edgeSpacing.top,
                                      leftConstant: edgeSpacing.left,
                                      rightConstant: edgeSpacing.right,
                                      bottomConstant: edgeSpacing.bottom)
        }
    
    func setupCenteralize(
        axis: NSLayoutConstraint.Axis = .horizontal,
        iconPosition: IconSide = .left) {
            icon.tintColor = iconColor
            label.textAlignment = axis == .horizontal ? (iconPosition == .right ? .right : .left) : .center
            let arrangeSubviews: [UIView] = iconPosition == .right ? [label, icon] : [icon, label]
            stack = UIStackView(arrangedSubviews: arrangeSubviews)
            stack.spacing = stackSpacing
            stack.axis = axis
            stack.alignment = .center
            stack.distribution = .equalSpacing
            stack.isUserInteractionEnabled = false
            
            addSubview(stack)
            stack.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
    }
}
