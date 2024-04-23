//
//  CustomErrorWithActionCode.swift
//  Pirelly
//
//  Created by mmdMoovic on 1/19/24.
//

import Foundation

struct CustomErrorWithActionCode: ErrorProtocol {
    var title: String?
    var errorDescription: String? { return _description }
    var code: Int?
    private var _description: String

    init(title: String = "Something wrong happened!",
         description: String, code: Int?) {
        self.title = title
        self._description = description
        self.code = code
    }
}
