//
//  SettinsVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/23/24.
//

import UIKit

class SettinsVC: UIViewController {
    // MARK: - properties
    private let customView = SettingsView()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    // MARK: - prepare UI
    private func prepareUI() {
        view.addSubview(customView)
        customView.delegate = self
        customView.pinToEdge(on: view)
    }
}

extension SettinsVC: SettingsViewDelegate {
    func didSelect(setting item: SettingItem) {
        print(item.rawValue)
    }
}

