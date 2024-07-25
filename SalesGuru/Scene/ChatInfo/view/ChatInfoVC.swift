//
//  ChatInfoVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/13/24.
//

import UIKit
import SwiftUI

class ChatInfoVC: UIViewController {
    // MARK: - properties
    private let customView = ChatInfoView()
    let viewModel: ChatInfoVM
    
    // MARK: - init
    init(viewModel: ChatInfoVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    // MARK: - prepare UI
    private func prepareUI() {
        view.backgroundColor = .white
        view.addSubview(customView)
        customView.delegate = self
        customView.pinToEdge(on: view)
        configView(loading: true)
        
        viewModel.getLead { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                self.configView()
            case .failure(let failure):
                self.showError(message: failure.localizedDescription)
            }
        }
    }
    
    func configView(loading: Bool = false) {
        customView.config(view: viewModel.generateUIModels(), headerInfo: viewModel.getHeaderInfo(), loading: loading)
    }
}

// MARK: - view delegate
extension ChatInfoVC: ChatInfoViewDelegate {
    func emailButtonDidTouched() {
        
    }
    
    func phoneButtonDidTouched() {
        
    }
    
    func backButtonDidTouched() {
        navigationController?.popViewController(animated: true)
    }
    
    func didSelectCarInfo() {
        let viewModel = CarInfoVM(id: self.viewModel.id)
        let vc = UIHostingController(rootView: CarInfoView(viewModel: viewModel) {[weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        })
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didSelectChatLead() {
        let viewModel = ChatLeadVM(id: self.viewModel.id)
        viewModel.delegate = self
        let vc = UIHostingController(rootView: ChatLeadView(viewModel: viewModel,
                                                            selectedLead: self.viewModel.leadState) {[weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        })
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ChatInfoVC: ChatLeadVMDelegate {
    func updated(chat lead: LeadState) {
        viewModel.updated(chat: lead)
        configView()
    }
}
