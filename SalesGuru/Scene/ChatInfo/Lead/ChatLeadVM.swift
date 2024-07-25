//
//  ChatLeadVM.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/24/24.
//

import Combine

protocol ChatLeadVMDelegate: AnyObject {
    func updated(chat lead: LeadState)
}

final class ChatLeadVM: ObservableObject {
    // MARK: - properties
    let id: String
    @Published var loading: Bool = false
    @Published var error: String?
    
    weak var delegate: ChatLeadVMDelegate?
    
    // MARK: - init
    init(id: String) {
        self.id = id
    }
    
    func changeChat(lead to: LeadState) {
        error = nil
        loading = true
        
        let network = NetworkCore(database: .salesguru)
        let path = FirebaseRoutes.conversationList + "/\(id)/leadState"
        network.setValue(for: path, data: to.rawValue) { [weak self] result in
            guard let self = self else { return }
            loading = false
            switch result {
            case .success:
                self.delegate?.updated(chat: to)
            case .failure(let failure):
                self.error = failure.localizedDescription
            }
        }
    }
}
