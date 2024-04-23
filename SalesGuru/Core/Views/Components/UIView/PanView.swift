//
//  PanView.swift
//  Pirelly
//
//  Created by mmdMoovic on 9/24/23.
//

import UIKit
import SnapKit

class PanView: UIView {
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupUI
    private func setupUI() {
        backgroundColor = UIColor(p3: "#6E7CAF").withAlphaComponent(0.12)
        applyCorners(to: .all, with: 2)
        snp.makeConstraints { make in
            make.width.equalTo(73)
            make.height.equalTo(5)
        }
    }
}
