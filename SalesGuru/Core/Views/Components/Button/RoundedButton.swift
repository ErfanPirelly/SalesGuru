//
//  RoundedButton.swift
//  Pirelly
//
//  Created by shndrs on 6/17/23.
//
import UIKit

// MARK: - Rounded Button
class RoundedButton: BaseButton {
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setup() {
        super.setup()
        self.titleLabel?.textColor = .ui.white
    }
    
}

class LightRoundedButton: BaseButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setup() {
        super.setup()
        self.addCornerRadius(radius: 8)
        self.titleLabel?.textColor = .ui.white
    }
    
}

// MARK: - Red Rounded Button

class RedRoundedButton: RoundedButton {
    override func setup() {
        super.setup()
        self.backgroundColor = .ui.cancel
    }
}

//// MARK: - custom color and image Rounded Button
//class ColorizeImageRoundedButton: UIButton {
//
//    override var buttonType: UIButton.ButtonType {
//        return .system
//    }
//
//    init(image: UIImage?, tintColor: UIColor) {
//        super.init(frame: .zero)
//        setup()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setup() {
//
//    }
//}
