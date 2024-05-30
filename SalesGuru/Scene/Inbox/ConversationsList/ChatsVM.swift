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
    
    // MARK: - method
    func getConversation(callback: @escaping (Result<[RMChat], Error>) -> Void) {
        network.observe(RMChatParser(), childPath: FirebaseRoutes.conversationList, callback: callback)
    }
}
