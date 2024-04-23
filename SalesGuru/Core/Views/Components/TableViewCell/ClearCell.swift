//
//  ClearCell.swift
//  Pirelly
//
//  Created by shndrs on 6/18/23.
//

import UIKit

final class ClearCell: BaseTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        backgroundColor = .clear
    }

}
