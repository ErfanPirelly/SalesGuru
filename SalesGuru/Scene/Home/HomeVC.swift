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
    private let deepLink: DeepLinkDependency = inject()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        deepLink.handleDeepLink()
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
        let chatVC = setupInboxVC()
        tabBarVC?.setup(items:  [.chat, .calendar, .charts], viewControllers: [chatVC, CalendarVC(), SettinsVC()])
    }
    
    private func setupInboxVC() -> UIViewController {
        let vc = ChatsVC()
        vc.output = .init(action: { [weak self] actions in
            guard let self = self else { return }
            switch actions {
            case .notification:
                self.openNotification()
            }
        })
        let navigation = BaseNavigationController(rootViewController: vc)
        return navigation
    }
    
    private func openNotification() {
        let vc = NotificationVC()
        self.presentWithSheetPresentation(vc, isDismissable: true)
    }
}
