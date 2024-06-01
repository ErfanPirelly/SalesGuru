//
//  CompanyInfo.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/1/24.
//


import Foundation

struct IMCompanyInformation {
    
    var companyName: String
    var website: String
    var dealerType: String
    var salaesVolume: Int?
    
    init(companyName: String, website: String,
         dealerType: String, salaesVolume: Int?) {
        self.companyName = companyName
        self.website = website
        self.dealerType = dealerType
        self.salaesVolume = salaesVolume
    }
    
}
