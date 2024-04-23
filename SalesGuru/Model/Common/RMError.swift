//
//  RMError.swift
//  Pirelly
//
//  Created by shndrs on 8/28/23.
//

import Foundation

struct RMError: Codable {
    
    let errors: [ErrorItem]?
    let error: String?

    enum CodingKeys: String, CodingKey {
        case errors = "errors"
        case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errors = try values.decodeIfPresent([ErrorItem].self, forKey: .errors)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }

}

struct ErrorItem: Codable {
    
    let loc: [String]?
    let message: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case loc = "loc"
        case message = "msg"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        loc = try values.decodeIfPresent([String].self, forKey: .loc)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}
