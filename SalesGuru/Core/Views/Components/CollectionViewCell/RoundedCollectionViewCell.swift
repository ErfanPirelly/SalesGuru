//
//  RoundedCollectionViewCell.swift
//  Pirelly
//
//  Created by shndrs on 6/26/23.
//

import UIKit

class RoundedCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.addCornerRadius(radius: 8)
        backView.addBorder(color: .ui.tertiaryLabel,
                           thickness: 4)
        backView.backgroundColor = .ui.primaryBack
    }
    
}
