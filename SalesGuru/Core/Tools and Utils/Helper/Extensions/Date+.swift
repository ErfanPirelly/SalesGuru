//
//  Date+.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/31/24.
//

import Foundation

extension Date {
    func toFormattedString(format: String = "HH:mm, EEEE") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func dayChangeDateFormatter() -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = .init(secondsFromGMT: 0)
        if calendar.isDateInToday(self) {
            dateFormatter.dateFormat = "hh:mm a".capitalized
            
        } else if let oneWeekAgo = calendar.date(byAdding: .weekOfYear, value: -1, to: Date()), self > oneWeekAgo {
            dateFormatter.dateFormat = "hh:mm a, EEEE"
            
        } else if calendar.isDate(self, equalTo: Date(), toGranularity: .year) {
            dateFormatter.dateFormat = "HH:mm, MMM dd"
            
        } else {
            dateFormatter.dateFormat = "MMM dd, yyyy"
        }
        
        return dateFormatter.string(from: self)
    }
    
    
    func conversationDateFormatter() -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = .init(secondsFromGMT: 0)
        
        if calendar.isDateInToday(self) {
            dateFormatter.dateFormat = "hh:mm a"
            
        } else if let oneWeekAgo = calendar.date(byAdding: .weekOfYear, value: -1, to: Date()), self > oneWeekAgo {
            dateFormatter.dateFormat = "hh:mm a, EE"
            
        } else if calendar.isDate(self, equalTo: Date(), toGranularity: .year) {
            dateFormatter.dateFormat = "HH:mm, MMM dd"
            
        } else {
            dateFormatter.dateFormat = "MMM dd, yyyy"
        }
        
        return dateFormatter.string(from: self)
    }
    
    
}
