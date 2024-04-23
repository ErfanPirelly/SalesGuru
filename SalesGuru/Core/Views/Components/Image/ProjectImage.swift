//
//  ProjectImage.swift
//  Pirelly
//
//  Created by shndrs on 6/26/23.
//

import UIKit

final class ProjectImage: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addBorder(color: .ui.tertiaryLabel,
                       thickness: 4)
        self.addCornerRadius(radius: 8)
        self.clipsToBounds = true
    }

}
