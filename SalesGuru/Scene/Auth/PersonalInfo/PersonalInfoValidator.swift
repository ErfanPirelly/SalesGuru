//
//  PersonalInfoValidator.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/1/24.
//

import Foundation

final class UserInfoValidator: NSObject {
    
    enum TextFields: UInt8 {
        case name
        case lastName
        case privacyMarked
    }
    public private(set) var box: TextFields?
    
}

// MARK: - Methods

extension UserInfoValidator {
    
    func validate(inputs: IMPersonalInformation) -> CustomError? {
        let textValidator = Validator.textLimit(min: 3, max: nil)
        let emailValidator = Validator.email
        let phoneValidator = Validator.phone
        let hasPhoneNumber = !(inputs.basePhoneNumber?.isEmpty ?? false)
        if !textValidator.validate(value: inputs.name) {
            box = .name
            return CustomError(description: "name must be more than 3 charachter")
            
        } else if !textValidator.validate(value: inputs.lastName) {
            box = .lastName
            return CustomError(description: "lastName must be more than 3 charachter")
            
        } else if !(inputs.privacyAccepted ?? false) {
            box = .privacyMarked
            return CustomError(description: "privacy in not accepted")
        } else {
            box = nil
            return nil
        }
    }
}
