//
//  ConversationVM.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/31/24.
//

import Foundation

final class ConversationVM: NSObject {
    // MARK: - properties
    let network = NetworkCore(database: .salesguru)
    var data: [RMMessage] = []
    var messageList: [MessageSections]?
    var chat: RMChat?
    let id: String
    weak var delegate: ChatUpdatedDelegate?
    
    // MARK: - init
    init(id: String) {
        self.id = id
    }
    
    // MARK: - method
    func getMessages(callback: @escaping (Result<[MessageSections], Error>) -> Void) {
        let path = FirebaseRoutes.messageRoute(id: self.id)
        network.observe(RMMessageParser(), childPath: path) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.data = data.sorted(by: {($0.timestamp ?? 0) < ($1.timestamp ?? 0)})
                self.messageList = groupMessagesByDay(messages: self.data)
                callback(.success(self.messageList ?? []))
            case .failure(let failure):
                callback(.failure(failure))
            }
        }
    }
    
    func getChat(callback: @escaping ((RMChat?) -> Void)) {
        let path = FirebaseRoutes.conversationList + "/" + id
        network.observe(RMSingleChatParser(), childPath: path) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                var chat = data
                chat.id = self.id
                self.chat = chat
                self.read()
                callback(data)
            case .failure(let failure):
                Logger.log(.error, failure.localizedDescription)
                callback(nil)
            }
        }
    }
    
    func sendMessage(with content: String, callback: @escaping (RMMessage?) -> Void) {
        let data: [String : Any] = [
            "content": content,
            "receive": false,
            "read": true,
            "sender": "Sender"
        ]
        let path = FirebaseRoutes.messageRoute(id: self.id)
        network.setValueAndObserve(RMSingleMessageParser(), for: path, data: data) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                var message = success
                message.id = UUID().uuidString
                callback(message)
                if let chat = self.chat {
                    self.delegate?.chatUpdated(with: chat)
                }
            case .failure(let failure):
                Logger.log(.error, failure.localizedDescription)
                callback(nil)
            }
        }
    }
    
    func updatedViewModel(with chat: RMChat) -> Self {
        self.chat = chat
        self.delegate?.chatUpdated(with: chat)
        return self
    }
    
    func read() {
        let path = FirebaseRoutes.conversationList + "/\(id)"
        network.setValue(for: path, data: ["read": true], callback: {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                Logger.log(.success, path, true)
                self.chat?.unreadCounter = 0
                if let chat = chat {
                    self.delegate?.chatUpdated(with: chat)
                }
            case .failure(let failure):
                Logger.log(.error, failure.localizedDescription)
            }
        })
    }
}

// MARK: - parse data
extension ConversationVM {
    func groupMessagesByDay(messages: [RMMessage]) -> [MessageSections] {
        guard !messages.isEmpty else { return [] }
          
          var groupedMessages: [MessageSections] = []
          var section: MessageSections?
          
          for message in messages {
              if var currentSection = section {
                  let isSameDay = Calendar.current.isDate(message.date, inSameDayAs: currentSection.date)
                  let isSameSender = currentSection.messages.last?.sender == message.sender
                  
                  if isSameDay && isSameSender {
                      currentSection.messages.append(message)
                  } else {
                      groupedMessages.append(currentSection)
                      currentSection = MessageSections(date: message.date, messages: [message])
                  }
                  section = currentSection
                  
              } else {
                  section = MessageSections(date: message.date, messages: [message])
              }
          }
          // Append the last section if it exists
          if let currentSection = section {
              groupedMessages.append(currentSection)
          }
          
          return groupedMessages
    }
    
    func replaceMessage(message: RMMessage) -> Self{
        if let index = findMessageIndex(with: message.id ?? "") {
            var sectionMessage = messageList![index.section]
            sectionMessage.replace(message: message)
            return self.replaceSection(section: sectionMessage)
        } else {
            if var lastSection = messageList?.last, Calendar.current.isDate(lastSection.date, inSameDayAs: message.date) {
                lastSection.replace(message: message)
                return self.replaceSection(section: lastSection)
            } else {
                return self.replaceSection(section: .init(date: message.date, messages: [message]))
            }
        }
    }
    
