//
//  class+Debounce.swift
//  Pirelly
//
//  Created by mmdMoovic on 3/27/24.
//

import Foundation

extension NSObject {
    func debounce(interval: TimeInterval, queue: DispatchQueue = DispatchQueue.main, action: @escaping (() -> Void)) -> () -> Void {
        var lastFireTime = DispatchTime.now()
        let dispatchDelay = DispatchTimeInterval.milliseconds(Int(interval * 1000))
        let dispatchTime: DispatchTime = lastFireTime + dispatchDelay
        var workItem: DispatchWorkItem?
        
        return {
            workItem?.cancel()  // Cancel the previous work item
            workItem = DispatchWorkItem {
                action()
            }
            queue.asyncAfter(deadline: dispatchTime, execute: workItem!)
            lastFireTime = DispatchTime.now()
        }
    }
}
