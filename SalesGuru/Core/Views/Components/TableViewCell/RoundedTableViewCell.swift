//
//  RoundedTableViewCell.swift
//  Pirelly
//
//  Created by shndrs on 6/22/23.
//

import UIKit

class RoundedTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var backView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backView.addCornerRadius(radius: 8)
        backView.addBorder(color: .ui.tertiaryLabel,
                           thickness: 4)
        backView.backgroundColor = .ui.primaryBack
    }

}
