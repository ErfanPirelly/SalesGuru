//
//  UIButton+UIImage.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/18/23.
//

import UIKit

extension UIButton {
    func addImageToLeft(_ image: AImages) {
        self.setImage(.get(image: image)!, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.frame.size.width/2, bottom: 0, right: 15)
        self.contentHorizontalAlignment = .center
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    func addImageToLeft(image: UIImage?) {
        self.setImage(image, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.frame.size.width/2, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .center
        self.imageView?.contentMode = .scaleAspectFit
    }
}
