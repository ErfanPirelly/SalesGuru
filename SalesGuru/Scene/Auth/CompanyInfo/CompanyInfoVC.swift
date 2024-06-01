//
//  CompanyInfoVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/1/24.
//

import UIKit

final class CompanyInformationVC: AuthViewController {
    private let customView = CompanyInformationView()
    var txtCompanyName: AuthTextFieldBox {
        return customView.companyName
    }
    
    var txtWebsite: AuthTextFieldBox {
        return customView.website
    }
    
    var txtDealerType: CompanyInformationSelectionBoxView {
        return customView.dealerType
    }
    
    var txtSalesVolume: CompanyInformationSelectionBoxView {
        return customView.salesVolume
    }
    
    var inventory: CompanyInformationSelectionBoxView {
        return customView.inventory
    }
    
    var submitButton: UIButton {
        return customView.submitButton
    }
    
    let viewModel: CompanyInformationVM
    var output: Output?
    
    // MARK: - init
    init(viewModel: CompanyInformationVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Life Cycle
extension CompanyInformationVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(customView)
        customView.delegate = self
        customView.pinToEdge(on: view)
        bindViewModel()
    }
}

// MARK: - View Implementation

extension CompanyInformationVC {
    func bindViewModel() {
        self.viewModel.error.asDriver().drive(onNext: {[weak self] error in
            guard let self = self, let message = error?.localizedDescription else { return }
            self.showError(message: message)
            self.submitButton.unlock()
        }).disposed(by: viewModel.bag)
        
        self.viewModel.dealerType.asDriver().drive(onNext: {[weak self] value in
            guard let self = self, let value = value else { return }
            self.txtDealerType.setValue(value: value)
        }).disposed(by: viewModel.bag)
        
        self.viewModel.salesVolume.asDriver().drive(onNext: {[weak self] value in
            guard let self = self, let value = value else { return }
            self.txtSalesVolume.setValue(value: value)
        }).disposed(by: viewModel.bag)
    }
    
    func error(in textField: CompanyInformationValidator.TextFields,
               message: String) {
        switch textField {
        case .name:
            txtCompanyName.showError()
        case .website:
            txtWebsite.showError()
        case .dealerType:
            txtDealerType.showError()
        case .salesVolume:
            txtSalesVolume.showError()
        }
    }

    func show(info message: String) {
        CustomToast(view: view).show(information: message)
    }

    func hideTextFieldMessages() {
        txtCompanyName.clearError()
        txtWebsite.clearError()
        txtDealerType.clearError()
        txtSalesVolume.clearError()
    }
}

// MARK: - Company Information View Delegate
extension CompanyInformationVC: CompanyInformationViewDelegate {
    func submitButtonDidTouched() {
        hideTextFieldMessages()
        view.endEditing(true)
        let salesIndex = self.viewModel.salesVolumes.firstIndex(of: viewModel.salesVolume.value ?? "")
        let inputs = IMCompanyInformation(companyName: txtCompanyName.text,
                                          website: txtWebsite.text,
                                          dealerType: viewModel.dealerType.value?.lowercased() ?? "",
                                          salaesVolume: salesIndex)
        self.submitButton.lock()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) { [weak self] in
            guard let self = self else { return }
            self.viewModel.validate(inputs: inputs) { [weak self] result in
                guard let self = self else { return }
                self.submitButton.unlock()
                switch result {
                case .success:
                    self.action(.home)
                    
                case .failure(let failure):
                    self.error(in: failure.textField, message: failure.message)
                }
            }
        }
    }
    
    func signInButtonDidTouched() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func didSelectBox(with type: CompanyInformationBox) {
        view.endEditing(true)
        output?.action(type)
    }
}

// MARK: - output
extension CompanyInformationVC {
    struct Output {
        let action: (CompanyInformationBox) -> Void
    }
}
