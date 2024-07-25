//
//  AISettingVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/3/24.
//

import UIKit

protocol AISettingDelegate: AISettingViewDelegate {}

class AISettingVC: UIViewController {
    // MARK: - properties
    private let customView = AISettingView()
    private var settings: [IMAISetting]
    private let viewModel: AISettingVM
    weak var delegate: AISettingDelegate?
    
    // MARK: - init
    init(settings: [IMAISetting], chatId: String) {
        self.viewModel = .init(id: chatId)
        self.settings = settings
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
        view.addSubview(customView)
        customView.pinToEdge(on: view)
        customView.delegate = self
        customView.setData(data: settings)
    }
}

// MARK: - view delegate
extension AISettingVC: AISettingViewDelegate {
    func didChangeValue(for setting: IMAISetting) {
        self.settings.replaceOrAppend(setting, firstMatchingKeyPath: \.id)
        viewModel.changeValue(for: setting)
        delegate?.didChangeValue(for: setting)
    }
}
