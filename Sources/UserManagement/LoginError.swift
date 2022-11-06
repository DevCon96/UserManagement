//
//  File.swift
//  
//
//  Created by Connor Jones on 28/06/2022.
//

import Foundation

public enum LoginError: Error {
    case passwordIncorrect
    case usernameNotRecognised
    case userNotFound
    case userBaseEmpty
    
    var description: String {
        switch self {
        case .passwordIncorrect: return "The password that was entered was incorrect"
        case .usernameNotRecognised: return "The username that was entered was not recognised"
        case .userNotFound: return "The user has not been found"
        case .userBaseEmpty: return "There are currently no users in the user base"
        }
    }
}
