//
//  NotificationVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/1/24.
//

import UIKit

class NotificationVC: UIViewController {
    // MARK: - properties
    private let customView = NotificationView()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    // MARK: - prepare UI
    private func prepareUI() {
        view.addSubview(customView)
        customView.pinToEdge(on: view)
        customView.configView(with: MockData.notifications)
    }
}
