//
//  UICollectionView.swift
//  Pirelly
//
//  Created by shndrs on 6/26/23.
//

import UIKit

extension UICollectionView: ListView {
    
    func reload(item at: IndexPath) {
        reloadItems(at: [at])
    }
    
    func deleteItem(at: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
            self?.deleteItems(at: [at])
        }
    }
    
    func cellFor(item at: IndexPath) -> UIView? {
        return cellForItem(at: at)
    }
    public func asyncReload() {
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
            self?.reloadData()
        }
    }
    
    func register(with id: String) {
        let nib = UINib(nibName: id, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: id)
    }
    
    public func layout(cellSize: CGSize?,
                       scrollDirection: UICollectionView.ScrollDirection = .vertical) {
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
            let layout = UICollectionViewFlowLayout()
            _ = layout.flipsHorizontallyInOppositeLayoutDirection
            layout.scrollDirection = scrollDirection
            if let size = cellSize {
                layout.itemSize = size
            } else {
                layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            }
            layout.sectionInset = UIEdgeInsets(top: 0,
                                               left: 0,
                                               bottom: 0,
                                               right: 0)
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 1.0
            self?.setCollectionViewLayout(layout, animated: false)
        }
    }
    
}
