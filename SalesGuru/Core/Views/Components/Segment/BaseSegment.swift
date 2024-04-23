//
//  BaseSegment.swift
//  Pirelly
//
//  Created by shndrs on 7/2/23.
//

import UIKit

class BaseSegment: UISegmentedControl {}

// MARK: - Methods

extension BaseSegment {

    @objc func setup() {
        self.backgroundColor = .ui.clear
        self.tintColor = .ui.primaryBlue
        self.selectedSegmentTintColor = .ui.primaryBlue
        self.layer.masksToBounds = true
        let normalFont: UIFont = .Fonts.normal(13)
        self.setTitleTextAttributes([.font: normalFont, .foregroundColor: UIColor.ui.label],
                                    for: .normal)
        let selectedFont: UIFont = .Fonts.bold(14)
        self.setTitleTextAttributes([.font: selectedFont, .foregroundColor: UIColor.ui.white],
                                    for: .selected)
    }

}

// MARK: - Life Cycle

extension BaseSegment {

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
