//
//  HomeVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/23/24.
//

import UIKit

class HomeVC: UITabBarController {
    // MARK: - properties
    private let customView = CustomTabBarView()
    var selectedItem: TabBarItem {
        return TabBarItem(rawValue: selectedIndex) ?? .inbox
    }
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        
        setup(items:  [.inbox, .calls, .settings], viewControllers: [InboxVC(), CallsVC(), SettinsVC()])
    }
    
    // MARK: - prepare UI
    private func prepareUI() {
        tabBar.alpha = 0
        view.backgroundColor = .ui.backgroundColor2
        view.addSubview(customView)
        customView.delegate = self
        customView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
}


// MARK: - view delegate
extension HomeVC: CustomTabBarViewDelegate {
    func didSelectVC(item: TabBarItem) {
        if item == selectedItem {
            
        } else {
            selectedIndex = item.rawValue
            self.customView.select(item)
        }
    }
    
    func shouldSelectVC(item: TabBarItem) -> Bool {
        return true
    }
    
    func setup(items: [TabBarItem], viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        customView.setup(with: items)
    }
}
