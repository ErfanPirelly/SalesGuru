//
//  ChatSingleButtonTVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/13/24.
//


import Foundation

final class ChatSingleButtonTVC: BaseProfileInfoCell {
    // MARK: - properties
    static let CellID = "ChatSingleButtonTVC"
    
    // MARK: - init
    override func fill(cell with: UIModelChatProtocol) {
        super.fill(cell: with)
        rightButton.isHidden = false
    }
}

