//
//  Uimage+Get.swift
//  Pirelly
//
//  Created by Mohammad Takbiri on 5/29/23.
//

import UIKit

extension UIImage {
    static func get(image: AImages) -> UIImage? {
        return UIImage(named: image.rawValue)
    }
    
    static func getShablon(carType: CarType, side: CarSide) -> UIImage? {
        return UIImage(named: carType.getImage(side: side))
    }
}
