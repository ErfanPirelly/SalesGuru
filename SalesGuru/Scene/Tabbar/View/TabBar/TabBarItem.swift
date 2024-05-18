//
//  TabBarItem.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/23/24.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case chat
    case calendar
    case charts


    var image: UIImage? {
        switch self {
        case .chat: return .get(image: .inactiveChatTab)
        case .calendar: return .get(image: .inactiveCalendarTab)
        case .charts: return .get(image: .inactiveChartTab)
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .chat: return .get(image: .activeChatTab)
        case .calendar: return .get(image: .activeCalendarTab)
        case .charts: return .get(image: .activeChartTab)
        }
    }
    
    var title: String {
        switch self {
        case .chat:
            return "Chats"
        case .calendar:
            return "Calendar"
        case .charts:
            return "Charts"
        }
    }

    var isSelectable: Bool {
        return true
    }

    var imageSize: CGFloat {
        return 20
    }
}
