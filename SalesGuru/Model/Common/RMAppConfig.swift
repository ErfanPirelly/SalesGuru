//
//  RMAppConfig.swift
//  Pirelly
//
//  Created by mmdMoovic on 3/6/24.
//

import Foundation

struct RMAppConfig: Codable {
    // MARK: - properties
    let os, product, configVersion: String?
    
    // MARK: - init
    init() {
        self.os = nil
        self.product = nil
        self.configVersion = nil
    }
}

extension RMAppConfig: FirebaseParser {
    typealias T = RMAppConfig
    
    func parseData(data: Any, callback: @escaping ((Result<RMAppConfig, Error>) -> Void)) {
        parseOnEndedStatus(data: data, callback: callback)
    }
}
