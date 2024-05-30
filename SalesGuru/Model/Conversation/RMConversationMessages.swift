//
//  RMConversationMessages.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/30/24.
//

import Foundation

struct RMConversationMessages: Codable {
    let content: String
    let user: RMUser
    let date: String = "03:24 AM"
}


struct RMUser: Codable {
    let id: Int
}
