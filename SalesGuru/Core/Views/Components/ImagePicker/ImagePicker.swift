//
//  ImagePicker.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/29/23.
//

import UIKit
import AVFoundation
import Photos
import CoreServices

public protocol ImagePickerDelegate: AnyObject {
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType)
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage)
    func imagePicker(_ imagePicker: ImagePicker, didSelect video: URL)
    func cancelButtonDidClick(on imageView: ImagePicker)
}

extension ImagePickerDelegate {
    func cancelButtonDidClick(on imageView: ImagePicker) {
        imageView.dismiss()
    }
    
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {}
    func imagePicker(_ imagePicker: ImagePicker, didSelect video: URL) {}
}

public class ImagePicker: NSObject {
    let config: UIConfig = inject()
    
    enum pickerType {
        case image
        case video
        
        var value: String {
            switch self {
            case .image:
                return  kUTTypeImage as String
            case.video:
                return kUTTypeMovie as String
            }
        }
    }
    
    public weak var controller: UIImagePickerController?
    public weak var delegate: ImagePickerDelegate? = nil

    public func dismiss() {
        controller?.dismiss(animated: true, completion: {[weak self] in
            guard let self = self else { return }
            self.config.canRotate = true
        })
    }
    
    func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        controller.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
        
        self.controller = controller
        DispatchQueue.main.async {
            viewController.present(controller, animated: true, completion: nil)
        }
    }
    
    func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType, mediaTypes: [pickerType]) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        controller.mediaTypes = mediaTypes.map(\.value)
        self.controller = controller
        
        DispatchQueue.main.async {
            viewController.present(controller, animated: true, completion: nil)
        }
    }
}

// MARK: Get access to camera or photo library

public extension ImagePicker {

    private func showAlert(targetName: String, completion: ((Bool) -> Void)?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alertVC = UIAlertController(title: "Access to the \(targetName)",
                                            message: "Please provide access to your \(targetName)",
                                            preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Settings", style: .default, handler: { action in
                guard   let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                        UIApplication.shared.canOpenURL(settingsUrl) else { completion?(false); return }
                UIApplication.shared.open(settingsUrl, options: [:]) { [weak self] _ in
                    self?.showAlert(targetName: targetName, completion: completion)
                }
            }))
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in completion?(false) }))
            Utils.topViewController(with: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?
                .rootViewController)?.present(alertVC, animated: true, completion: nil)
        }
    }

    func cameraAsscessRequest() {
        if delegate == nil { return }
        let source = UIImagePickerController.SourceType.camera
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            delegate?.imagePicker(self, grantedAccess: true, to: source)
        } else {
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard let self = self else { return }
                if granted {
                    self.delegate?.imagePicker(self, grantedAccess: granted, to: source)
                } else {
                    self.showAlert(targetName: "camera") { self.delegate?.imagePicker(self, grantedAccess: $0, to: source) }
                }
            }
        }
    }

    func photoGalleryAsscessRequest() {
        PHPhotoLibrary.requestAuthorization { [weak self] result in
            guard let self = self else { return }
            let source = UIImagePickerController.SourceType.photoLibrary
            if result == .authorized {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.imagePicker(self, grantedAccess: result == .authorized, to: source)
                }
            } else {
                self.showAlert(targetName: "photo gallery") { self.delegate?.imagePicker(self, grantedAccess: $0, to: source) }
            }
        }
    }
}

// MARK: UINavigationControllerDelegate

extension ImagePicker: UINavigationControllerDelegate { }

// MARK: UIImagePickerControllerDelegate

extension ImagePicker: UIImagePickerControllerDelegate {

    public func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            delegate?.imagePicker(self, didSelect: image)
            return
        }
        
        if let image = info[.originalImage] as? UIImage {
            delegate?.imagePicker(self, didSelect: image)
        } else if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            let pathString = videoUrl.relativePath
            print(pathString)
            self.delegate?.imagePicker(self, didSelect: videoUrl)
        } else {
            print("Other source")
        }
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.cancelButtonDidClick(on: self)
    }
}
