//
//  CompanyInformationValidator.swift
//  Pirelly
//
//  Created by shndrs on 8/19/23.
//

import Foundation

final class CompanyInformationValidator: NSObject {
    
    enum TextFields: UInt8 {
        case name
        case website
        case dealerType
        case salesVolume
    }
    public private(set) var textFields: TextFields?
    
}

// MARK: - Methods

extension CompanyInformationValidator {
    
    func validate(inputs: IMCompanyInformation) -> CustomError? {
        let validator = Validator.website
        if inputs.companyName.count < 3 {
            textFields = .name
            return CustomError(description: "Company name must be at least 3 characters")
            
        } else if !validator.validate(value: inputs.website) {
            textFields = .website
            return CustomError(description: "Dealer website is inValid")
        } else if inputs.dealerType.isEmpty {
            textFields = .dealerType
            return CustomError(description: "Must Select Dealer type")
        } else if (inputs.salaesVolume ?? -1) < 0 {
            textFields = .salesVolume
            return CustomError(description: "Must Select Sales volume")
        } else {
            textFields = nil
            return nil
        }
    }
    
}
