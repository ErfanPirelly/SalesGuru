//
//  LabelRegular.swift
//  Pirelly
//
//  Created by shndrs on 6/17/23.
//

import UIKit

// MARK: - Label Regular

class LabelRegular: BaseLabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        font = .Fonts.normal(font.pointSize)
    }
    
}
