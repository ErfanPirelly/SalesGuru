//
//  TabBarItemView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/23/24.
//

import UIKit

protocol TabBarItemViewDelegate: AnyObject {
    func didSelectVC(item: TabBarItem)
    func shouldSelectVC(item: TabBarItem) -> Bool
}

final class TabBarItemView: UIView {
    // MARK: - properties
    private var stack: UIStackView!
    private let image = UIImageView()
    private let title = UILabel(font: .Fonts.bold(12), textColor: .black)
    public let item: TabBarItem
    weak var delegate: TabBarItemViewDelegate?
    
    // MARK: Init/Deinit
    init(item: TabBarItem) {
        self.item = item
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func setupUI() {
        applyState(false, animated: false)
        backgroundColor = .clear
        setupStackView()
        prepareConstraints()
        configureGestures()
    }

    private func setupStackView() {
        image.image = item.image
        title.text = item.title
        stack = UIStackView(axis: .vertical, alignment: .center, distribution: .equalSpacing, spacing: 8, arrangedSubviews: [image, title])
        addSubview(stack)
    }
    
    private func prepareConstraints() {
        image.snp.makeConstraints { make in
            make.size.equalTo(item.imageSize)
        }
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func configureGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        addGestureRecognizer(tapGesture)
    }

    // MARK: - Public
    func applyState(_ isSelected: Bool, animated: Bool = true, completion: Action? = nil) {
        UIView.animate(withDuration: animated ? 0.25 : 0, delay: 0.0, options: .transitionCrossDissolve, animations: { [weak self] in
            guard let self = self else { return }
            self.title.textColor = isSelected ? TabBarItem.selectedColor : TabBarItem.unselectedColor
        }, completion: { _ in
            completion?()
        })
    }
    
    // MARK: - Actions
    @objc private func handleTapGesture(_ sender: UITapGestureRecognizer) {
        guard delegate?.shouldSelectVC(item: item) ?? false else {return}
        applyState(true)
        self.delegate?.didSelectVC(item: item)
    }

    @objc private func handleLongTouch(_ sender: UILongPressGestureRecognizer) {}

}
