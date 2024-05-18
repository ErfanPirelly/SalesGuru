//
//  AppConfig.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/30/24.
//

import UIKit

struct AppConfig {
    static func config() {
        UITableViewCell.appearance().backgroundColor = .clear
        UITableViewCell.appearance().contentView.backgroundColor = .clear
        UITableViewCell.appearance().selectionStyle = .none
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        
        UICollectionView.appearance().backgroundColor = .clear
        UICollectionViewCell.appearance().backgroundColor = .clear
        UICollectionViewCell.appearance().contentView.backgroundColor = .clear
    }
}
