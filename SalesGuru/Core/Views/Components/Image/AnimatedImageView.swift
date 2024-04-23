//
//  AnimatedImageView.swift
//  Pirelly
//
//  Created by mmdMoovic on 10/25/23.
//

import UIKit

class AnimatedImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        // Customize your view here
        startBouncingAnimation()
    }
    
    func startBouncingAnimation() {
        // Bounce animation along z-direction
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.translation.z")
        
        // Set up keyframe values
        let bounceDepth: CGFloat = -20.0
        bounceAnimation.values = [0.0, bounceDepth, 0.0, bounceDepth, 0.0] // Added an extra 0.0 for seamless loop
        
        // Set up keyframe times
        bounceAnimation.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0] // Adjusted for the extra keyframe
        
        // Set up animation duration
        bounceAnimation.duration = 1.0
        
        // Animation options
        bounceAnimation.timingFunctions = [CAMediaTimingFunction(name: .easeInEaseOut)]
        
        // Scale animation
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 1.1
        scaleAnimation.duration = 1
        
        // Configure alpha animation
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = 0.5
        alphaAnimation.toValue = 1
        alphaAnimation.duration = 1
        
        // Group the animations
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [bounceAnimation, scaleAnimation, alphaAnimation]
        groupAnimation.duration = 1.0 // Total duration
        
        // Make the animation repeat forever
        groupAnimation.repeatCount = .infinity
        groupAnimation.autoreverses = true
        // Add the animation to the view's layer
        layer.add(groupAnimation, forKey: "bouncingScaleAlphaAnimation")
    }
    
    func stopBouncingAnimation() {
        // Remove the animation
        layer.removeAllAnimations()
    }
}

