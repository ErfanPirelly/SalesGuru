//
//  CustomError.swift
//  Pirelly
//
//  Created by shndrs on 7/25/23.
//

import Foundation

protocol ErrorProtocol: LocalizedError {
    var title: String? { get }
}

struct CustomError: ErrorProtocol {

    var title: String?
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    private var _description: String

    init(title: String = "Something wrong happened!",
         description: String) {
        self.title = title
        self._description = description
    }
    
}