    func replaceSection(section: MessageSections) -> Self {
        self.messageList?.replaceOrAppend(section, firstMatchingKeyPath: \.id)
        return self
    }
    
    func deleteMessage(with id: String) -> Self {
        if let index = findMessageIndex(with: id), var section = messageList?[index.section] {
            section.messages.removeAll(where: {$0.id == id})
            return self.replaceSection(section: section)
        }
        return self
    }
    
    func toggleTempAI() {
        let path = FirebaseRoutes.conversationList + "/\(self.id)/"+"AITemporaryDisable"
        let data = chat?.AITemporaryDisable ?? false
        network.setValue(for: path, data: data, callback: { result in
            switch result {
            case .success(let success):
                Logger.log(.success, path, success)
            case .failure(let failure):
                Logger.log(.error, path, failure)
            }
        })
    }
}

// MARK: - message data
extension ConversationVM {
    func isPreviousMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard let messageList = messageList, indexPath.section >= 0, indexPath.item >= 0 else { return false }
        
        if indexPath.item > 0 {
            // Check previous message in the same section
            let currentMessage = messageList[indexPath.section].messages[indexPath.item]
            let previousMessage = messageList[indexPath.section].messages[indexPath.item - 1]
            return currentMessage.sender == previousMessage.sender
        } else if indexPath.section > 0 {
            // Check last message of the previous section
            let currentMessage = messageList[indexPath.section].messages[indexPath.item]
            let previousMessage = messageList[indexPath.section - 1].messages.last!
            return currentMessage.sender == previousMessage.sender
        } else {
            return false
        }
    }
    
    func isDateChanges(at indexPath: IndexPath) -> Bool {
        guard let messageList = messageList, indexPath.section >= 0, indexPath.item >= 0 else { return false }
        if indexPath.item > 0 {
            // Check previous message in the same section
            let currentMessage = messageList[indexPath.section].messages[indexPath.item]
            let previousMessage = messageList[indexPath.section].messages[indexPath.item - 1]
            let isSameDay = Calendar.current.isDate(previousMessage.date, inSameDayAs: currentMessage.date)
            
            return !isSameDay
        } else if indexPath.section > 0 {
            // Check last message of the previous section
            let currentMessage = messageList[indexPath.section].messages[indexPath.item]
            let previousMessage = messageList[indexPath.section - 1].messages.last!
            let isSameDay = Calendar.current.isDate(previousMessage.date, inSameDayAs: currentMessage.date)
            return !isSameDay
        } else {
            return false
        }
    }
    
    func isNextMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard let messageList = messageList, indexPath.section < messageList.count, indexPath.item < messageList[indexPath.section].messages.count else { return false }
        
        if indexPath.item < messageList[indexPath.section].messages.count - 1 {
            // Check next message in the same section
            let currentMessage = messageList[indexPath.section].messages[indexPath.item]
            let nextMessage = messageList[indexPath.section].messages[indexPath.item + 1]
            return currentMessage.sender == nextMessage.sender
        } else if indexPath.section < messageList.count - 1 {
            // Check first message of the next section
            let currentMessage = messageList[indexPath.section].messages[indexPath.item]
            let nextMessage = messageList[indexPath.section + 1].messages.first!
            return currentMessage.sender == nextMessage.sender
        } else {
            return false
        }
    }
    
    func isFromCurrentUser(at index: IndexPath) -> Bool {
        return !(messageList?[index.section].messages[index.row].receive ?? false)
    }
    
    func findMessageIndex(with id: String) -> IndexPath? {
        if let section = messageList?.firstIndex(where: {$0.containMessage(with: id)}),
           let row = messageList?[section].messages.firstIndex(where: {$0.id == id}){
            return IndexPath(row: row, section: section)
        }
        return nil
    }
}
