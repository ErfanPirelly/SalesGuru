//
//  IMConversationFilter.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/18/24.
//

import Foundation

enum IMConversationFilter: String, CaseIterable {
    case all
    case appointment
    case hot = "hot lead"
    case engaged = "re-engaed"
    case cold = "Cold"
}
