//
//  Array+chunk.swift
//  Pirelly
//
//  Created by mmdMoovic on 11/15/23.
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
    func filterByIndex(condition: (Int) -> Bool) -> [Element] {
        return enumerated().compactMap { (index, element) in
            condition(index) ? element : nil
        }
    }
}
