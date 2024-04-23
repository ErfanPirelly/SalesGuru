//
//  LabelMedium.swift
//  Pirelly
//
//  Created by shndrs on 6/17/23.
//

import UIKit

// MARK: - Label Medium

class LabelMedium: BaseLabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        font = .Fonts.medium(font.pointSize)
    }
    
}
