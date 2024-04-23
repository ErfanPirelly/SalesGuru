//
//  String.swift
//  Pirelly
//
//  Created by shndrs on 6/17/23.
//

import Foundation

extension String {
    
    var isZero: Bool {
        return self == "0" ? true : false
    }
    
    var colon: String {
        self + ":"
    }
    
    var timerize: String {
        if self.count == 1 {
            return "0" + self
        } else {
            return self
        }
    }
    
    func keepOnlyDigits(isHexadecimal: Bool) -> String {
        let ucString = self.uppercased()
        let validCharacters = isHexadecimal ? "+0123456789ABCDEF" : "+0123456789"
        let characterSet: CharacterSet = CharacterSet(charactersIn: validCharacters)
        let stringArray = ucString.components(separatedBy: characterSet.inverted)
        let allNumbers = stringArray.joined(separator: "")
        return allNumbers
    }
    
    var unknownError: String {
        let temp: String? = self
        if temp == nil || temp == "" {
            return "Unknown Error! :("
        } else {
            return self
        }
    }
    
    static var unknownError: String {
        return "Unknown Error! :("
    }
    
    var currency: String {
        return self + " $"
    }
    
    func inserting(separator: String, every n: Int) -> String {
        var result: String = ""
        let characters = Array(self)
        stride(from: 0, to: characters.count, by: n).forEach {
            result += String(characters[$0..<min($0+n, characters.count)])
            if $0+n < characters.count {
                result += separator
            }
        }
        return result
    }
    
    var trailingSpacesTrimmed: String {
        var newString = self
        while newString.last?.isWhitespace == true {
            newString = String(newString.dropLast())
        }
        return newString
    }
    
}

extension String? {
    
    var empty: String {
        return self ?? ""
    }
    
    var dashPlaceholder: String {
        return self ?? "----"
    }
    
}
