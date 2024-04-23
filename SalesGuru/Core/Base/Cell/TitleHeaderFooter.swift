//
//  TitleHeaderFooter.swift
//  Pirelly
//
//  Created by shndrs on 6/18/23.
//

import UIKit

class TitleHeaderFooter: UITableViewHeaderFooterView, ReusableView {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var lblTitle: LabelMedium!
    
    // MARK: - Methods
    
    func set(title: String,
             font: UIFont = .Fonts.medium(15)) {
        lblTitle.text = title
        lblTitle.font = font
    }
    
}

// MARK: - Life Cycle
extension TitleHeaderFooter {
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.backgroundColor = .ui.backgroundColor3
        backgroundConfiguration?.backgroundColor = .ui.backgroundColor3
    }
    
}
