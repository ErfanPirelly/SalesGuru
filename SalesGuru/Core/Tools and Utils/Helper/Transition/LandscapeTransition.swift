//
//  LandscapeTransition.swift
//  Pirelly
//
//  Created by mmdMoovic on 9/14/23.
//

import UIKit

class LandscapeTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5 // Set the duration of the transition
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
        else {
            return
        }

        let containerView = transitionContext.containerView

        if let landscapeVC = toVC as? landscapeVC {
            // Landscape to Portrait transition
            fromVC.view.alpha = 0
            containerView.addSubview(toVC.view)
            toVC.view.frame = CGRect(x: 0, y: containerView.bounds.size.height, width: containerView.bounds.size.width, height: containerView.bounds.size.height)
            toVC.view.layoutIfNeeded()
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toVC.view.frame = containerView.bounds
                
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        } else {
            toVC.view.alpha = 0
            // Portrait to Landscape transition (dismissal)
            UIView.animate(withDuration: transitionDuration(using: transitionContext),
                           delay: 0.3,
                           animations: {
                toVC.view.alpha = 1
                toVC.navigationController?.view.transform = .identity
                fromVC.view.frame = CGRect(x: containerView.bounds.size.width,
                                           y: 0,
                                           width: containerView.bounds.size.width,
                                           height: containerView.bounds.size.height)
                toVC.view.layoutIfNeeded()
            }, completion: { _ in
                fromVC.view.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}
