//
//  UIViewController+.swift
//  Pirelly
//
//  Created by mmdMoovic on 9/13/23.
//

import UIKit

extension UIViewController {
    func dismissKey(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(gesture: UITapGestureRecognizer){
//        view.endEditing(true)
    }
    
    
    @objc func presentWithSheetPresentation(_ vc: UIViewController, isDismissable: Bool) {
        let presentationController = SheetModalPresentationController(presentedViewController: vc,
                                                                      presenting: self,
                                                                      isDismissable: isDismissable)
        vc.transitioningDelegate = presentationController
        vc.modalPresentationStyle = .custom
        present(vc, animated: true)
    }
    
    @objc func presentWithCenterPresentation(_ vc: UIViewController, isDismissable: Bool) {
        let presentationController = CenterModalPresentationController(presentedViewController: vc,
                                                                      presenting: self,
                                                                      isDismissable: isDismissable)
        vc.transitioningDelegate = presentationController
        vc.modalPresentationStyle = .custom
        present(vc, animated: true)
    }
}
