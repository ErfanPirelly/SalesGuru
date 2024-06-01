//
//  ChatsVM.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/28/24.
//

import Foundation

final class ChatsVM: NSObject {
    // MARK: - properties
    let network = NetworkCore(database: .salesguru)
    var filter: IMConversationFilter = .all
    var data: [RMChat] = []
    
    // MARK: - method
    func getConversation(callback: @escaping (Result<[RMChat], Error>) -> Void) {
        network.observe(RMChatParser(), childPath: FirebaseRoutes.conversationList) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.data = data.filter({$0.lastMessage != nil}).sorted(by: {$0.timestamp > $1.timestamp})
                callback(.success(self.getData()))
            case .failure(let failure):
                callback(.failure(failure))
            }
        }
    }
    
    func getData() -> [RMChat] {
        switch filter {
        case .all:
            return self.data
        case .appointment:
            return self.data.filter({$0.appointmentIsSet ?? false})
        case .hot:
            return self.data.filter({$0.leadState == .hot})
        case .engaged:
            return self.data.filter({$0.leadState == .engaged})
        case .cold:
            return self.data.filter({$0.leadState == .cold})
        }
    }
}
