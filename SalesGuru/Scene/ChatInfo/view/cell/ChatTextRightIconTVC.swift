//
//  ChatTextRightIconTVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/13/24.
//

import Foundation

final class ChatTextRightIconTVC: BaseProfileInfoCell {
    // MARK: - properties
    static let CellID = "ChatTextRightIconTVC"
    
    // MARK: - init
    override func fill(cell with: UIModelChatProtocol) {
        super.fill(cell: with)
        rightIcon.isHidden = false
        lightLabel.isHidden = false
    }
}


