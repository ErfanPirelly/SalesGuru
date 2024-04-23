//
//  String+Localized.swift
//  Pirelly
//
//  Created by Mohammad Takbiri on 5/29/23.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: " ")
    }
}
