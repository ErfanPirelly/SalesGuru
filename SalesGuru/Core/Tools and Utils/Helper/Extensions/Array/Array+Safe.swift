//
//  Array+Safe.swift
//  BaseModule
//
//  Created by mmdMoovic on 6/11/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//


public extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

