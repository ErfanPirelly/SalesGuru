//
//  DisableAIVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/2/24.
//

import UIKit

class DisableAIVC: UIViewController {
    // MARK: - properties
    private let customView = DisableAIView()
    
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
