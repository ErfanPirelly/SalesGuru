//
//  LabelLight.swift
//  Pirelly
//
//  Created by shndrs on 6/17/23.
//

import UIKit

// MARK: - Label Light

class LabelLight: BaseLabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        font = .Fonts.light(font.pointSize)
    }
    
}
