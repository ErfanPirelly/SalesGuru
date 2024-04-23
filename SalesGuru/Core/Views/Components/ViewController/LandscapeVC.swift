//
//  LandscapeVC.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/23/23.
//

import UIKit

class landscapeVC: UIViewController {
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
