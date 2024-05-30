//
//  Navigation.swift
//  Pirelly
//
//  Created by shndrs on 6/22/23.
//

import UIKit

// MARK: - Base Navigation

class BaseNavigationController: UINavigationController {}

// MARK: - Life Cycle

extension BaseNavigationController {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setup()
    }
    
}

// MARK: - Methods
extension BaseNavigationController {
    
    @objc func setup() {
        navBasicConfig()
        interactivePopGestureRecognizer?.delegate = self
        interactivePopGestureRecognizer?.isEnabled = true

        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.buttonAppearance.normal.titleTextAttributes = [
                .font: UIFont.Fonts.light(UINavigationController.backButtonTextSize),
                .foregroundColor: UIColor.ui.label
            ]
            navBarAppearance.largeTitleTextAttributes = [
                .font: UIFont.Fonts.semiBold(UINavigationController.largeTitleTextSize),
                .foregroundColor: UIColor.ui.label
            ]
            navBarAppearance.titleTextAttributes = [
                .font: UIFont.Fonts.semiBold(UINavigationController.titleTextSize),
                .foregroundColor: UIColor.ui.label
            ]
            navBarAppearance.backgroundColor = UIColor.ui.secondaryBack
            self.navigationBar.barStyle = .default
            self.navigationBar.isTranslucent = false
            self.navigationBar.standardAppearance = navBarAppearance
            self.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            self.edgesForExtendedLayout = []
        }
    }
}

// MARK: - interactive gesture
extension BaseNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // Implement your logic here to specify if this gesture should be required to fail by another gesture
        return false
    }
}

// MARK: - Clean Navigation

final class CleanNavigation: BaseNavigationController {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setup()
    }
    
    override func setup() {
        super.setup()
        navBasicConfig()
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.scrollEdgeAppearance = .none
        navigationController?.isNavigationBarHidden = true
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.buttonAppearance.normal.titleTextAttributes = [
                .font: UIFont.Fonts.light(UINavigationController.backButtonTextSize),
                .foregroundColor: UIColor.ui.primaryBlue ?? .ui.label
            ]
            navBarAppearance.largeTitleTextAttributes = [
                .font: UIFont.Fonts.semiBold(UINavigationController.largeTitleTextSize),
                .foregroundColor: UIColor.ui.primaryBlue ?? .ui.label
            ]
            navBarAppearance.titleTextAttributes = [
                .font: UIFont.Fonts.semiBold(UINavigationController.titleTextSize),
                .foregroundColor: UIColor.ui.primaryBlue ?? .ui.label
            ]
            navBarAppearance.backgroundColor = UIColor.ui.secondaryBack
            self.navigationBar.tintColor = UIColor.ui.primaryBlue
            navBarAppearance.shadowColor = .clear
            self.navigationBar.standardAppearance = navBarAppearance
            self.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            self.edgesForExtendedLayout = []
        }
    }
    
}

// MARK: - LandscapeNavigation
final class LandscapeNavigation: BaseNavigationController {
    var dismissed: Action?
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setup()
    }
    
    override func setup() {
        super.setup()
        navBasicConfig()
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.buttonAppearance.normal.titleTextAttributes = [
                .font: UIFont.Fonts.light(UINavigationController.backButtonTextSize),
                .foregroundColor: UIColor.ui.primaryBlue ?? .ui.label
            ]
            navBarAppearance.largeTitleTextAttributes = [
                .font: UIFont.Fonts.semiBold(UINavigationController.largeTitleTextSize),
                .foregroundColor: UIColor.ui.primaryBlue ?? .ui.label
            ]
            navBarAppearance.titleTextAttributes = [
                .font: UIFont.Fonts.semiBold(UINavigationController.titleTextSize),
                .foregroundColor: UIColor.ui.primaryBlue ?? .ui.label
            ]
            navBarAppearance.backgroundColor = UIColor.ui.secondaryBack
            self.navigationBar.tintColor = UIColor.ui.primaryBlue
            navBarAppearance.shadowColor = .clear
            self.navigationBar.standardAppearance = navBarAppearance
            self.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            self.edgesForExtendedLayout = []
        }
    }
}

// MARK: - Shadowless Navigation

final class ShadowlessNavigation: BaseNavigationController {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setup()
    }
    
    override func setup() {
        super.setup()
        navBasicConfig()
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = UIColor.ui.secondaryBack
            navBarAppearance.shadowColor = .clear
            navBarAppearance.buttonAppearance.normal.titleTextAttributes = [
                .font: UIFont.Fonts.light(UINavigationController.backButtonTextSize),
                .foregroundColor: UIColor.ui.label
            ]
            navBarAppearance.largeTitleTextAttributes = [
                .font: UIFont.Fonts.semiBold(UINavigationController.largeTitleTextSize),
                .foregroundColor: UIColor.ui.label
            ]
            navBarAppearance.titleTextAttributes = [
                .font: UIFont.Fonts.semiBold(UINavigationController.titleTextSize),
                .foregroundColor: UIColor.ui.label
            ]
            self.navigationBar.standardAppearance = navBarAppearance
            self.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            self.edgesForExtendedLayout = []
        }
    }
    
}
