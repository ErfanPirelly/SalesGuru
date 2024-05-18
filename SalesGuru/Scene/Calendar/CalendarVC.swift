//
//  CallsVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/23/24.
//

import UIKit

class CallsVC: UIViewController {
    // MARK: - properties
    private let customView = CallsView()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    // MARK: - prepare UI
    private func prepareUI() {
        view.addSubview(customView)
        customView.pinToEdge(on: view)
    }
}
