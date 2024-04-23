//
//  AuthAppConfig.swift
//  Pirelly
//
//  Created by mmdMoovic on 3/6/24.
//

import Foundation

class AuthAppConfig {
    // MARK: - properties
    var config: RMAppConfig?
    
    // MARK: - init
    init() {
        getConfig()
    }
    
    // MARK: - logic
    private func getConfig() {
        let network = NetworkCore(database: .centerAuth)
        network.observe(RMAppConfig(), childPath: "AppConfigs/\(Utils.googleAppId)") { result in
            switch result {
            case .success(let success):
                self.config = success
            case .failure(let failure):
                Logger.log(.error, failure.localizedDescription)
                break
            }
        }
    }
}
