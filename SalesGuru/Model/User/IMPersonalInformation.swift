//
//  IMPersonalInformation.swift
//  Pirelly
//
//  Created by shndrs on 8/15/23.
//

import Foundation

struct IMPersonalInformation {
    var name: String?
    var lastName: String?
    var basePhoneNumber: String?
    var prefixPhoneNumber: String?
    var email: String?
    let privacyAccepted: Bool?
    
    var phoneNumber: String? {
        if let basePhoneNumber = basePhoneNumber, let prefixPhoneNumber = prefixPhoneNumber {
            return prefixPhoneNumber + basePhoneNumber
        } else {
            return nil
        }
    }
}
