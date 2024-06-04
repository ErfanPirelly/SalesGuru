//
//  CreateLeadMainVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/4/24.
//

import UIKit

class CreateLeadMainVC: UIViewController {
    // MARK: - properties
    private let customView = CreateLeadMainView()
    
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

// MARK: - view delegate
extension CreateLeadMainVC: CreateLeadMainViewDelegate {
    func stateDidUpdated(to state: CreateLeadMainView.State) {
        let presenter = presentationController
        presenter?.containerViewWillLayoutSubviews()
        presenter?.containerViewDidLayoutSubviews()
    }
}
