//
//  RMEmpty.swift
//  Pirelly
//
//  Created by shndrs on 8/28/23.
//

import Foundation

struct RMEmpty: Codable {}


extension RMEmpty: RestDataParser {
    typealias T = RMEmpty
}
