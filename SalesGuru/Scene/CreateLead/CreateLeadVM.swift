//
//  CreateLeadVM.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/10/24.
//

import Foundation

final class CreateLeadVM: NSObject {
    // MARK: - properties
    let network = NetworkCore(database: .salesguru)
    
    // MARK: - logic
    func createLead(with personalInfo: IMLeadProfileInfo, aiSetting: IMLeadAISetting, callback: @escaping (Error?) -> Void) {
        let model = RMLeadModel(with: personalInfo, setting: aiSetting, car: MockData.carLeadData)
        guard let data = model.createLead() else { return }
        network.setValueAndObserve(RMLeadModelParser(), for: FirebaseRoutes.createLead(), data: data) { result in
            switch result {
            case .success(let success):
                Logger.log(.info, success)
                callback(nil)
            case .failure(let failure):
                Logger.log(.error, failure.localizedDescription)
                callback(failure)
            }
        }
    }
}
