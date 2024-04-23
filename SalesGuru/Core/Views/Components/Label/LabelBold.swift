//
//  LabelBold.swift
//  Pirelly
//
//  Created by shndrs on 6/17/23.
//

import UIKit

// MARK: - Label Bold

class LabelBold: BaseLabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        font = .Fonts.bold(font.pointSize)
    }
    
}
