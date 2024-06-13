//
//  ChatTextButtonTVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/13/24.
//

import Foundation

final class ChatTextButtonTVC: BaseProfileInfoCell {
    // MARK: - properties
    static let CellID = "ChatTextButtonTVC"
    
    // MARK: - init
    override func fill(cell with: UIModelChatProtocol) {
        super.fill(cell: with)
        rightButton.isHidden = false
        lightLabel.isHidden = false
    }
}

