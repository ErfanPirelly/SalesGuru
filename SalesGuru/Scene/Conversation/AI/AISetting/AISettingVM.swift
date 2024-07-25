//
//  AISettingVM.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/3/24.
//

import Foundation

class AISettingVM: NSObject {
    // MARK: - properties
    let id: String
    let network = NetworkCore(database: .salesguru)
    
    // MARK: - init
    init(id: String) {
        self.id = id
    }
    
    // MARK: - logic
    func changeValue(for setting: IMAISetting) {
        var path = FirebaseRoutes.conversationList + "/\(id)" + "/\(setting.type.node)"
        network.setValue(for: path, data: setting.isOn) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                Logger.log(.success, path , success)
            case .failure(let failure):
                Logger.log(.error, path , failure.localizedDescription)
            }
        }
    }
}
