//
//  RMLead.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/12/24.
//

import Foundation

struct RMLeadModel: Codable {
    var VINNumber, dealerName, email: String?
    var firstName, lastName, make: String?
    var model, phoneNumber: String?
    var priceOnWebsite, mileage: Int?
    var source: String?
    var timestamp: Double?
    var year: Int?
    var isCarSold: Bool?
    
    // decoding extra variables
    var description: String?
    var testDrive: Bool?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.VINNumber = try? container.decodeIfPresent(String.self, forKey: .VINNumber)
        self.dealerName = try? container.decodeIfPresent(String.self, forKey: .dealerName)
        self.email = try? container.decodeIfPresent(String.self, forKey: .email)
        self.firstName = try? container.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try? container.decodeIfPresent(String.self, forKey: .lastName)
        self.make = try? container.decodeIfPresent(String.self, forKey: .make)
   
        self.model = try? container.decodeIfPresent(String.self, forKey: .model)
        self.phoneNumber = try? container.decodeIfPresent(String.self, forKey: .phoneNumber)
        
        self.source = try? container.decodeIfPresent(String.self, forKey: .source)
        self.timestamp = try? container.decodeIfPresent(Double.self, forKey: .timestamp)
        
        // year
        if let yearStr = try? container.decodeIfPresent(String.self, forKey: .year) {
            self.year = Int(yearStr)
        } else if let year =  try? container.decodeIfPresent(Int.self, forKey: .year) {
            self.year = year
        }
        
        // milage
        if let mileageStr = try? container.decodeIfPresent(String.self, forKey: .mileage) {
            self.mileage = Int(mileageStr)
        } else if let mileage =  try? container.decodeIfPresent(Int.self, forKey: .mileage) {
            self.mileage = mileage
        }
        
        if let priceStr = try? container.decodeIfPresent(String.self, forKey: .priceOnWebsite) {
            self.priceOnWebsite = Int(priceStr)
        } else if let price = try? container.decodeIfPresent(Int.self, forKey: .priceOnWebsite) {
            self.priceOnWebsite = price
        }
        
        self.isCarSold = try? container.decodeIfPresent(Bool.self, forKey: .isCarSold)
    }
}


struct RMLeadModelParser: FirebaseParser {
    typealias T = RMLeadModel
}
