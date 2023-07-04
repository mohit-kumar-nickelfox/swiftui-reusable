//
//  Vaildation.swift
//  swiftui-reusable
//
//  Created by Mohit Kumar Singh on 29/06/23.
//

import Foundation

class Validation {
    
    static let phonePattern = #"(?=^.{7,}$)(?=^.*[A-Z].*$)(?=^.*\d.*$).*"#
    
    static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    

    static func isValid(password: String) -> Bool {
        return password.count >= 5
//        return password.range(
//            of: Validation.phonePattern,
//            options: .regularExpression
//        ) != nil
    }
}

extension String {
    var isValidPhone: Bool {
        let character  = NSCharacterSet(charactersIn: "+0123456789").inverted
        var filtered: String!
        let inputString = self.components(separatedBy: character)
        filtered = inputString.joined(separator: "")
        return  self == filtered && self.count >= 10
    }
}
