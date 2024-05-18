//
//  HomeVC.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/28/24.
//

import UIKit

class HomeVC: UIViewController {
    // MARK: - properties
    private let customView = HomeView()
    private var tabBarVC: TabbarVC?
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        setupTabBar()
    }
    
    // MARK: - prepare UI
    private func prepareUI() {
        view.addSubview(customView)
        customView.pinToEdge(on: view)
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.scrollEdgeAppearance = .none
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupTabBar() {
        tabBarVC = TabbarVC()
        tabBarVC?.willMove(toParent: self)
        if let view = tabBarVC?.view {
            view.isUserInteractionEnabled = true
            customView.containerView.addSubview(view)
            view.pinToEdge(on: self.customView.containerView)
        }
        tabBarVC?.didMove(toParent: self)
        let inboxVC = setupInboxVC()
        tabBarVC?.setup(items:  [.chat, .calendar, .charts], viewControllers: [ChatsVC(), CalendarVC(), SettinsVC()])
    }
    
    private func setupInboxVC() -> UIViewController {
        let navigation = BaseNavigationController(rootViewController: ChatsVC())
        return navigation
    }
}
