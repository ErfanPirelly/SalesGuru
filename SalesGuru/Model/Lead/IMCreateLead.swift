//
//  IMCreateLead.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/6/24.
//

import Foundation

struct IMLeadProfileInfo {
    let fullName, phoneNumber: String
    let email: String?
}

struct IMLeadAISetting {
    let vin, description: String
    let testDrive: Bool
}



struct IMLeadCarInfo {
    let make, model: String
    let mileage: Int
    let year: Int
    let source: String
    let price: String
}


extension RMLeadModel {
    init(with personalInfo: IMLeadProfileInfo, setting: IMLeadAISetting, car: IMLeadCarInfo) {
        // personal info
        self.email = personalInfo.email
        var nameComponent = personalInfo.fullName.components(separatedBy: " ")
        if let firstName = nameComponent.first {
            nameComponent.remove(at: 0)
            self.firstName = firstName
        }
        self.lastName = nameComponent.joined(separator: " ")
        
        // ai setting
        self.description = setting.description
        self.VINNumber = setting.vin
        self.testDrive = setting.testDrive
        
        // car
        self.make = car.make
        self.model = car.model
        self.year = "\(car.year)"
        self.source = car.source
        self.priceOnWebsite = car.price
    }
    
    func createLead() -> [String: Any]? {
        return try? self.toDictionary()
    }
}
