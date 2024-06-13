//
//  ChatInfoTVH.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/13/24.
//

import UIKit

final class ChatInfoTVH: UITableViewHeaderFooterView {
    static let ViewID = "ChatInfoTVH"
    let title = UILabel(font: .Quicksand.semiBold(13), textColor: .ui.darkColor1.withAlphaComponent(0.35), alignment: .left)
    
    // MARK: - init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup UI
    private func setupUI() {
        contentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
    }
}
