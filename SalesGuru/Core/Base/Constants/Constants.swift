//
//  Constants.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/16/23.
//

import UIKit

struct K {
    struct size {
        static var bounds = UIScreen.main.bounds
        static var portrait: CGSize {
            let width = bounds.width > bounds.height ? bounds.height : bounds.width
            let height = bounds.width > bounds.height ? bounds.width : bounds.height
            return CGSize(width: width, height: height)
        }
        
        static var landscape: CGSize {
            let width = bounds.width > bounds.height ? bounds.height : bounds.width
            let height = bounds.width > bounds.height ? bounds.width : bounds.height
            return CGSize(width: height, height: width)
        }
    }
}
