//
//  ConversationVC.swift
//  SalesGuru
//
//  Created by mmdMoovic on 4/29/24.
//

import UIKit

class ConversationVC: UIViewController {
    // MARK: - properties
    private let customView = ConversationView()
    
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
