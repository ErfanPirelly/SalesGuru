//
//  ChatSolidTVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/13/24.
//

import Foundation

final class ChatSolidTVC: BaseProfileInfoCell {
    // MARK: - properties
    static let CellID = "ChatLeadTVC"
    
    // MARK: - init
    override func fill(cell with: UIModelChatProtocol) {
        super.fill(cell: with)
        darkLabel.isHidden = false
    }
}
