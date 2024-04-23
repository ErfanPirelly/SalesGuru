//
//  HomeView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/23/24.
//

import UIKit

protocol CustomTabBarViewDelegate: TabBarItemViewDelegate {}

// view
final class CustomTabBarView: UIView {
    // MARK: - properties
    private var stackView: UIStackView!
    weak var delegate: CustomTabBarViewDelegate?
    private var allItems: [TabBarItemView] = []
    
    // MARK: Init/Deinit
    init() {
        super.init(frame: .zero)
        prepareUI()
        prepareConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func prepareUI() {
        setupStackView()
        applyCorners(to: .top, with: 15)
        backgroundColor = .ui.backgroundColor3
    }

    private func setupStackView() {
        stackView = .init(axis: .horizontal, alignment: .center, distribution: .fillEqually, spacing: 40, arrangedSubviews: [])
        addSubview(stackView)
    }
    
    private func prepareConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(55)
            make.top.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - Public

    func setup(with items: [TabBarItem]) {
        for item in items {
            let view = TabBarItemView(item: item)
            self.allItems.append(view)
            view.delegate = self
            stackView.addArrangedSubview(view)
        }
    }

    func select(_ item: TabBarItem) {
        allItems.forEach { $0.applyState( $0.item == item) }
    }

    func frame(for item: TabBarItem) -> CGRect {
        guard let item = allItems.first(where: { $0.item == item  }) else {
            return .zero
        }
        return item.frame
    }

}

// MARK: - item delegate
extension CustomTabBarView: TabBarItemViewDelegate {
    func didSelectVC(item: TabBarItem) {
        self.delegate?.didSelectVC(item: item)
    }
    
    func shouldSelectVC(item: TabBarItem) -> Bool {
        return delegate?.shouldSelectVC(item: item) ?? false
    }
}
