//
//  MockData.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/28/24.
//

import Foundation

struct MockData {
    //    /conversations/eFFVnoenANbMmenu4JE1IqrJWKo2/-NygggHplj_-TV4vI3GF
    static let email = "saleguru-twilio-tester@test.com"
    static let passwod = "123456"
    static let uid = "Riuk4w3AeeczuqTYjSCRcPsanDC2"
    static let conversations: [RMConversation] = [.init(title: "from carmax", username: "Erfan Dadras", date: "8:56 PM", content: "I appreciate the offer, but I was hoping for something closer to ...", unread: true),
                                                  .init(title: "from pirelly", username: "Ali Najafi", date: "18:06 PM", content: "I appreciate the offer, but I was hoping for something closer ites someyhing else to ...", unread: false),
                                                  .init(title: "from Drivee", username: "Navid SH", date: "11:56 AM", content: "I appreciate the offer, but I was hoping for something closer to ...", unread: false),
                                                  .init(title: "from carmax222", username: "Amir Bagheri", date: "13:56 PM", content: "Saturday at 2 PM works for me. I'll make sure the car is ready for you.", unread: true)]
    
    static let conversationMessages: [RMConversationMessages] = [.init(content: "Hello", user: .init(id: 0)),
                                                                 .init(content: "Hello Drivee", user: .init(id: 0)),
                                                                 .init(content: "Can you send me a new car", user: .init(id: 0)),
                                                                 .init(content: "ok wait a minute", user: .init(id: 1)),
                                                                 .init(content: "H", user: .init(id: 0)),
                                                                 .init(content: "ok", user: .init(id: 1)),
                                                                 .init(content: "ok again", user: .init(id: 1))
    ]
    
    static let conversationFilters = IMConversationFilter.allCases

}


