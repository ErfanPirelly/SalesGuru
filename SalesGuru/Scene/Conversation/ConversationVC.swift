//
//  ConversationVC.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/29/24.
//

import UIKit

class ConversationVC: UIViewController {
    // MARK: - properties
    private let customView = SingleChatView()
    private let viewModel: ConversationVM
    
    // MARK: - init
    init(viewModel: ConversationVM) {
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
        viewModel.getMessages { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                self.customView.configView(with: success, for: self.viewModel.chat)
                
            case .failure(let failure):
                Logger.log(.error, failure.localizedDescription)
                self.showError(message: failure.localizedDescription)
            }
        }
        
    }
    
    // MARK: - prepare UI
    private func prepareUI() {
        view.backgroundColor = .white
        customView.delegate = self
        view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(CustomTabBarView.Height)
        }
    }
}

// MARK: - view delegate
extension ConversationVC: SingleChatViewDelegate {
    func copyLinkDidTouched() {
        
    }
    
    func deleteChatDidTouched() {
        
    }
    
    func sendMessage(with text: String) {
        
    }
    
    func aiTimerDidTap() {
        let vc = DisableAIVC()
        view.window?.rootViewController?.presentWithCenterPresentation(vc, isDismissable: true)
    }
    
    func isPreviousMessageSameSender(at indexPath: IndexPath) -> Bool {
        viewModel.isPreviousMessageSameSender(at: indexPath)
    }
    
    func isNextMessageSameSender(at indexPath: IndexPath) -> Bool {
        viewModel.isNextMessageSameSender(at: indexPath)
    }
    
    func isDateChanges(at index: IndexPath) -> Bool {
        viewModel.isDateChanges(at: index)
    }
    
    func backButtonDidTouched() {
        navigationController?.popViewController(animated: true)
    }
    
    func moreButtonDidTouched() {
        
    }
    
    func aiButtonDidTouched() {
        
    }
    
    func isFromCurrentUser(at index: IndexPath) -> Bool {
        viewModel.isFromCurrentUser(at: index)
    }
    
    func getPositionForMessage(at index: IndexPath) -> MessagePosition {
        var position: MessagePosition = .first
        if isDateChanges(at: index) {
            if isNextMessageSameSender(at: index) {
                position = .first
            } else {
                position = .single
            }
            return position
        }
        
        if !isPreviousMessageSameSender(at: index) {
            position = isNextMessageSameSender(at: index) ? .first : .single
        } else if isNextMessageSameSender(at: index) {
            position = .middle
        } else {
            position = .last
        }
        
        return position
    }
}
