//
//  LandscapeAlertController.swift
//  Pirelly
//
//  Created by mmdMoovic on 12/31/23.
//


import UIKit

class LandscapeAlertController: UIAlertController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}

