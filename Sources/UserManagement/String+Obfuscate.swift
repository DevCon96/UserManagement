//
//  String+Obsfucate.swift
//  
//
//  Created by Connor Jones on 28/06/2022.
//

import Foundation

extension String {
    func obsfucate() -> String {
        var shouldInclude: Bool = true
        var obsfucatedString = ""
        self.forEach {
            if shouldInclude {
                obsfucatedString.append(contentsOf: "\($0)")
            } else {
                obsfucatedString.append(contentsOf: "x")
            }
            
            shouldInclude.toggle()
        }
        
        return obsfucatedString
        
    }
    
    // String contains X methods
    
    func containsUppercaseLetter() -> Bool {
        let capitalLetterPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
        return capitalLetterPredicate.evaluate(with: self)
    }
    
    func containsLowercaseLetter() -> Bool {
        let lowercaseLetterPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*")
        return lowercaseLetterPredicate.evaluate(with: self)
    }
    
    func containsNumber() -> Bool {
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*")
        return numberPredicate.evaluate(with: self)
    }
    
    func containsSpecialCharacter() -> Bool {
        let specialCharacterPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[!&^%$#@()/]+.*")
        return specialCharacterPredicate.evaluate(with: self)
    }
}
