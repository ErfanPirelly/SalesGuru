//
//  IMAISetting.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/3/24.
//

import Foundation

enum AISettingType {
    case enabled
    case followUp
    case sold
    case onlineReview
    
    var title: String {
        switch self {
        case .enabled:
            return "AI Enabled"
        case .followUp:
            return "AI Follow up"
        case .sold:
            return "Car is sold"
        case .onlineReview:
            return "Online review follow up"
        }
    }
    
    var subtitle: String {
        switch self {
        case .enabled:
            return "AI taking responsibility"
        case .followUp:
            return "AI follow up with your lead"
        case .sold:
            return "AI taking responsibility"
        case .onlineReview:
            return "Al follow up for online reviews"
        }
    }
    
    var node: String {
        switch self {
        case .enabled:
            return "AIMode"
        case .followUp:
            return "followUpEnabled"
        case .sold:
            return "isCarSold"
        case .onlineReview:
            return "AIMode"
        }
    }
}

struct IMAISetting {
    let id = UUID()
    let type: AISettingType
    var isOn: Bool
    var title: String {
        type.title
    }
    
    var subtitle: String {
        type.subtitle
    }
}


extension RMChat {
    func getAISetting() -> [IMAISetting] {
        return [.init(type: .enabled, isOn: AIMode ?? false),
                .init(type: .followUp, isOn: followUpEnabled ?? false),
                .init(type: .sold, isOn: isCarSold ?? false)
        ]
    }
}
