//
//  ConversationFilterCVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/18/24.
//

import UIKit

class ConversationFilterCVC: UICollectionViewCell {
    // MARK: - properties
    private let label = UILabel(font: .Quicksand.bold(13), textColor: .black.withAlphaComponent(0.4), alignment: .center)
    static let CellID = "ConversationFilterCVC"
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? .white : .black.withAlphaComponent(0.4)
            label.backgroundColor = isSelected ? .ui.primaryBlue : .black.withAlphaComponent(0.03)
        }
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup UI
    private func setupUI() {
        contentView.addSubview(label)
        label.backgroundColor = .black.withAlphaComponent(0.03)
        label.applyCorners(to: .all, with: 8)
        label.pinToEdge(on: contentView)
        
        label.snp.makeConstraints { make in
            make.height.equalTo(36)
        }
    }
    
    func fill(cell with: IMConversationFilter) {
        self.label.text = " \(with.rawValue) "
    }
}
