//
//  UserManager.swift
//  Pirelly
//
//  Created by shndrs on 8/21/23.
//

import Foundation

final class UserManager: NSObject {
    let manager = UserDefaults.standard
    
    static let shared = UserManager()
    
    var uid: String? {
        get {
            return AuthManager.shared.auth.currentUser?.uid
        }
        set {
            manager[#function] = newValue
        }
    }
    
    var email: String? {
        get {
            return AuthManager.shared.auth.currentUser?.email
        }
        set {
            manager[#function] = newValue
        }
    }
    
    var photoUrl: String? {
        get {
            return AuthManager.shared.auth.currentUser?.photoURL?.absoluteString
        }
        set {
            manager[#function] = newValue
        }
    }
    
    var refreshToken: String? {
        get {
            return AuthManager.shared.auth.currentUser?.refreshToken
        }
        set {
            manager[#function] = newValue
        }
    }
    var idToken: String? {
        get {
            return AuthManager.shared.token
        }
        set {
            manager[#function] = newValue
        }
    }
    var password: String? {
        get {
            manager[#function] ?? nil
        }
        set {
            manager[#function] = newValue
        }
    }
    var phoneNumber: String? {
        get {
            return AuthManager.shared.auth.currentUser?.phoneNumber
        }
        set {
            manager[#function] = newValue
        }
    }
    var isUserLoggedIn: Bool {
        get { manager[#function] ?? false }
        set { manager[#function] = newValue }
    }
    
    // MARK: - Methods
    
    func deleteUser() {
        let dictionary = manager.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            manager.removeObject(forKey: key)
        }
    }
    
    private override init() {}
    
}
