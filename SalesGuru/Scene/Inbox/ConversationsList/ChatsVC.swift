//
//  InboxVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/23/24.
//

import UIKit
import TipKit
import SwiftUI


class ChatsVC: UIViewController {
    // MARK: - properties
    private let customView = ChatsView()
    private let viewModel = ChatsVM()
    public var output: Outputs?
    var chatFeatureTip = ChatTipView()
    private var tipObservationTask: Task<Void, Never>?
    private var tipVC: UIViewController?
    private var actions: [Action] = []
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        prepareUI()
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        releaseActions()
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
    
    func presentTips() {
        tipObservationTask = tipObservationTask ?? Task { @MainActor in
            if #available(iOS 17.0, *) {
                for await shouldDisplay in chatFeatureTip.shouldDisplayUpdates {
                    if shouldDisplay {
                        let popoverController = TipUIPopoverViewController(chatFeatureTip, sourceItem: customView.plusButton)
                        popoverController.presentationDelegate = self
                        
                        self.view.dimming()
                        present(popoverController, animated: true)
                        self.tipVC = popoverController
                    } else {
                        self.view.removeDime()
                        self.tipVC?.dismiss(animated: true)
                    }
                }
            }
        }

        if #available(iOS 17.0, *) {
            chatFeatureTip.show = true
        } else {
            // Fallback on earlier versions
        }
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            if #available(iOS 17.0, *) {
                try? Tips.configure([.displayFrequency(.immediate)])
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    func releaseActions() {
        for action in actions {
            action()
        }
        actions.removeAll()
    }
}

extension ChatsVC: UIPopoverPresentationControllerDelegate {
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        self.view.removeDime()
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
    
    func didSelectSetting() {}
    
    func didSelect(chat with: RMChat) {
        guard let id = with.id else {return}
        let viewModel = ConversationVM(id: id)
        viewModel.delegate = self
        let vc = ConversationVC(viewModel: viewModel)
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

extension ChatsVC: ChatUpdatedDelegate {
    func chatUpdated(with chat: RMChat) {
        viewModel.replaceChat(with: chat) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                self.actions.append {[weak self] in
                    guard let self = self else { return }
                    self.customView.setData(data: success)
                }
            case .failure(let failure):
                Logger.log(.error, failure)
            }
        }
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
