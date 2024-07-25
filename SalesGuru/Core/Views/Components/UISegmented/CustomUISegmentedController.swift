//
//  CustomUISegmentedController.swift
//  Pirelly
//
//  Created by mmdMoovic on 10/5/23.
//

import UIKit

protocol CustomSegmentedControlDelegate: AnyObject {
    func segmentedChanged(to index: Int)
}

class CustomUISegmentedController: UIView {
    // MARK: - properties
    private let buttonTitles:[String]
    private let buttonText: [CustomText]
    
    private var buttons: [UIButton]!
    var selectorView: UIView!
    private var stack: UIStackView!
    private var textColor:UIColor
    private var selectorViewColor: UIColor
    private var selectorTextColor: UIColor
    
    weak var delegate: CustomSegmentedControlDelegate?
    
    public private(set) var selectedIndex : Int = 0
    
    // MARK: - init
    init(buttonText:[CustomText],
         selectorViewColor: UIColor = .ui.darkColor4.withAlphaComponent(0.83),
         selectorTextColor: UIColor = .white,
         textColor:UIColor = .white.withAlphaComponent(0.5)) {
        self.selectorViewColor = selectorViewColor
        self.selectorTextColor = selectorTextColor
        self.textColor = textColor
        self.buttonText = buttonText
        self.buttonTitles = buttonText.compactMap(\.text)
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        selectorView.frame.size.height = buttons.first?.frame.height ?? 0
        selectorView.frame.size.width = stack.frame.width/CGFloat(buttons.count)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        selectorView.frame.size.height = buttons.first?.frame.height ?? 0
        selectorView.frame.size.width = stack.frame.width/CGFloat(buttons.count)
    }
    // MARK: - setup UI
    func setupUI() {
        backgroundColor = .ui.darkColor4.withAlphaComponent(0.78)
        applyCorners(to: .all, with: 5)
        createButton()
        configStackView()
        configSelectorView()
    }
    
    func setIndex(index:Int) {
        buttons.forEach({ $0.setTitleColor(textColor, for: .normal) })
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
        UIView.animate(withDuration: 0.2) {
            self.selectorView.frame.origin.x = selectorPosition
        }
    }
    
    @objc func buttonAction(sender: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                let selectorPosition = btn.frame.origin.x
                selectedIndex = buttonIndex
                delegate?.segmentedChanged(to: selectedIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
}


//Configuration View
extension CustomUISegmentedController {
    private func configStackView() {
        stack = UIStackView(axis: .horizontal, alignment: .fill, distribution: .fillEqually, spacing: 3, arrangedSubviews: buttons)
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.leading.trailing.equalToSuperview().inset(12)
        }
    }
    
    private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        selectorView = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: self.frame.height))
        selectorView.applyCorners(to: .all, with: 2)
        selectorView.backgroundColor = selectorViewColor
        stack.insertSubview(selectorView, at: 0)
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonText {
            let button = UIButton(type: .system, title: buttonTitle.text,
                                  attributedTitle: buttonTitle.attributedText,
                                  titleColor: buttonTitle.textColor,
                                  font: buttonTitle.font)
            button.addTarget(self, action:#selector(buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    }
    
    
}
