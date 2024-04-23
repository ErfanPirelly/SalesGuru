//
//  ResponseModel.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/19/23.
//

import Foundation


struct ResponseModel: Codable {
    let status: ResponseStatus?
    let responseData: String?
}

enum ResponseStatus: String, Codable {
    case ended
    case error
    case pending
}

struct ResponseModelParser: FirebaseParser {
    typealias T = ResponseModel
}
