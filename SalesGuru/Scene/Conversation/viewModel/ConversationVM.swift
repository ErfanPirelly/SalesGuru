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
    var messageList: [MessageSections] = []
    let chat: RMChat
    
    // MARK: - init
    init(chat: RMChat) {
        self.chat = chat
    }
    
    // MARK: - method
    func getMessages(callback: @escaping (Result<[MessageSections], Error>) -> Void) {
        let path = FirebaseRoutes.messageRoute(id: chat.id ?? "")
        network.observe(RMMessageParser(), childPath: path) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.data = data.sorted(by: {($0.timestamp ?? 0) < ($1.timestamp ?? 0)})
                self.messageList = groupMessagesByDay(messages: self.data)
                callback(.success(self.messageList))
            case .failure(let failure):
                callback(.failure(failure))
            }
        }
    }
    
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
    
}


extension ConversationVM {
    func isPreviousMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard indexPath.section >= 0, indexPath.item >= 0 else { return false }
        
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
        guard indexPath.section >= 0, indexPath.item >= 0 else { return false }
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
        guard indexPath.section < messageList.count, indexPath.item < messageList[indexPath.section].messages.count else { return false }
        
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
        return messageList[index.section].messages[index.row].receive ?? false
    }
    
}
