//
//  SettingVM.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/29/24.
//

import UIKit

enum SettingItem: String, CaseIterable {
    case account
    case iframe
    case notification
    case user
    case security
    
    var icon: UIImage? {
        return nil
    }
}

// MARK: - UI data sourse
extension SettingItem {
    static let dataSource: [SettingItem] = [.account, .iframe, .notification, .user, .security]
}

class SettingVM: NSObject {
    
}
