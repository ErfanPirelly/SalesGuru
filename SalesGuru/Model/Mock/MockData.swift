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
    static let conversationFilters = IMConversationFilter.allCases
    
    static let notifications: [RMNotification] = [
        .init(username: "Shaun",
              content: "appointment booked for shaun zom in 11AM 13 may  appointment booked for shaun zom in 11AM 13 may",
              date: "1m"),
        
            .init(username: "erfan",
                  content: "New message \nappointment booked for shaun zom in 11AM 13 may",
                  date: "2m"),
        .init(username: "Shaun",
              content: "appointment booked for shaun zom in 11AM 13 may",
              date: "1m"),
        
            .init(username: "erfan",
                  content: "New message",
                  date: "2m"),
        .init(username: "Shaun",
              content: "appointment booked for shaun zom in 11AM 13 may",
              date: "1m"),
        
            .init(username: "erfan",
                  content: "New message",
                  date: "2m"),
    ]
}


