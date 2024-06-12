//
//  FirebaseRoutes.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/28/24.
//

import Foundation

// MARK: - Firebase Reference Paths

struct FirebaseRoutes {
    // properties
    static let userManager: UserManager = inject()
    
    // MARK: - pathes
    static var conversationList: String {
        let uid = userManager.uid ?? ""
        return "/conversations/\(uid)"
    }
    
    static func messageRoute(id: String? = nil) -> String {
        let uid = userManager.uid ?? ""
        var path = "/messages/\(uid)"
        if let id = id {
           path += "/\(id)"
        }
        return path
    }
    
    static func createLead() -> String {
        let uid = userManager.uid ?? ""
        return "/dealers/\(uid)/leads"
    }
    
}
