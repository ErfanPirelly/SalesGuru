//
//  Array+replaceItem.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/26/23.
//

import Foundation

public extension Array {
    mutating func replaceOrAppend<Value>(_ item: Element,
                                         firstMatchingKeyPath keyPath: KeyPath<Element, Value>)
    where Value: Equatable
    {
        let itemValue = item[keyPath: keyPath]
        replaceOrAppend(item, whereFirstIndex: { $0[keyPath: keyPath] == itemValue })
    }
    
    mutating func replaceOrAppend(_ item: Element, whereFirstIndex predicate: (Element) -> Bool) {
        if let idx = self.firstIndex(where: predicate){
            self[idx] = item
        } else {
            append(item)
        }
    }
}
