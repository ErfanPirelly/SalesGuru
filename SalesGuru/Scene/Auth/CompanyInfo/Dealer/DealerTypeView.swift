//
//  DealerTypeView.swift
//  Pirelly
//
//  Created by mmdMoovic on 10/27/23.
//

import UIKit
 
protocol DealerTypeItemViewDelegate: AnyObject {
    func selectedItem(with text: String, view: DealerTypeItemView)
}

class DealerTypeView: UIView {
    // MARK: - properties
    private let titleLabel = UILabel(text: "Dealer Type", font: .Fonts.bold(24), textColor: .ui.darkColor4, alignment: .center)
    private var stack: UIStackView!
    public var value: String?
    var items: [DealerTypeItemView] = []
    weak var delegate: DealerTypeItemViewDelegate? {
        didSet {
            items.forEach({
                $0.delegate = delegate
            })
        }
    }
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
        applyCorners(to: .all, with: 24)
        setupTitle()
        setupStack()
        
        snp.makeConstraints { make in
            make.width.equalTo(K.size.portrait.width - 60)
        }
    }
    
    private func setupTitle() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupStack() {
        items = [
            .init(text: "Franchise"),
            .init(text: "Private")
        ]
   
        stack = UIStackView(axis: .vertical,
                            alignment: .fill,
                            spacing: 14,
                            arrangedSubviews: items)
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.leading.trailing.bottom.equalToSuperview().inset(48)
        }
    }
}

// MARK: - Dealer Type Item View
class DealerTypeItemView: UIView {
    // MARK: - properties
    private let radioButton = UIRadioButton(frame: .init(x: 0, y: 0, width: 18, height: 18))
    public let title = UILabel(font: .Fonts.semiBold(13),
                               textColor: .white,
                               alignment: .left)
    weak var delegate: DealerTypeItemViewDelegate?
    
    // variables
    var selected: Bool = false {
        didSet {
            radioButton.color = (selected ? .white :
                    .ui.primaryBlue) ?? .clear
            radioButton.isSelected = selected
            title.textColor = selected ? .white : .ui.primaryBlue
            backgroundColor = selected ? .ui.primaryBlue : .white
        }
    }
    // MARK: - init
    init(text: String) {
        super.init(frame: .zero)
        self.title.text = text
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup UI
    private func setupUI() {
        selected = false
        applyCorners(to: .all, with: 15)
        addBorder(color: .ui.primaryBlue ?? .blue, thickness: 1)
        setupStackView()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelect(gesture:))))
        snp.makeConstraints { make in
            make.height.equalTo(58)
        }
    }
    
    private func setupStackView() {
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        radioButton.color = .ui.primaryBlue ?? .clear
        radioButton.isSelected = false
        radioButton.isUserInteractionEnabled = false
        
        let stack = UIStackView(arrangedSubviews: [title, radioButton])
        addSubview(stack)
        radioButton.snp.makeConstraints { make in
            make.size.equalTo(18)
        }
        stack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc private func didSelect(gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.15, animations: {
            self.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
            self.alpha = 0.6
            self.delegate?.selectedItem(with: self.title.text ?? "", view: self)
        }) { _ in
            UIView.animate(withDuration: 0.15) {
                self.transform = .identity
                self.alpha = 1
            }
        }
    }
}
