//
//  ChatProfileVM.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/13/24.
//

import Foundation


final class ChatInfoVM: NSObject {
    // MARK: - properties
    weak var delegate: ChatUpdatedDelegate?
    private var chat: RMChat
    private var lead: RMLeadModel?
    
    var id: String {
        return chat.id ?? ""
    }
    
    var leadState: LeadState {
        return chat.leadState ?? .cold
    }
    
    // MARK: - init
    init(chat: RMChat) {
        self.chat = chat
    }
    
    func getLead(callback: @escaping (Result<RMLeadModel, Error>) -> Void) {
        let network = NetworkCore(database: .salesguru)
        let path = FirebaseRoutes.createLead(id: id)
        
        network.observe(RMLeadModelParser(), childPath: path) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                self.lead = success
                callback(.success(success))
            case .failure(let failure):
                callback(.failure(failure))
            }
        }
    }
    
    func generateUIModels() -> [UIModelChatSection] {
        let conversationLink = FirebaseDatabase.salesguru.rawValue + FirebaseRoutes.messageRoute(id: chat.id ?? "")
        let leadSetting = UIModelChatSection(title: "Lead settings", rows: [
            UIModelChat(type: .singleRightIcon, title: "Car Information", value: true),
            UIModelChat(type: .lead, title: "Lead Status", value: chat.leadState ?? .cold),
        ])
        
        let leadInfo = UIModelChatSection(title: "Lead Info", rows: [
            UIModelChat(type: .solid, title: "Source", value: chat.source ?? ""),
            UIModelChat(type: .solid, title: "Start Chat", value: Date(timeIntervalSince1970: chat.startChatTs ?? 0).conversationDateFormatter()),
            UIModelChat(type: .solid, title: "Location", value: chat.city ?? "Unknown"),
            UIModelChat(type: .singleButton,
                        title: (chat.appointmentIsSet ?? false) ? "Appointment booked" : "No appointment booked",
                  value: chat.appointmentIsSet ?? false),
            UIModelChat(type: .textButton, title: "conversion link", value: ["Copy": conversationLink]),
        ])
        
        let privacy = UIModelChatSection(title: "Privacy", rows: [
            UIModelChat(type: .textRightIcon, title: "Notifications", value: chat.followUpEnabled ?? false),
            UIModelChat(type: .empty, title: "Block", value: true)
        ])
        
        return [leadSetting, leadInfo, privacy]
    }
    
    func getHeaderInfo() -> UIMChatInfo {
        if let lead = lead {
            return .init(lead: chat.leadState ?? .cold,
                         email: lead.email ?? "Unknown",
                         phone: lead.phoneNumber ?? "Unknown",
                         userName: lead.dealerName ?? "Unknown")
        } else {
            return .init(lead: chat.leadState ?? .cold,
                         email: "Unknown",
                         phone: "Unknown",
                         userName: chat.name ?? "Unknown")
        }
    }
}

// MARK: - update chat
extension ChatInfoVM {
    func updated(chat lead: LeadState) {
        self.chat.leadState = lead
        delegate?.chatUpdated(with: chat)
    }
}
