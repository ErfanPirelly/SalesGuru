//
//  InboxVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/23/24.
//

import UIKit

class ChatsVC: UIViewController {
    // MARK: - properties
    private let customView = ChatsView()
    private let viewModel = ChatsVM()
    public var output: Outputs?
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        prepareUI()
        getData()
    }
    
    // MARK: - prepare UI
    private func prepareUI() {
        view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(CustomTabBarView.Height)
        }
        customView.delegate = self
    }
    
    func getData() {
        viewModel.getConversation { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.customView.setData(data: success)
                }
            case .failure(let failure):
                Logger.log(.error, failure.localizedDescription)
                self.showError(message: failure.localizedDescription)
            }
        }
    }
}

// MARK: -  view delegate
extension ChatsVC: ChatViewDelegate {
    func refreshData() {
        self.getData()
    }
    
    func didSearch(with text: String?) {
        viewModel.searchText = text?.lowercased()
        customView.setData(data: viewModel.getData())
    }
    
    func didSelectNotification() {
        output?.action(.notification)
    }
    
    func didSelectSetting() {
        
    }
    
    func didSelect(chat with: RMChat) {
        let vc = ChatInfoVC(viewModel: .init(chat: with))
        
//        let vc = ConversationVC(viewModel: .init(chat: with))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addLeadDidTouched() {
        let vc = CreateLeadMainVC()
        self.view.window?.rootViewController?.presentWithSheetPresentation(vc, isDismissable: true)
    }
    
    func didSelectFilter(with: IMConversationFilter) {
        viewModel.filter = with
        customView.setData(data: viewModel.getData())
    }
}

// MARK: - more actions
extension ChatsVC {
    enum Actions {
        case notification
    }
    
    struct Outputs {
        let action: (Actions) -> Void
    }
    
}
