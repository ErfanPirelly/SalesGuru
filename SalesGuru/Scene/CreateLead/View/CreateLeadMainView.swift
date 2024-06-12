//
//  CreateLeadMainView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/4/24.
//

import UIKit
import SnapKit

protocol CreateLeadMainViewDelegate: AnyObject {
    func stateDidUpdated(to state: CreateLeadMainView.State)
    func submitButtonDidTouched(with profile: IMLeadProfileInfo, setting: IMLeadAISetting)
}

class CreateLeadMainView: UIView {
    enum State {
        case personalInfo
        case aiSetting
        
        var containerHeight: CGFloat {
            switch self {
            case .personalInfo:
                return 265
            case .aiSetting:
                return 351
            }
        }
    }

    // MARK: - properties
    private let disableColor = UIColor(p3: "#0D0A19")
    private let panView = PanView()
    private let title = UILabel(text: "Create Lead", font: .Quicksand.bold(27.3), textColor: .ui.darkColor, alignment: .left)
    private var titleStack: UIStackView!
    private let submitButton = CustomButton(style: .fill,
                                            size: .init(width: 0, height: 52),
                                            textColor: .white,
                                            fillColor: .ui.primaryBlue, text: Text(text: "Submit", font: .Quicksand.semiBold(20), textColor: .white, alignment: .center))
    private let progressBar = UIProgressView(progressViewStyle: .default)
    private let infoButton = UIButton(title: "Personal Info", titleColor: .ui.darkColor, font: .Fonts.bold(14))
    private let aiSettingButton = UIButton(title: "Ai Settings", titleColor: UIColor(p3: "#0D0A19"), font: .Fonts.medium(14))
    private var buttonStack: UIStackView!
    private var progressStack: UIStackView!
    private let container = UIView()
    private let personalInfoView = LeadProfileInfoView()
    private let aiSetting = CreateLeadAISettingView()
    private var containerStack: UIStackView!
    
    // constraints
    private var containerHeightConstraint: Constraint!
    private var containerStackLeadingConstraint: Constraint!
    
    // variable
    weak var delegate: CreateLeadMainViewDelegate?
    private var state: State = .personalInfo {
        didSet {
            infoButton.titleLabel?.font = state == .personalInfo ? .Fonts.bold(14) : .Fonts.medium(14)
            infoButton.setTitleColor(state == .personalInfo ? .ui.darkColor : disableColor, for: .normal)
            
            aiSettingButton.titleLabel?.font = state == .aiSetting ? .Fonts.bold(14) : .Fonts.medium(14)
            aiSettingButton.setTitleColor(state == .aiSetting ? .ui.darkColor : disableColor, for: .normal)
            
        }
    }
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup UI
    private func setupUI() {
        setupProgressStack()
        setupTitleStack()
        setupContainer()
        setupContainerSubviews()
        setupSubmitButton()
        setupConstraints()
    }
    
    private func setupProgressStack() {
        func setupButtonStack() {
            infoButton.addTarget(self, action: #selector(infoButtonDidTouched), for: .touchUpInside)
            aiSettingButton.addTarget(self, action: #selector(aiSettingButtonDidTouched), for: .touchUpInside)
            buttonStack = .init(spacing: 10, arrangedSubviews: [infoButton, aiSettingButton])
        }
        
        func setupProgressButton() {
            progressBar.translatesAutoresizingMaskIntoConstraints = false
            progressBar.trackTintColor = .init(p3: "#F7F7FC")
            progressBar.progressTintColor = .ui.primaryBlue
            progressBar.setProgress(0.5, animated: false)
            progressBar.applyCorners(to: .all, with: 4)
        }
        
        setupProgressButton()
        setupButtonStack()
        progressStack = .init(axis: .vertical, alignment: .fill, spacing: 0, arrangedSubviews: [progressBar, buttonStack])
        addSubview(progressStack)
    }
    
    private func setupTitleStack() {
        titleStack = .init(axis: .vertical, distribution: .fillProportionally, spacing: 24, arrangedSubviews: [panView, title])
        titleStack.setCustomSpacing(24, after: panView)
        addSubview(titleStack)
    }
    
    private func setupSubmitButton() {
        submitButton.addTarget(self, action: #selector(submitButtonDidTouched), for: .touchUpInside)
        addSubview(submitButton)
    }
    
    private func setupContainer() {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        container.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
        addSubview(container)
    }
    
    private func prepareUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
        applyCorners(to: .top, with: 45)
    }
    
    private func setupContainerSubviews() {
        aiSetting.translatesAutoresizingMaskIntoConstraints = false
        containerStack = .init(alignment: .top,
                               distribution: .fillEqually,
                               spacing: 0, arrangedSubviews: [personalInfoView, aiSetting])
        container.addSubview(containerStack)
    }
    
    private func setupConstraints() {
        titleStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        progressBar.snp.makeConstraints { make in
            make.height.equalTo(8)
        }
        
        progressStack.snp.makeConstraints { make in
            make.top.equalTo(titleStack.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(33)
        }
        
        container.snp.makeConstraints { make in
            make.top.equalTo(buttonStack.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(submitButton.snp.top)
            containerHeightConstraint = make.height.equalTo(state.containerHeight).constraint
        }
        
        submitButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(33)
            make.bottom.equalToSuperview().inset(UIView.safeArea.bottom + 16)
        }
        
        containerStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(K.size.portrait.width * 2)
            containerStackLeadingConstraint = make.leading.equalToSuperview().constraint
        }
    }
    
    func updateState(to state: State) {
        guard self.state != state else { return }
        self.state = state
        let leadingInset = state == .personalInfo ? 0 : -K.size.portrait.width
        let animator = UIViewPropertyAnimator(duration: 0.35, curve: .linear) {
            self.progressBar.setProgress(state == .personalInfo ? 0.5 : 1, animated: true)
            self.containerHeightConstraint.update(offset: state.containerHeight)
            self.containerStackLeadingConstraint.update(inset: leadingInset)
            self.layoutIfNeeded()
            self.delegate?.stateDidUpdated(to: state)
        }
        animator.startAnimation()
    }
    
    func startLoading() {
        self.submitButton.lock()
    }
    
    func stopLoading() {
        self.submitButton.unlock()
    }
}

// MARK: - objc
extension CreateLeadMainView {
    @objc func submitButtonDidTouched() {
        if state == .personalInfo {
            if personalInfoView.getValue() != nil {
                self.updateState(to: .aiSetting)
            }
        } else {
            if let profile = personalInfoView.getValue(), let ai = aiSetting.getValue() {
                self.delegate?.submitButtonDidTouched(with: profile, setting: ai)
                self.startLoading()
            }
        }
    }
    
    @objc func infoButtonDidTouched() {
        updateState(to: .personalInfo)
    }
    
    @objc func aiSettingButtonDidTouched() {
        updateState(to: .aiSetting)
    }
}
