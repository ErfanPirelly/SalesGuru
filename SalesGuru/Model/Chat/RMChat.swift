//
//  RMChat.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/28/24.
//

import UIKit

// hot, cold, contactAttemped
enum LeadState: String, Codable {
    case engaged = "contactAttemped"
    case hot
    case cold
    
    var title: String {
        switch self {
        case .engaged:
            return "Re Engaged Lead"
        case .hot:
            return "Hot Lead"
        case .cold:
            return "Cold Lead"
        }
    }
    
    var chatInfoStr: String {
        switch self {
        case .engaged:
            return "Re Engaged"
        case .hot:
            return "Hot"
        case .cold:
            return "Cold"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .engaged:
            return .get(image: .sun)
        case .hot:
            return .get(image: .flame)
        case .cold:
            return .get(image: .ice)
        }
    }
    
    var color: UIColor {
        switch self {
        case .engaged:
            return .ui.green1
        case .hot:
            return .ui.red
        case .cold:
            return .ui.primaryBlue
        }
    }
    
    var secondaryColor: UIColor {
        switch self {
        case .engaged: return .init(p3: "#45DB9C")
        case .hot: return .init(p3: "#CD2929")
        case .cold: return .init(p3: "#0087D3")
        }
    }
}

struct RMChat: RMKeyIDModel, Hashable {
    static func == (lhs: RMChat, rhs: RMChat) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: String?
    let aiMode, appointment, appointmentIsSet : Bool?
    let appointmentTime: Double?
    let city: String?
    let followUp: Bool?
    let followUpCounter: Double?
    let followUpEnabled: Bool?
    let followUpMessage: String?
    let followUpMessgesLength: Double?
    let followUpTime: String?
    let isCarSold, isEngaged: Bool?
    let name: String?
    let read, sleepStatus: Bool?
    let source: String?
    let startChatTs: Double?
    let unreadCounter: Int?
    let lastMessage: LastMessage?
    let leadState: LeadState?
    
    var timestamp: Double {
        return (lastMessage?.timestamp ?? 0) / 1000
    }
    
    init(aiMode: Bool? = nil,
         appointment: Bool? = nil,
         appointmentIsSet: Bool? = nil,
         appointmentTime: Double? = nil,
         city: String? = nil,
         followUp: Bool? = nil,
         followUpCounter: Double? = nil,
         followUpEnabled: Bool? = nil,
         followUpMessage: String? = nil,
         followUpMessgesLength: Double? = nil,
         followUpTime: String? = nil,
         isCarSold: Bool? = nil,
         isEngaged: Bool? = nil,
         name: String? = nil,
         read: Bool? = nil,
         sleepStatus: Bool? = nil,
         source: String? = nil,
         startChatTs: Double? = nil,
         unreadCounter: Int? = nil,
         lastMessage: LastMessage? = nil,
         leadState: LeadState? = nil) {
        self.lastMessage = lastMessage
        self.aiMode = aiMode
        self.appointment = appointment
        self.appointmentIsSet = appointmentIsSet
        self.appointmentTime = appointmentTime
        self.city = city
        self.followUp = followUp
        self.followUpCounter = followUpCounter
        self.followUpEnabled = followUpEnabled
        self.followUpMessage = followUpMessage
        self.followUpMessgesLength = followUpMessgesLength
        self.followUpTime = followUpTime
        self.isCarSold = isCarSold
        self.isEngaged = isEngaged
        self.name = name
        self.read = read
        self.sleepStatus = sleepStatus
        self.source = source
        self.startChatTs = startChatTs
        self.unreadCounter = unreadCounter
        self.leadState = leadState
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.aiMode = try? container.decode(Bool.self, forKey: .aiMode)
        self.appointment = try? container.decode(Bool.self, forKey: .appointment)
        self.appointmentIsSet = try? container.decode(Bool.self, forKey: .appointmentIsSet)
        self.appointmentTime = try? container.decodeIfPresent(Double.self, forKey: .appointmentTime)
        self.city = try? container.decodeIfPresent(String.self, forKey: .city)
        self.followUp = try? container.decodeIfPresent(Bool.self, forKey: .followUp)
        self.followUpCounter = try? container.decodeIfPresent(Double.self, forKey: .followUpCounter)
        self.followUpEnabled = try? container.decodeIfPresent(Bool.self, forKey: .followUpEnabled)
        self.followUpMessage = try? container.decodeIfPresent(String.self, forKey: .followUpMessage)
        self.followUpMessgesLength = try? container.decodeIfPresent(Double.self, forKey: .followUpMessgesLength)
        self.followUpTime = try? container.decodeIfPresent(String.self, forKey: .followUpTime)
        self.isCarSold = try? container.decodeIfPresent(Bool.self, forKey: .isCarSold)
        self.isEngaged = try? container.decodeIfPresent(Bool.self, forKey: .isEngaged)
        self.name = try? container.decodeIfPresent(String.self, forKey: .name)
        self.read = try? container.decodeIfPresent(Bool.self, forKey: .read)
        self.sleepStatus = try? container.decodeIfPresent(Bool.self, forKey: .sleepStatus)
        self.source = try? container.decodeIfPresent(String.self, forKey: .source)
        self.startChatTs = try? container.decodeIfPresent(Double.self, forKey: .startChatTs)
        self.unreadCounter = try? container.decodeIfPresent(Int.self, forKey: .unreadCounter)
        self.lastMessage = try? container.decodeIfPresent(LastMessage.self, forKey: .lastMessage)
        self.leadState = try? container.decodeIfPresent(LeadState.self, forKey: .leadState)
    }
    
    func filter(with txt: String) -> Bool {
        let content = lastMessage?.content?.lowercased().contains(txt) ?? false
        let username = name?.lowercased().contains(txt) ?? false
        let source = source?.lowercased().contains(txt) ?? false
        return content || username || source
    }
}


struct LastMessage: Codable {
    let content, messageID: String?
    let timestamp: Double
}


struct RMChatParser: FirebaseParser {
    typealias T = [RMChat]
    
    func parseData(data: Any,
                   callback: @escaping ((Result<[RMChat], Error>) -> Void)) {
        guard let dictionary = data as? Dictionary<String, Any> else {
            Logger.log(.info, data)
            callback(.success([]))
            return
        }
        
        let decoder = JSONDecoder()
        let carsArray = dictionary.compactMap { (key, value) -> RMChat? in
            if let dictionary = value as? [String: Any],
               let jsonData = try? JSONSerialization.data(withJSONObject: dictionary),
               var chat = try? decoder.decode(RMChat.self, from: jsonData) {
                chat.id = key
                return chat
            }
            return nil
        }
        callback(.success(carsArray))
    }
}


struct RMSingleChatParser: FirebaseParser {
    typealias T = RMChat
    
    func parseData(data: Any, callback: @escaping ((Result<RMChat, any Error>) -> Void)) {
        parseOnEndedStatus(data: data, callback: callback)
    }
}

