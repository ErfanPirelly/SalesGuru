//
//  CarInfoVM.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/23/24.
//

import SwiftUI

struct CarInfoSectioned: Identifiable {
    let id = UUID()
    let title: String
    let data: [IMCarInfo]
}

final class CarInfoVM: ObservableObject {
    // MARK: - properties
    @Published var dataSource: [CarInfoSectioned]?
    @Published var error: String?
    
    let id: String
    
    // MARK: - init
    init(id: String) {
        self.id = id
        getLead()
    }
    
    // MARK: - logic
    func getLead() {
        error = nil
        let network = NetworkCore(database: .salesguru)
        let path = FirebaseRoutes.createLead(id: id)
        
        network.observe(RMLeadModelParser(), childPath: path) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                self.parseLead(lead: success)
            case .failure(let failure):
                self.error = failure.localizedDescription
            }
        }
    }
    
    func parseLead(lead: RMLeadModel) {
        let carInfoSection = CarInfoSectioned(title: "Car Info", data: [
            .init(title: "Year", value: "\(lead.year ?? 0)", image: AImages.carInfoYear.rawValue),
            .init(title: "Make", value: lead.make ?? "", image: AImages.carInfoMake.rawValue),
            .init(title: "Model", value: lead.model ?? "", image: AImages.carInfoModel_Milage.rawValue),
            .init(title: "Mileage", value:  "\(lead.mileage ?? 0)", image: AImages.carInfoModel_Milage.rawValue),
            .init(title: "Price", value:  "\(lead.priceOnWebsite ?? 0)", image: AImages.carInfoPrice.rawValue),
        ])
        
        let carNumberSection = CarInfoSectioned(title: "Car Number", data: [
            .init(title: "VIN number", value: lead.VINNumber ?? "", image: nil),
//            .init(title: "Stock number", value: "stock", image: nil),
        ])
        
        self.dataSource = [carInfoSection, carNumberSection]
    }
}
