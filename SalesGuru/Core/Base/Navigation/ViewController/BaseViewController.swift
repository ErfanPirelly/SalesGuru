//
//  BaseViewController.swift
//  Pirelly
//
//  Created by shndrs on 6/18/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    var dismissBlock: Action?
    var enableDismiss: Bool = false {
        willSet(newValue) {
            self.navigationItem
                .setRightBarButtonItems([dismissBarButton],
                                        animated: newValue)
        }
    }
    
    private lazy var dismissBarButton: UIBarButtonItem = {
        let temp = UIBarButtonItem(image: .get(image: .back),
                                   style: .plain,
                                   target: self,
                                   action: #selector(dismissPressed))
        temp.tintColor = .ui.primaryBlue
        return temp
    }()
    
    lazy var activityBarButton: UIBarButtonItem = {
        let activityView = UIBarButtonItem(customView: activityIndicator)
        return activityView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        return UIActivityIndicatorView(frame: CGRect(x: 0, y: 0,
                                                     width: 20, height: 20))
    }()
    
    @objc func dismissPressed() {
        self.dismiss(animated: true) { [weak self] in
            guard self != nil else { return }
            self?.dismissBlock?()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ui.secondaryBack
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
//                                                           style: .plain,
//                                                           target: nil,
//                                                           action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.navigationController?.isBeingPresented ?? false {
            enableDismiss = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.dismissBlock?()
    }
}
