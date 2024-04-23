//
//  LabelSemiBold.swift
//  Pirelly
//
//  Created by shndrs on 6/22/23.
//

import UIKit

// MARK: - Label Semi Bold

class LabelSemiBold: BaseLabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        font = .Fonts.semiBold(font.pointSize)
    }
    
}
