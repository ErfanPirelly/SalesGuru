//
//  UIImage+rotate.swift
//  Pirelly
//
//  Created by mmdMoovic on 10/15/23.
//

import UIKit

extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        var newSize = CGRect(origin: CGPoint.zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
            .size

        // Ensure the image size is a whole number
        newSize.width = round(newSize.width)
        newSize.height = round(newSize.height)

        UIGraphicsBeginImageContext(newSize)

        if let context = UIGraphicsGetCurrentContext() {
            // Move the origin to the center of the image
            context.translateBy(x: newSize.width / 2, y: newSize.height / 2)

            // Rotate the image
            context.rotate(by: radians)

            // Draw the image
            self.draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))

            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return newImage ?? self
        }
        return self
    }
    
    func crop(newSize: CGSize) -> UIImage {
        let sourceImage = self
        // Determines the x,y coordinate of a centered
        // sideLength by sideLength square
        let sourceSize = sourceImage.size
        let newSize = sourceSize.calculateCropRect(targetAspectRatio: newSize.height/newSize.width)
        
        let xOffset = newSize.origin.y
        let yOffset = newSize.origin.x

        // The cropRect is the rect of the image to keep,
        // in this case centered
        let cropRect = CGRect(
            x: xOffset,
            y: yOffset,
            width: newSize.height,
            height: newSize.width
        ).integral
        print(cropRect)
        // Center crop the image
        let sourceCGImage = sourceImage.cgImage!
        let croppedCGImage = sourceCGImage.cropping(
            to: cropRect
        )!
        
        return UIImage(cgImage: croppedCGImage)
    }
    
    func resize(to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        
        if let context = UIGraphicsGetCurrentContext() {
            // Move the origin to the center of the image
            context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
            
            // Draw the image
            self.draw(in: CGRect(x: -newSize.width / 2, y: -newSize.height / 2, width: newSize.width, height: newSize.height))
            
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage ?? self
        }
        return self
    }
}
