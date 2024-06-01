//
//  DealerTypeVC.swift
//  Pirelly
//
//  Created by mmdMoovic on 10/27/23.
//

import UIKit

class DealerTypeVC: UIViewController {
    // MARK: - properties
    let customView = DealerTypeView()
    let viewModel: CompanyInformationVM
    
    // MARK: - init
    init(viewModel: CompanyInformationVM) {
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
        customView.delegate = self
        view.addSubview(customView)
        customView.pinToEdge(on: view)
    }
}

extension DealerTypeVC: DealerTypeItemViewDelegate {
    func selectedItem(with text: String, view: DealerTypeItemView) {
        customView.items.forEach({
            $0.selected = false
        })
        view.selected = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: true) {
                self.viewModel.dealerType.accept(text)
            }
        }
    }
}
