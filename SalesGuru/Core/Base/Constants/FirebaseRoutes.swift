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
    
    // MARK: - paths
    static var conversationList: String {
        let uid = userManager.uid ?? ""
        return "/conversations/\(uid)"
    }
    
    static func messageRoute(id: String) -> String {
        let uid = userManager.uid ?? ""
        return "/messages/\(uid)/\(id)"
    }
    
    static func createLead(id: String? = nil) -> String {
        let uid = userManager.uid ?? ""
        let path = "/dealers/\(uid)/leads"
        
        if let id = id {
            return path + "/\(id)"
        } else {
            return path
        }
    }
}
