//
//  CenterModalPresentationController.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/8/23.
//

import Foundation


import UIKit

final class CenterModalPresentationController: UIPresentationController {
    // MARK: Private Properties
    var isDismissable: Bool
    private let interactor = UIPercentDrivenInteractiveTransition()
    private let dimmingView = UIView()
    private var propertyAnimator: UIViewPropertyAnimator!
    private var isInteractive = false
    private var realPresentingViewController: UIViewController?

    override var parentFocusEnvironment: UIFocusEnvironment? {
        return presentingViewController
    }

    // MARK: Public Properties
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView,
              let presentedView = presentedView else { return .zero }
        
        // Make sure to account for the safe area insets
        let safeAreaFrame = presentedView.bounds
        let fittingSize = calculateSize(for: presentedView)
        let targetHeight = fittingSize.height
        let targetWidth = fittingSize.width
        var frame = safeAreaFrame
        let offsetY = containerView.frame.height - targetHeight
        let offsetX = containerView.frame.width - targetWidth
        frame.origin.y = offsetY/2
        frame.origin.x = offsetX/2
        frame.size.width = targetWidth
        frame.size.height = targetHeight
        return frame
    }
    
    func calculateSize(for view: UIView) -> CGSize {
        var fittingSize = CGSize(
            width: UIView.layoutFittingCompressedSize.width,
            height: UIView.layoutFittingCompressedSize.height
        )
        
        let targetHeight = view.systemLayoutSizeFitting(
            fittingSize, withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow).height
        
        fittingSize.height = targetHeight
        
        let targetWidth = view.systemLayoutSizeFitting(
            fittingSize, withHorizontalFittingPriority: .defaultLow,
            verticalFittingPriority: .required).width
        
        return CGSize(width: targetWidth, height: targetHeight)
    }
    
    // MARK: Initializers
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?,
         isDismissable: Bool) {
        self.isDismissable = isDismissable
        self.realPresentingViewController = presentingViewController
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }

    // MARK: Public Methods
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    override func presentationTransitionWillBegin() {
        guard let presentedView = presentedView,
              let containerView = containerView,
              let realPresentingViewController = realPresentingViewController,
              let superview = realPresentingViewController.view.superview else { return }

        let containerBounds = superview.bounds
        containerView.removeFromSuperview()
        realPresentingViewController.view.superview?.addSubview(containerView)
        containerView.frame = containerBounds

        containerView.addSubview(presentedView)
        presentedView.frame.size = frameOfPresentedViewInContainerView.size
        presentedView.frame.origin.y = containerBounds.height
        presentedView.frame.origin.x = frameOfPresentedViewInContainerView.origin.x
        presentedView.layoutIfNeeded()

        // Add a dimming view below the presented view controller.
        dimmingView.backgroundColor = .black
        dimmingView.frame = containerBounds
        dimmingView.alpha = 0
        containerView.insertSubview(dimmingView, at: 0)
        // Add pan gesture recognizers for interactive dismissal.
        presentedView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))

        // Add tap recognizer for sheet dismissal.
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))

        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [unowned self] _ in
            self.dimmingView.alpha = 0.9
        })
    }

    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [unowned self] _ in
            self.dimmingView.alpha = 0
        })
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        // Not setting this to nil causes a retain cycle.
        propertyAnimator = nil
    }

    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)

        if propertyAnimator != nil && !propertyAnimator.isRunning {
            presentedView?.frame = frameOfPresentedViewInContainerView
            presentedView?.layoutIfNeeded()
        }
    }

    // MARK: Private Methods
    @objc
    private func handleDismiss() {
        presentedView?.endEditing(true)
        if isDismissable {
            presentedViewController.dismiss(animated: true)
        }
    }

    @objc
    private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard isDismissable, let containerView = containerView else { return }

        let percent = gesture.translation(in: containerView).y / containerView.bounds.height
        
        switch gesture.state {
        case .began:
            if !presentedViewController.isBeingDismissed {
                isInteractive = true
                presentedViewController.resignFirstResponder()
                presentedViewController.dismiss(animated: true)
            }

        case .changed:
            interactor.update(percent)
            
        case .cancelled, .failed:
            interactor.cancel()
            isInteractive = false
            
        case .ended:
            let velocity = gesture.velocity(in: containerView).y
            interactor.completionSpeed = 0.9
            if percent > 0.3 || velocity > 1600 {
                interactor.finish()
            } else {
                interactor.cancel()
            }
            isInteractive = false
            
        default:
            break
        }
    }
}

// MARK: UIViewControllerAnimatedTransitioning

extension CenterModalPresentationController: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        interruptibleAnimator(using: transitionContext).startAnimation()
    }

    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        propertyAnimator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext),
                                                  timingParameters: UISpringTimingParameters(dampingRatio: 1.0,
                                                                                            initialVelocity: CGVector(dx: 1, dy: 1)))
        propertyAnimator.addAnimations { [unowned self] in
            if self.presentedViewController.isBeingPresented {
                transitionContext.view(forKey: .to)?.frame = self.frameOfPresentedViewInContainerView
            } else {
                transitionContext.view(forKey: .from)?.frame.origin.y = transitionContext.containerView.frame.maxY
            }
        }
        propertyAnimator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        return propertyAnimator
    }
}

// MARK: UIViewControllerTransitioningDelegate

extension CenterModalPresentationController: UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        self
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self
    }

    func interactionControllerForDismissal(
        using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        isInteractive ? interactor : nil
    }
}
