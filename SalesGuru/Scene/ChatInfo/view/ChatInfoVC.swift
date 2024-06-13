//
//  ChatInfoVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/13/24.
//

import UIKit

class ChatInfoVC: UIViewController {
    // MARK: - properties
    private let customView = ChatInfoView()
    let viewModel: ChatInfoVM
    
    // MARK: - init
    init(viewModel: ChatInfoVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    // MARK: - prepare UI
    private func prepareUI() {
        view.backgroundColor = .white
        view.addSubview(customView)
        customView.pinToEdge(on: view)
        customView.config(view: viewModel.generateUIModels())
    }
}
