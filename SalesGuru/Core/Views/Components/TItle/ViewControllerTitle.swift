//
//  ViewControllerTitle.swift
//  Pirelly
//
//  Created by mmdMoovic on 11/7/23.
//

import UIKit

protocol ViewControllerTitleDelegate: AnyObject {
    func didTapBackButton()
}

class ViewControllerTitle: UIView {
    /// - Note -> button Height + SafeAreaTopInsets + backButton top inset +   backButton bottom inset
    static let height = 52 + UIView.safeArea.top + 12 + 12
    // MARK: - properties
    let titleLabel = UILabel(font: .Fonts.bold(24), textColor: .ui.primaryBlue, alignment: .center)
    let backButton = BackButton()
    weak var delegate: ViewControllerTitleDelegate?
    
    // MARK: - init
    init(tintColor: UIColor? = .ui.primaryBlue,
         title: String,
         delegate: ViewControllerTitleDelegate? = nil) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.backButton.tintColor = tintColor
        self.delegate = delegate
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup UI
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        addSubview(backButton)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(UIView.safeArea.top + 12)
            make.bottom.equalToSuperview().inset(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton)
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard superview != nil && !(superview is UIStackView)  else { return }
        snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
    
    @objc private func didTapBackButton() {
        delegate?.didTapBackButton()
    }
}

