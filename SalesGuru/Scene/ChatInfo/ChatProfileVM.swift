//
//  ChatProfileVM.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/13/24.
//

import Foundation

final class ChatInfoVM: NSObject {
    // MARK: - properties
    private let chat: RMChat
    
    // MARK: - init
    init(chat: RMChat) {
        self.chat = chat
    }
    
    func generateUIModels() -> [UIModelChatSection] {
        let conversationLink = FirebaseDatabase.salesguru.rawValue + FirebaseRoutes.messageRoute(id: chat.id ?? "")
        let leadSetting = UIModelChatSection(title: "Lead settings", rows: [
            UIModelChat(type: .singleRightIcon, title: "Car Information", value: true),
            UIModelChat(type: .lead, title: "Lead Status", value: chat.leadState ?? .cold),
        ])
        
        let leadInfo = UIModelChatSection(title: "Lead Info", rows: [
            UIModelChat(type: .solid, title: "Source", value: chat.source),
            UIModelChat(type: .solid, title: "Start Chat", value: Date(timeIntervalSince1970: chat.startChatTs ?? 0).conversationDateFormatter()),
            UIModelChat(type: .solid, title: "Location", value: chat.city ?? "Unknown"),
            UIModelChat(type: .singleButton,
                        title: (chat.appointmentIsSet ?? false) ? "Appointment booked" : "No appointment booked",
                  value: chat.appointmentIsSet),
            UIModelChat(type: .textButton, title: "conversion link", value: ["Copy": conversationLink]),
        ])
        
        let privacy = UIModelChatSection(title: "Privacy", rows: [
            UIModelChat(type: .textRightIcon, title: "Notifications", value: chat.followUpEnabled),
            UIModelChat(type: .empty, title: "Block", value: true)
        ])
        
        return [leadSetting, leadInfo, privacy]
    }
    
    func getHeaderInfo() -> UIMChatInfo {
        .init(lead: chat.leadState ?? .cold, email: "no email did set", phone: "no phone number", respondTime: "no response time", userName: chat.name ?? "Unknown")
    }
}
