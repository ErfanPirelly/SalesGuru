//
//  SearchResultView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/3/24.
//

import UIKit

protocol SearchResultViewDelegate: AnyObject {
    func searchForPreviousResult()
    func searchForNextResult()
    func didFindResult() -> Bool
}

class SearchResultView: UIView {
    // MARK: - properties
    private var resultLabel = UILabel(font: .Quicksand.semiBold(16),
                                      textColor: .ui.darkColor,
                                      alignment: .left)
    
    private let arrowUp = UIButton(image: .init(systemName: "chevron.up"))
    private let arrowDown = UIButton(image: .init(systemName: "chevron.down"))
    private let indicator = UIActivityIndicatorView(style: .medium)
    private var stack: UIStackView!
    weak var delegate: SearchResultViewDelegate?
    private var all: Int = -2
    private var current: Int = 0 {
        didSet {
            self.resultLabel.attributedText = "<em>\(current)</em> of \(all)".highlightingTag("em", color: .ui.primaryBlue)
            self.updateButtons()
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
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        addBorder(color: .init(p3: "#EDEDED"), thickness: 0.7)
        setupButtons()
        setupStack()
        setupConstraints()
    }
    
    private func setupStack() {
        indicator.startAnimating()
        indicator.color = .ui.primaryBlue
        indicator.hidesWhenStopped = true
        
        stack = .init(axis: .horizontal, alignment: .center, distribution: .equalSpacing, spacing: 10, arrangedSubviews: [indicator, resultLabel, arrowDown, arrowUp])
        addSubview(stack)
    }
    
    private func setupButtons() {
        arrowUp.tintColor = .black
        arrowUp.addTarget(self, action: #selector(didtapUpButton), for: .touchUpInside)
        arrowDown.tintColor = .black
        arrowDown.addTarget(self, action: #selector(didtapDownButton), for: .touchUpInside)
        updateButtons()
    }
    
    private func setupConstraints() {
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(UIView.safeArea.bottom)
            make.trailing.trailing.equalToSuperview().inset(30)
        }
        
        arrowUp.snp.makeConstraints { make in
            make.size.equalTo(arrowDown)
        }
        
        arrowDown.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        
        indicator.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }
    
    func config(all: Int?, current: Int) {
        self.all = all ?? -2
        self.current = -1
        self.indicator.stopAnimating()
        if all == nil || all == 0 {
            self.resultLabel.text = "not found"
            self.nextResult(enabled: false)
            self.previousResult(enabled: false)
            return
        }
        self.current = 1
    }
    
    func clear() {
        self.resultLabel.text = ""
        self.current = -1
        self.all = -2
        updateButtons()
    }
    
    func startSearching() {
        self.indicator.startAnimating()
    }
    
    private func updateButtons() {
        let upEnabled =  (self.current < all) && all != -2
        let downEnabled = self.current > 1
        
        nextResult(enabled: upEnabled)
        previousResult(enabled: downEnabled)
    }
    
    private func nextResult(enabled: Bool) {
        self.arrowUp.isEnabled = enabled
        self.arrowUp.alpha = enabled ? 1 : 0.6
    }
    
    private func previousResult(enabled: Bool) {
        self.arrowDown.isEnabled = enabled
        self.arrowDown.alpha = enabled ? 1 : 0.6
    }
}

// MARK: - objc
extension SearchResultView {
    @objc private func didtapDownButton() {
        guard self.current > 1, (delegate?.didFindResult() ?? false) else { return }
        delegate?.searchForPreviousResult()
        self.current -= 1
    }
    
    @objc private func didtapUpButton() {
        guard self.current < all, (delegate?.didFindResult() ?? false) else { return }
        delegate?.searchForNextResult()
        self.current += 1
    }
}

