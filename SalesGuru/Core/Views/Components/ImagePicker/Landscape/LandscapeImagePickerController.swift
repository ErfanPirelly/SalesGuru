//
//  LandscapeImagePickerController.swift
//  Pirelly
//
//  Created by mmdMoovic on 3/7/24.
//

import UIKit

class LandscapeImagePickerController: UIImagePickerController {
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
