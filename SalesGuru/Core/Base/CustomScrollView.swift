//
//  CustomScrollView.swift
//  Pirelly
//
//  Created by shndrs on 8/6/23.
//

import UIKit

protocol KeyboardManagerDelegate: NSObjectProtocol {
    func keyboardDidShow(_ scrollView: UIScrollView)
    func keyboardDidHide(_ scrollView: UIScrollView)
}

class CustomScrollView: UIScrollView {
    
    weak var keyboardManagerDelegate: KeyboardManagerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.registerForNotifications()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.registerForNotifications()
    }

    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardDidShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardDidHideNotification,
                                                  object: nil)
    }
    
    // MARK: - Methods

    fileprivate func registerForNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo!
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        if let view = self.superview {
            keyboardFrame = view.convert(keyboardFrame, from: nil)
        }
        var contentInset: UIEdgeInsets = self.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.contentInset = contentInset
        self.scrollIndicatorInsets = contentInset
        self.keyboardManagerDelegate?.keyboardDidShow(self)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        self.contentInset = contentInset
        self.keyboardManagerDelegate?.keyboardDidHide(self)
    }

}
