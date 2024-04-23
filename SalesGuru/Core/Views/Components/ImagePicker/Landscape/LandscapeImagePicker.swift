//
//  LandscapeImagePicker.swift
//  Pirelly
//
//  Created by mmdMoovic on 3/7/24.
//

import UIKit
import AVFoundation
import Photos
import CoreServices

public class LandscapeImagePicker: ImagePicker {
    override func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
        let controller = LandscapeImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        controller.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
        config.canRotate = false
        self.controller = controller
        DispatchQueue.main.async {
            viewController.present(controller, animated: true, completion: nil)
        }
    }
    
    override func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType, mediaTypes: [pickerType]) {
        let controller = LandscapeImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        controller.mediaTypes = mediaTypes.map(\.value)
        self.controller = controller
        config.canRotate = false
        DispatchQueue.main.async {
            viewController.present(controller, animated: true, completion: nil)
        }
    }
}
