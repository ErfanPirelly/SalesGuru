//
//  HomeVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/23/24.
//

import UIKit

class TabbarVC: UITabBarController {
    // MARK: - properties
    private let tabbarView = CustomTabBarView()
    var selectedItem: TabBarItem {
        return TabBarItem(rawValue: selectedIndex) ?? .chat
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
//        delegate = self
    }
    
    deinit {
        print("deinited")
    }
    
    // MARK: - prepare UI
    private func prepareUI() {
        tabBar.alpha = 0
        view.backgroundColor = .ui.backgroundColor2
        setupTabBarView()
    }
    
    private func setupTabBarView() {
        view.addSubview(tabbarView)
        tabbarView.delegate = self
        tabbarView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
}


// MARK: - view delegate
extension TabbarVC: CustomTabBarViewDelegate {
    func didSelectVC(item: TabBarItem) {
        if item == selectedItem {
            
        } else {
            selectedIndex = item.rawValue
            self.tabbarView.select(item)
        }
    }
    
    func shouldSelectVC(item: TabBarItem) -> Bool {
        return true
    }
    
    func setup(items: [TabBarItem], viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        tabbarView.setup(with: items)
        tabbarView.select(.chat)
    }
}

extension TabbarVC: UITabBarControllerDelegate {
    
}
