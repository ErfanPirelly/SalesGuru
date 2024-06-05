//
//  CreateLeadAISettingView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/5/24.
//

import UIKit
import RxSwift
import RxCocoa

class CreateLeadAISettingView: UIView {
    // MARK: - properties
    private let bag = DisposeBag()
    private let scrollView = UIScrollView()
    public let vinNumberTextField = AuthTextFieldBox(placeholder: "Vin Number", title: "VIN")
    public let leadDescriptionTextView = AuthTextView(placeholder: "Describe your lead", title: "Description")
    private let testDriveView = UIView()
    private let switchView = CustomUISwitch(onTintColor: .ui.primaryBlue,
                                          offTintColor: .ui.darkColor1.withAlphaComponent(0.17),
                                          thumbTintColor: .white,
                                          thumbCornerRadius: 5.8,
                                          thumbSize: .init(width: 11.6, height: 11.6),
                                          padding: 3,
                                          isOn: true,
                                          animationDuration: 0.3)
    
    private var stack: UIStackView!
    
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
        translatesAutoresizingMaskIntoConstraints = false
        setupScrollView()
        setupStackView()
        setupConstraints()
    }
    
    private func setupTestDrive() {
        testDriveView.applyCorners(to: .all, with: 10)
        testDriveView.backgroundColor = .ui.BoxBackgroundColor
        testDriveView.translatesAutoresizingMaskIntoConstraints = false
        switchView.translatesAutoresizingMaskIntoConstraints = false
        let title = UILabel(text: "Test drive?", font: .Quicksand.bold(14), textColor: .ui.darkColor, alignment: .left)
        let subtitle = UILabel(text: "Has this lead performed a test drive?", font: .Quicksand.medium(11), textColor: .ui.darkColor3, alignment: .left)
        let stack = UIStackView(axis: .vertical, alignment: .leading, distribution: .equalSpacing, spacing: 5, arrangedSubviews: [title, subtitle])
        testDriveView.addSubview(stack)
        testDriveView.addSubview(switchView)
        
        stack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(22)
        }
        
        switchView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(22)
            make.centerY.equalToSuperview()
            
            make.height.equalTo(16)
            make.width.equalTo(29)
        }
    }
    
    private func setupStackView() {
        setupTestDrive()
        stack = .init(axis: .vertical, alignment: .fill, distribution: .equalSpacing, spacing: 17, arrangedSubviews: [vinNumberTextField, leadDescriptionTextView, testDriveView])
        scrollView.addSubview(stack)
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .onDrag
        scrollView.rx.observe(\.contentSize).asDriver(onErrorJustReturn: .zero).drive(onNext: {[weak self] size in
            guard let self = self else { return }
            Logger.log(.info, size)
        }).disposed(by: bag)
        addSubview(scrollView)
    }
    
    private func setupConstraints() {
        scrollView.pinToEdge(on: self)
        stack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
            make.width.equalTo(K.size.portrait.width - 64)
        }
        
        scrollView.snp.makeConstraints { make in
            make.height.equalTo(351)
        }
    }
}
