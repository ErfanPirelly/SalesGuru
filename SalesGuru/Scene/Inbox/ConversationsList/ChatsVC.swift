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
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        navigationController?.isNavigationBarHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - prepare UI
    private func prepareUI() {
        view.addSubview(customView)
        customView.pinToEdge(on: view)
        customView.delegate = self
    }
}

private extension ChatsVC {
    func presentConversation() {
        let vc = ConversationVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: -  view delegate
extension ChatsVC: ChatViewDelegate {
    func didSelectFilter(with: IMConversationFilter) {
        Logger.log(.info, with.rawValue)
    }
    
    func deSelectFilter(with: IMConversationFilter) {
        Logger.log(.info, with.rawValue)
    }
    
    func didSelectConversation() {
        presentConversation()
    }
}
