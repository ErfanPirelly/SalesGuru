//
//  UIViewController.swift
//  Pirelly
//
//  Created by shndrs on 6/17/23.
//

import UIKit

// MARK: - Storyboard Instantiate

extension UIViewController {
    
    class func instantiate(from storyboard: UIStoryboard? = nil) -> Self {
        return get(storyboard: storyboard)
    }
    
    class func instantiate(storyboard: StoryboardId) -> Self {
        return instantiate(from: UIStoryboard(name: storyboard.rawValue, bundle: nil))
    }
       
    @discardableResult
    private class func get<T: UIViewController>(storyboard: UIStoryboard? = nil) -> T {
        let className = String(describing: self)
        var story = storyboard
        if story == nil {
            story = UIStoryboard(name: className, bundle: .main)
        }
        return story!.instantiateViewController(withIdentifier: className) as! T
    }
    
}

// MARK: - Modal

extension UIViewController {
    
    func dismissModalStack(animated: Bool, completion: (() -> Void)?) {
        let fullscreenSnapshot = UIApplication.shared.delegate?.window??.snapshotView(afterScreenUpdates: false)
        if !isBeingDismissed {
            var rootVc = presentingViewController
            while rootVc?.presentingViewController != nil {
                rootVc = rootVc?.presentingViewController
            }
            let secondToLastVc = rootVc?.presentedViewController
            if fullscreenSnapshot != nil {
                secondToLastVc?.view.addSubview(fullscreenSnapshot!)
            }
            secondToLastVc?.dismiss(animated: false, completion: {
                rootVc?.dismiss(animated: true, completion: completion)
            })
        }
    }
    
    func share(anchor: Any, activityItems: [Any], callback: ((Bool) -> Void)? = nil) {
        let preferredOrientation = preferredInterfaceOrientationForPresentation
        guard preferredOrientation == .portrait || preferredOrientation == .portraitUpsideDown || preferredOrientation == .unknown else {
            landscapeShare(anchor: anchor, activityItems: activityItems, callback: callback)
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems:
            activityItems, applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {
            (activityType, completed, returnedItems, error) in
            callback?(completed)
        }
        if let view = anchor as? UIView {
            activityViewController.popoverPresentationController?.sourceView = view
            activityViewController.popoverPresentationController?.sourceRect = view.bounds
        } else if let barButtonItem = anchor as? UIBarButtonItem {
            activityViewController.popoverPresentationController?.barButtonItem = barButtonItem
        }
        self.present(activityViewController, animated: true,
                     completion: nil)
    }
    
    
   private func landscapeShare(anchor: Any, activityItems: [Any], callback: ((Bool) -> Void)? = nil) {
        let activityViewController = LandscapeActivityVC(activityItems:
            activityItems, applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {
            (activityType, completed, returnedItems, error) in
            callback?(completed)
        }
        if let view = anchor as? UIView {
            activityViewController.popoverPresentationController?.sourceView = view
            activityViewController.popoverPresentationController?.sourceRect = view.bounds
        } else if let barButtonItem = anchor as? UIBarButtonItem {
            activityViewController.popoverPresentationController?.barButtonItem = barButtonItem
        }
        self.present(activityViewController, animated: true,
                     completion: nil)
    }
    
}
