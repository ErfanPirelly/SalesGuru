//
//  CustomUISwitch.swift
//  Pirelly
//
//  Created by mmdMoovic on 11/10/23.
//

import UIKit
import RxCocoa

class CustomUISwitch: UIControl {
    public var onTintColor: UIColor? = .ui.primaryBlue!
    public var offTintColor: UIColor? = .ui.silverGray
    public var thumbTintColor: UIColor? = .white
    public var thumbCornerRadius: CGFloat = 7
    public var thumbSize = CGSize(width: 14, height: 14)
    public var padding: CGFloat = 3
    public var isOn = BehaviorRelay<Bool>(value: false)
    public var animationDuration: Double = 0.35
    // privates
    private var thumbView = UIView(frame: CGRect.zero)
    private var onPoint = CGPoint.zero
    private var offPoint = CGPoint.zero
    private var isAnimating = false
    
    convenience init(onTintColor: UIColor? = .ui.primaryBlue,
                     offTintColor: UIColor? = .ui.silverGray,
                     thumbTintColor: UIColor? = .white,
                     thumbCornerRadius: CGFloat,
                     thumbSize: CGSize = CGSize(width: 14, height: 14),
                     padding: CGFloat,
                     isOn: Bool = false, animationDuration: Double, thumbView: UIView = UIView(frame: CGRect.zero), onPoint: CoreFoundation.CGPoint = CGPoint.zero, offPoint: CoreFoundation.CGPoint = CGPoint.zero, isAnimating: Bool = false) {
        self.init()
        self.onTintColor = onTintColor
        self.offTintColor = offTintColor
        self.thumbTintColor = thumbTintColor
        self.thumbCornerRadius = thumbCornerRadius
        self.thumbSize = thumbSize
        self.isOn.accept(isOn)
        self.padding = padding
        self.animationDuration = animationDuration
        self.thumbView = thumbView
        self.onPoint = onPoint
        self.offPoint = offPoint
        self.isAnimating = isAnimating
        self.setupView()
    }
    
    // setup view
    func setupView() {
        self.clear()
        self.clipsToBounds = false
        self.thumbView.backgroundColor = self.thumbTintColor
        self.thumbView.isUserInteractionEnabled = false
        self.addSubview(self.thumbView)
    }
    
    // lay subviews
    public override func layoutSubviews() {
        super.layoutSubviews()
        if !self.isAnimating {
            self.layer.cornerRadius = 7
            self.backgroundColor = self.isOn.value ? self.onTintColor : self.offTintColor
            
            
            // thumb management
            let thumbSize = self.thumbSize != CGSize.zero ? self.thumbSize : CGSize(width: self.bounds.size.height - 3,
                                                                                    height: self.bounds.height - 3)
            let yPostition = (self.bounds.size.height - thumbSize.height) / 2
            self.onPoint = CGPoint(x: self.bounds.size.width - thumbSize.width - self.padding, y: yPostition)
            self.offPoint = CGPoint(x: self.padding, y: yPostition)
            self.thumbView.frame = CGRect(origin: self.isOn.value ? self.onPoint : self.offPoint, size: thumbSize)
            self.thumbView.layer.cornerRadius = self.thumbCornerRadius
        }
        
    }
    
    // logics
    private func clear() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    // animation
    private func animate() {
        let value = self.isOn.value
        self.isOn.accept(!value)
        self.isAnimating = true
        UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5, options: [.curveEaseOut,
                                                             .beginFromCurrentState], animations: {
                                                                 self.thumbView.frame.origin.x = self.isOn.value ? self.onPoint.x : self.offPoint.x
                                                                 self.backgroundColor = self.isOn.value ? self.onTintColor : self.offTintColor
        }, completion: { _ in
            self.isAnimating = false
            self.sendActions(for: .valueChanged)
        })
    }
    
    // tracking
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        self.animate()
        return true
    }
}
