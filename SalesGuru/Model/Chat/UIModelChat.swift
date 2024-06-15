//
//  UIModelChat.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/13/24.
//

import Foundation

protocol UIModelChatProtocol {
    var type: ChatInfoCellType {get set}
    var title: String {get set}
    var value: Any {get set}
}


struct UIModelChat: UIModelChatProtocol {
    var type: ChatInfoCellType
    var title: String
    var value: Any
}

struct UIModelChatSection {
    let title: String
    let rows: [UIModelChatProtocol]
}

struct UIMChatInfo {
    let lead: LeadState
    let email: String
    let phone: String
    let respondTime: String
    let userName: String
}
