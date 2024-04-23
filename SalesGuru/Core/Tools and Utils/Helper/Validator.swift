import UIKit

public struct Validator {

   public let closure: (String) -> Bool

    public init(validation: @escaping (String) -> Bool) {
        self.closure = validation
    }

    public func validate(value: String?) -> Bool {
        return closure(value ?? "")
    }
}

public extension Validator {
    
    static var website: Validator {
        return Validator {value in
            let websiteRegex = "^(https?://)?([a-zA-Z0-9.-]+)\\.([a-zA-Z]{2,})(/[a-zA-Z0-9-._?&=]*)?$"
            
            let textRange = NSRange(location: 0, length: value.utf16.count)
            if let match = try? NSRegularExpression(pattern: websiteRegex, options: .caseInsensitive).firstMatch(in: value, options: [], range: textRange) {
                return match.range == textRange
            }
            
            return false
        }
    }
    static var maxLenght: Validator {
        return Validator { value in
            return value.count <= 255
        }
    }

    static var notEmpty: Validator {
        return Validator { value in
            return !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty 
        }
    }

    static var text: Validator {
        return Validator { value in
            return value.count <= 255 && value.count > 0
        }
    }
    
    static var fullName: Validator {
        return Validator { value in
            return value.count <= 50 && value.count > 0
        }
    }

    static var email: Validator {
        return Validator { value in
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,5}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: value)
        }
    }
    
    static var phone: Validator {
        return Validator { value in
            let phoneRegEx = #"^\+\d{1,4}\s?\d{6,14}$"#
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
            return phoneTest.evaluate(with: value)
        }
    }
    
    static func textLimit(min: Int, max: Int?) -> Validator {
         return Validator { value in
             return value.count >= min && (max != nil ? value.count <= max! : true)
         }
     }
}


