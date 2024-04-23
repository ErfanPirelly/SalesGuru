//
//  ShablonImages.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/11/23.
//

import UIKit

enum CarSide: String, CaseIterable {
    case front
    case back = "Rear"
    case left
    case leftBack = "Left Rear"
    case leftFront = "Left Front"
    case right
    case rightBack = "Right Rear"
    case rightFront = "Right Front"
    
    init(angle: Double){
        switch angle {
        case 0...22.5:
            self = .front
            
        case 22.5...52.5:
            self = .rightFront
            
        case 52.5...127.5:
            self = .right
            
        case 127.5...157.5:
            self = .rightBack
            
        case 157.5...202.5:
            self = .back
            
        case 202.5...232.5:
            self = .leftBack
            
        case 232.5...307.5:
            self = .left
            
        case 307.5...337.5:
            self = .leftFront
            
        default:
            self = .front
        }
    }
}

extension CarSide {
    init?(maxCount: Int, current: Int) {
        if maxCount == 5 {
            switch current {
            case 1: self = .front
            case 2: self = .rightFront
            case 3: self = .right
            case 4: self = .back
            case 5: self = .left
            default:
                return nil
            }
        } else if maxCount == 8 {
            switch current {
            case 1: self = .front
            case 2: self = .rightFront
            case 3: self = .right
            case 4: self = .rightBack
            case 5: self = .back
            case 6: self = .leftBack
            case 7: self = .left
            case 8: self = .leftFront
            default:
                return nil
            }
        } else {
            return nil
        }
    }
    
    var overallExteriorImage: UIImage? {
        var str = "overall_exterior_"
        switch self {
        case .front:
            str += "01"
        case .back:
            str += "05"
        case .left:
            str += "07"
        case .leftBack:
            str += "06"
        case .leftFront:
            str += "08"
        case .right:
            str += "03"
        case .rightBack:
            str += "04"
        case .rightFront:
            str += "02"            
        }
        return UIImage(named: str)
    }
}

enum CarType: String, CaseIterable, Codable {
    case sedan = "sedan"
    case coupe = "coupe"
    case hatchback = "hatchback"
    case suv = "suv"
    case truck = "truck"
    case miniVan = "miniVan"
    
    func getImage(side: CarSide) -> String {
        switch side {
        case .front:
            return front
            
        case .back:
            return back
            
        case .left:
            return leftSide
            
        case .right:
            return rightSide
            
        case .leftBack:
            return leftBack
            
        case .leftFront:
            return leftFront
            
        case .rightBack:
            return rightBack
            
        case .rightFront:
            return rightFront
        }
    }
    
    var image: UIImage? {
        switch self {
        case .coupe:
            return UIImage(named: "Coupe")
        case .hatchback:
            return UIImage(named: "hatchback")
        case .miniVan:
            return UIImage(named: "miniVan")
        case .sedan:
            return UIImage(named: "sedan")
        case .suv:
            return UIImage(named: "SUV")
        case .truck:
            return UIImage(named: "truck")
        }
    }
    
    var front: String {
        var str = ""
        switch self {
        case .coupe:
            str = "coupeFront"
            
        case .hatchback:
            str = "hatchbackFront"
            
        case .miniVan:
            str = "miniVanFront"
            
        case .sedan:
            str = "sedanFront"
            
        case .suv:
            str = "SUVFront"
            
        case .truck:
            str = "truckFront"
        }
        return str
    }
    
    var back: String {
        var str = ""
        switch self {
        case .coupe:
            str = "coupeBack"
            
        case .hatchback:
            str = "hatchbackBack"
            
        case .miniVan:
            str = "miniVanBack"
            
        case .sedan:
            str = "sedanBack"
            
        case .suv:
            str = "SUVBack"
            
        case .truck:
            str = "truckBack"
        }
        return str
    }
    
    var leftSide: String {
        var str = ""
        switch self {
        case .coupe:
            str = "coupeLeft"
            
        case .hatchback:
            str = "hatchbackLeft"
            
        case .miniVan:
            str = "miniVanLeft"
            
        case .sedan:
            str = "sedanLeft"
            
        case .suv:
            str = "SUVLeft"
            
        case .truck:
            str = "truckLeft"
        }
        return str
    }
    
    var rightSide: String {
        var str = ""
        switch self {
        case .coupe:
            str = "coupeRight"
            
        case .hatchback:
            str = "hatchbackRight"
            
        case .miniVan:
            str = "miniVanRight"
            
        case .sedan:
            str = "sedanRight"
            
        case .suv:
            str = "SUVRight"
        case .truck:
            str = "truckRight"
        }
        return str
    }
    
    var rightBack: String {
        var str = ""
        switch self {
        case .coupe:
            str = "coupeRightBack"
            
        case .hatchback:
            str = "hatchbackRightBack"
            
        case .miniVan:
            str = "miniVanRightBack"
            
        case .sedan:
            str = "sedanRightBack"
            
        case .suv:
            str = "SUVRightBack"
            
        case .truck:
            str = "truckRightBack"
        }
        return str
    }
    
    var rightFront: String {
        var str = ""
        switch self {
        case .coupe:
            str = "coupeRightFront"
            
        case .hatchback:
            str = "hatchbackRightFront"
            
        case .miniVan:
            str = "miniVanRightFront"
            
        case .sedan:
            str = "sedanRightFront"
            
        case .suv:
            str = "SUVRightFront"
            
        case .truck:
            str = "truckRightFront"
        }
        return str
    }
    
    var leftBack: String {
        var str = ""
        switch self {
        case .coupe:
            str = "coupeLeftBack"
            
        case .hatchback:
            str = "hatchbackLeftBack"
            
        case .miniVan:
            str = "miniVanLeftBack"
            
        case .sedan:
            str = "sedanLeftBack"
            
        case .suv:
            str = "SUVLeftBack"
            
        case .truck:
            str = "truckLeftBack"
        }
        return str
    }
    
    var leftFront: String {
        var str = ""
        switch self {
        case .coupe:
            str = "coupeLeftFront"
            
        case .hatchback:
            str = "hatchbackLeftFront"
            
        case .miniVan:
            str = "miniVanLeftFront"
            
        case .sedan:
            str = "sedanLeftFront"
            
        case .suv:
            str = "SUVLeftFront"
            
        case .truck:
            str = "truckLeftFront"
        }
        return str
    }
}
