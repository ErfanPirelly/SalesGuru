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
    public var output: Outputs?
    private let viewModel = ChatsVM()
    
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

private extension ChatsVC {

}

// MARK: -  view delegate
extension ChatsVC: ChatViewDelegate {
    func didSelect(chat with: RMChat) {
        let vc = ConversationVC(viewModel: .init(chat: with))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addLeadDidTouched() {
        Logger.log(.info, "add lead")
    }
    
    func didSelectFilter(with: IMConversationFilter) {
        viewModel.filter = with
        customView.setData(data: viewModel.getData())
    }
    
    func deSelectFilter(with: IMConversationFilter) {}
}

// MARK: - more actions
extension ChatsVC {
    enum Actions {
        
    }
    
    struct Outputs {
        let action: (Actions) -> Void
    }
    
}
