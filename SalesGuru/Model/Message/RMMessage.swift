//
//  RMMessage.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/31/24.
//

import Foundation


struct MessageSections {
    let id = UUID()
    let date: Date
    var messages: [RMMessage]
}

struct RMMessage: Codable {
    let history: AIHistory?
    let content: String?
    let read, receive: Bool?
    let sender: String?
    let status: Int?
    let timestamp: Double?
    let twilioID: String?
    
    var date: Date {
        return Date(timeIntervalSince1970: (timestamp ?? 0)/1000)
    }
    
    enum CodingKeys: String, CodingKey {
        case history = "AIHistory"
        case content
        case read
        case receive
        case sender
        case status
        case timestamp
        case twilioID
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.history = try? container.decodeIfPresent(AIHistory.self, forKey: .history)
        self.content = try? container.decodeIfPresent(String.self, forKey: .content)
        self.read = try? container.decodeIfPresent(Bool.self, forKey: .read)
        self.receive = try? container.decodeIfPresent(Bool.self, forKey: .receive)
        self.sender = try? container.decodeIfPresent(String.self, forKey: .sender)
        self.status = try? container.decodeIfPresent(Int.self, forKey: .status)
        self.timestamp = try? container.decodeIfPresent(Double.self, forKey: .timestamp)
        self.twilioID = try? container.decodeIfPresent(String.self, forKey: .twilioID)
    }
}

struct AIHistory: Codable {
    let content: String?
    let role: String?
}


struct RMMessageParser: FirebaseParser {
    typealias T = [RMMessage]
    
    func parseData(data: Any,
                   callback: @escaping ((Result<[RMMessage], Error>) -> Void)) {
        guard let dictionary = data as? Dictionary<String, Any> else {
            Logger.log(.info, data)
            callback(.success([]))
            return
        }
        
        let decoder = JSONDecoder()
        let carsArray = dictionary.compactMap { (_, value) -> RMMessage? in
            if let dictionary = value as? [String: Any],
               let jsonData = try? JSONSerialization.data(withJSONObject: dictionary),
               let message = try? decoder.decode(RMMessage.self, from: jsonData) {
                return message
            }
            return nil
        }
        callback(.success(carsArray))
    }
    
    
}
