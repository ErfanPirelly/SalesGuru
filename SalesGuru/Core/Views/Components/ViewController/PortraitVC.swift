//
//  PortraitVC.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/23/23.
//

import UIKit

class PortraitVC: UIViewController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
