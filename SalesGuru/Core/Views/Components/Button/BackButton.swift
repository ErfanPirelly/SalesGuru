//
//  BackButton.swift
//  Pirelly
//
//  Created by mmdMoovic on 10/28/23.
//

import UIKit

class BackButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        setImage(.get(image: .back)?.withRenderingMode(.alwaysTemplate), for: .normal)
        backgroundColor = .clear
        tintColor = .ui.primaryBlue
        addBorder(color: .ui.darkColor ?? .gray, thickness: 1)
        applyCorners(to: .all, with: 20)
        
        snp.makeConstraints { make in
            make.size.equalTo(52)
        }
    }
}
