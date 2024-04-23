//
//  LandscapeActivityVC.swift
//  Pirelly
//
//  Created by mmdMoovic on 11/15/23.
//

import UIKit

class LandscapeActivityVC: UIActivityViewController {
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
