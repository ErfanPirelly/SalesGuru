//
//  ChatLeadTVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/13/24.
//

import Foundation

final class ChatLeadTVC: BaseProfileInfoCell {
    static let CellID = "ChatLeadTVC"
    
    override func fill(cell with: UIModelChatProtocol) {
        super.fill(cell: with)
        leadIcon.isHidden = false
        lightLabel.isHidden = false
        rightIcon.isHidden = false
    }
}
