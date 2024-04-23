//
//  TabBarItem.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/23/24.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case inbox
    case calls
    case settings


    var image: UIImage? {
        switch self {
        case .inbox: return .get(image: .inboxTab)
        case .calls: return .get(image: .callsTab)
        case .settings: return .get(image: .settingsTab)
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .inbox: return .get(image: .inboxTab)
        case .calls: return .get(image: .callsTab)
        case .settings: return .get(image: .settingsTab)
        }
    }
    
    var title: String {
        switch self {
        case .inbox:
            return "Inbox"
        case .calls:
            return "Calls"
        case .settings:
            return "Settings"
        }
    }

    var isSelectable: Bool {
        return true
    }

    var imageSize: CGFloat {
        return 24
    }
    
    static var unselectedColor: UIColor {
        return .black.withAlphaComponent(0.62)
    }

    static var selectedColor: UIColor {
        return .black
    }

}
