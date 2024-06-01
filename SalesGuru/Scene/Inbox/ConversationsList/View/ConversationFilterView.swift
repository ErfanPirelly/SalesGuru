//
//  ConversationFilterView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/18/24.
//

import UIKit

protocol ConversationFilterViewDelegate: AnyObject {
    func didSelectFilter(with: IMConversationFilter)
    func deSelectFilter(with: IMConversationFilter)
}

class ConversationFilterView: UIView {
    // MARK: - properties
    private var collectionView: UICollectionView!
    private let searchBar = UISearchBar()
    private let dataSource = MockData.conversationFilters
    weak var delegate: ConversationFilterViewDelegate?
    
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
        setupCollectionView()
        setupSearchBar()
        setupConstraints()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        
        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ConversationFilterCVC.self, forCellWithReuseIdentifier: ConversationFilterCVC.CellID)
        collectionView.contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsMultipleSelection = false
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
        addSubview(collectionView)
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Search"
        let color = UIColor.black.withAlphaComponent(0.05)
        
        searchBar.applyCorners(to: .all, with: 10)
        searchBar.setPlaceholderTextColorTo(color: .ui.gray4)
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.background = UIImage()
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.tintColor = .ui.gray4
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.searchTextField.custom(placeholder: "Search", with: .ui.gray4)
        searchBar.searchTextField.font = .Quicksand.semiBold(17)

        searchBar.backgroundColor = color
        searchBar.tintColor = .ui.gray4
        searchBar.setMagnifyingGlassColorTo(color: .ui.gray4)
        addSubview(searchBar)
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(36)
        }
    }
}

// MARK: - collectionView delegatge
extension ConversationFilterView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConversationFilterCVC.CellID, for: indexPath) as! ConversationFilterCVC
        cell.fill(cell: dataSource[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectFilter(with: dataSource[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.delegate?.deSelectFilter(with: dataSource[indexPath.row])
    }
}
