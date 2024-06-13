//
//  ChatEmptyTVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/13/24.
//

import Foundation

final class ChatEmptyTVC: BaseProfileInfoCell {
    // MARK: - properties
    static let CellID = "ChatEmptyTVC"
    
    // MARK: - init
    override func fill(cell with: UIModelChatProtocol) {
        super.fill(cell: with)
        self.title.textColor = .ui.red1
    }
}


