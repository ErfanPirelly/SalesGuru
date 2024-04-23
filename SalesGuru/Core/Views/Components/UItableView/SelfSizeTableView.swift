//
//  SelfSizeTableView.swift
//  Pirelly
//
//  Created by mmdMoovic on 10/2/23.
//

import UIKit

// MARK: - SelfSizedTableView
public class SelfSizedTableView: UITableView {
    public override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    public override var intrinsicContentSize: CGSize {
        setNeedsLayout()
        layoutIfNeeded()
        let height = contentSize.height
        return CGSize(width: contentSize.width, height: height)
    }
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



