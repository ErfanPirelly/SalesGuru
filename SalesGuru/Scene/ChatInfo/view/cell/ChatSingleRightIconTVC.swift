//
//  ChatSingleRightIconTVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/13/24.
//

import Foundation

final class ChatSingleRightIconTVC: BaseProfileInfoCell {
    // MARK: - properties
    static let CellID = "ChatSingleRightIconTVC"
    
    // MARK: - init
    override func fill(cell with: UIModelChatProtocol) {
        super.fill(cell: with)
        rightIcon.isHidden = false
    }
}
