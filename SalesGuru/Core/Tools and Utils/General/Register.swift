//
//  Register.swift
//  Pirelly
//
//  Created by shndrs on 6/17/23.
//

import UIKit

final class Register: NSObject {
    
    private override init() {}
    
}

// MARK: - Methods

extension Register {
    
    /// This method register Cells in UITableView and UICollectionView
    /// - Parameters:
    ///   - component: It's a generic value (it should be UITableView/CollectionView)
    ///   - id: The name of the nib (use reuseIdentifier if you inherit from ReusableView protocol)
    /// - Note: Component should be sub class of UITableView or UICollectionView
    ///         otherwise it will break IN YOUR FACE!!! :D
    
    @_specialize(where T == (UITableView, UICollectionView))
    public static func `in`<T>(component: T, id: String) {
        let nib = UINib(nibName: id, bundle: nil)
        switch component {
        case is UITableView:
            guard let cell = component as? UITableView else { return }
            cell.register(nib, forCellReuseIdentifier: id)
        case is UICollectionView:
            guard let cell = component as? UICollectionView else { return }
            cell.register(nib, forCellWithReuseIdentifier: id)
        default:
            break
        }
    }
    
    public static func footerView<T>(component: T, id: String) {
        let nib = UINib(nibName: id, bundle: nil)
        switch component {
        case is UITableView:
            guard let cell = component as? UITableView else { return }
            cell.register(nib, forHeaderFooterViewReuseIdentifier: id)
        default:
            break
        }
    }
    
}
