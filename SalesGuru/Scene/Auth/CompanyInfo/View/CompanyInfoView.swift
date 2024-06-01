//
//   .swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/1/24.
//


import UIKit

protocol CompanyInformationViewDelegate: CompanyInformationSelectionBoxViewDelegate {
    func submitButtonDidTouched()
    func signInButtonDidTouched()
}

class CompanyInformationView: UIView {
    // MARK: - properties
    private let imageView = UIImageView(image: .get(image: .companyInfo))
    private let titleLabel = UILabel(text: "Company Information", font: .Quicksand.bold(24), textColor: .ui.darkColor4, alignment: .center)
    private let subtitle = UILabel(text: "Please confirm your country code and enter your phone number", font: .Quicksand.light(14), textColor: .ui.darkColor, alignment: .center)
    public let companyName = AuthTextFieldBox(placeholder: "Company name", title: "Company name")
    public let website = AuthTextFieldBox(placeholder: "Dealer website", title: "Website")
    public let dealerType = CompanyInformationSelectionBoxView(type: .dealer)
    public let salesVolume = CompanyInformationSelectionBoxView(type: .sales)
    public let inventory = CompanyInformationSelectionBoxView(type: .inventory)
    private var titleStack: UIStackView!
    private var stack: UIStackView!
    public var submitButton = CustomButton(style: .fill, size: .init(width: 0, height: 60), textColor: .white, fillColor: .ui.primaryBlue, text: Text(text: "Submit", font: .Quicksand.semiBold(16), textColor: .white, alignment: .center))
    private var signInButton: UIButton!
    
    weak var delegate: CompanyInformationViewDelegate? {
        didSet {
            dealerType.delegate = delegate
            salesVolume.delegate = delegate
            inventory.delegate = delegate
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
    
    // MARK: - setupUI
    private func setupUI() {
        backgroundColor = .white
        setupImageView()
        setupTitleStack()
        setupStackView()
        setupSubmitButton()
        setupSignInButton()
    }
    
    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
    }
    
    private func setupTitleStack() {
        subtitle.numberOfLines = 2
        titleStack = .init(axis: .vertical, spacing: 8, arrangedSubviews: [titleLabel, subtitle])
        addSubview(titleStack)
    }
    
    private func setupStackView() {
        stack = UIStackView(axis: .vertical,
                            alignment: .fill,
                            distribution: .equalSpacing,
                            spacing: 12,
                            arrangedSubviews: [companyName, website, dealerType, salesVolume])
        addSubview(stack)
    }
    
    private func setupSubmitButton() {
        submitButton.addTarget(self, action: #selector(submitButtonDidTouched), for: .touchUpInside)
        addSubview(submitButton)
    }
    
    private func setupSignInButton() {
        let attr = "Have an Account? <em>Sign In</em>"
            .highlightingTag("em", font: .Quicksand.semiBold(14), color: .ui.primaryBlue)
        signInButton = UIButton(type: .system, attributedTitle: attr, titleColor: .ui.darkColor4.withAlphaComponent(0.72), font: .Quicksand.medium(14))
        signInButton.addTarget(self, action: #selector(signInButtonDidTouched), for: .touchUpInside)
        addSubview(signInButton)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(0.126 * K.size.portrait.height)
            make.centerX.equalToSuperview()
        }
        
        titleStack.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(52)
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(titleStack.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(35)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(48)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(submitButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - methods
extension CompanyInformationView {
    @objc private func submitButtonDidTouched() {
        self.delegate?.submitButtonDidTouched()
    }
    
    @objc private func signInButtonDidTouched() {
        self.delegate?.signInButtonDidTouched()
    }
}

