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
    
    func containMessage(with id: String?) -> Bool {
        messages.contains(where: {$0.id == id})
    }
    
    mutating func replace(message: RMMessage) {
        self.messages.replaceOrAppend(message, firstMatchingKeyPath: \.id)
    }
}

struct RMMessage: Codable {
    var id: String?
    var history: AIHistory?
    var content: String?
    var read, receive: Bool?
    var sender: String?
    var status: Int?
    var timestamp: Double?
    var twilioID: String?
    
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
    
    
    init(id: String, content: String, receive: Bool, timestamp: Double) {
        self.id = id
        self.content = content
        self.receive = receive
        self.timestamp = timestamp
        self.sender = "Sender"
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
    
    
    func contains(txt: String) -> Bool {
        content?.lowercased().contains(txt.lowercased()) ?? false
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
        let carsArray = dictionary.compactMap { (key, value) -> RMMessage? in
            if let dictionary = value as? [String: Any],
               let jsonData = try? JSONSerialization.data(withJSONObject: dictionary),
               var message = try? decoder.decode(RMMessage.self, from: jsonData) {
                message.id = key
                return message
            }
            return nil
        }
        callback(.success(carsArray))
    }
    
    
}

struct RMSingleMessageParser: FirebaseParser {
    typealias T = RMMessage
}
