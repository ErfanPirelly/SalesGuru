//
//  UITextField+ErrorBorder.swift
//  Pirelly
//
//  Created by Mohammad Takbiri on 6/4/23.
//

import UIKit

extension UIView {
    
    func showErrorBorder(message: String, offset: CGFloat = -8, font: UIFont = .Fonts.medium(12)) {
        self.layer.borderColor = UIColor.ui.red?.cgColor
        self.layer.borderWidth = 0.9
        guard let superView = self.superview else {return}
        if accessibilityIdentifier == nil {
            accessibilityIdentifier = UUID().uuidString
        }
        if !superView.subviews.contains(where: {$0.accessibilityLabel == ("errorLabel" + accessibilityIdentifier!)}) {
            let errorLabel = UILabel()
            errorLabel.alpha = 0
            errorLabel.text = ""
            errorLabel.textColor = .ui.red?.withAlphaComponent(0.72)
            errorLabel.font = font
            errorLabel.textAlignment = .left
            errorLabel.accessibilityLabel = "errorLabel" + accessibilityIdentifier!
            errorLabel.translatesAutoresizingMaskIntoConstraints = false
            superView.addSubview(errorLabel)
            NSLayoutConstraint.activate([
                errorLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: offset),
                errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//                errorLabel.heightAnchor.constraint(equalToConstant: 12)
            ])
            UIView.animate(withDuration: 0.4) {
                errorLabel.text = message
                errorLabel.alpha = 1
                errorLabel.layoutIfNeeded()
            }
        }
    }
    
    func hideErrorBorder(borderColor: UIColor = .clear) {
        self.layer.borderColor = borderColor.cgColor
        guard let superView = self.superview, let id = accessibilityIdentifier else {return}
        let subViews = superView.subviews
        let errorLabel = subViews.first(where: {$0.accessibilityLabel == "errorLabel" + id})
        UIView.animate(withDuration: 0.4) {
            errorLabel?.alpha = 0
            errorLabel?.layoutIfNeeded()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            errorLabel?.removeFromSuperview()
        }
    }
}
