//
//  UIView.swift
//  Pirelly
//
//  Created by shndrs on 6/17/23.
//

import UIKit

extension UIView {
    
    func addCornerRadius(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(radius)
    }
    
    func addBorder(color: UIColor = UIColor.white,
                          thickness: CGFloat = 1.0) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = thickness
    }
    
    func fade(duration: TimeInterval,
              delay: TimeInterval,
              isIn: Bool = true, additionalAction: Actional = nil) {
        UIView.animate(withDuration: duration, delay: delay,
                       options: .curveEaseInOut, animations: { [weak self] in
            guard self != nil else { return }
            self?.alpha = isIn ? 1 : 0
            additionalAction?()
        })
    }
    
    func addBorder(edges: UIRectEdge,
                   color: UIColor = UIColor.white,
                   thickness: CGFloat = 1.0) -> [UIView] {
        var borders = [UIView]()
        func border() -> UIView {
            let border = UIView(frame: CGRect.zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            return border
        }
        if edges.contains(.top) || edges.contains(.all) {
            let top = border()
            addSubview(top)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[top(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["top": top]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[top]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["top": top]))
            borders.append(top)
        }
        if edges.contains(.left) || edges.contains(.all) {
            let left = border()
            addSubview(left)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[left(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["left": left]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[left]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["left": left]))
            borders.append(left)
        }
        if edges.contains(.right) || edges.contains(.all) {
            let right = border()
            addSubview(right)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:[right(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["right": right]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[right]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["right": right]))
            borders.append(right)
        }
        if edges.contains(.bottom) || edges.contains(.all) {
            let bottom = border()
            addSubview(bottom)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["bottom": bottom]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[bottom]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["bottom": bottom]))
            borders.append(bottom)
        }
        return borders
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func shake(ratio: CGFloat? = 1.5) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 1
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint.init(x:self.center.x - ratio!,
                                                            y:self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint.init(x:self.center.x + ratio!,
                                                          y:self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func lock() {
        if let _ = viewWithTag(10) {
            Logger.log(.info, "View is already locked")
            
        } else {
            let lockView = UIView()
            lockView.translatesAutoresizingMaskIntoConstraints = false
            lockView.backgroundColor = UIColor.black.withAlphaComponent(0.88)
            lockView.tag = 10
            lockView.alpha = 0.0
            addSubview(lockView)
            lockView.pinToEdge(on: self)
            let activity = UIActivityIndicatorView(style: .medium)
            activity.translatesAutoresizingMaskIntoConstraints = false
            activity.color = .white
            activity.hidesWhenStopped = true
            lockView.addSubview(activity)
            activity.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            activity.startAnimating()
            UIView.animate(withDuration: 0.2) {
                lockView.alpha = 1.0
            }
        }
    }

    func unlock() {
        if let lockView = viewWithTag(10) {
            UIView.animate(withDuration: 0.2, animations: {
                lockView.alpha = 0.0
            }) { _ in
                lockView.removeFromSuperview()
            }
        }
    }
    
}
