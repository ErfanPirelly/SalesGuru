//
//  ChatsVM.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/28/24.
//

import Foundation

protocol ChatUpdatedDelegate: AnyObject {
    func chatUpdated(with chat: RMChat)
}

final class ChatsVM: NSObject {
    // MARK: - properties
    let network = NetworkCore(database: .salesguru)
    var filter: IMConversationFilter = .all
    var data: [RMChat] = []
    var searchText: String?
    
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
        var result: [RMChat]
        switch filter {
        case .all:
            result = self.data
        case .appointment:
            result = self.data.filter({$0.appointmentIsSet ?? false})
        case .hot:
            result = self.data.filter({$0.leadState == .hot})
        case .engaged:
            result = self.data.filter({$0.leadState == .engaged})
        case .cold:
            result = self.data.filter({$0.leadState == .cold})
        }
        
        if let txt = searchText {
            return result.filter({$0.filter(with: txt)})
        } else {
            return result
        }
    }
    
    func replaceChat(with chat: RMChat, callback: @escaping (Result<[RMChat], Error>) -> Void) {
        self.data.replaceOrAppend(chat, firstMatchingKeyPath: \.id)
        network.observe(RMSingleChatParser(), childPath: FirebaseRoutes.conversationList+"/\(chat.id ?? "")") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                var newChat = data
                newChat.id = chat.id
                self.data.replaceOrAppend(newChat, firstMatchingKeyPath: \.id)
                callback(.success(self.data))
            case .failure(let failure):
                callback(.failure(failure))
            }
        }
    }
}
