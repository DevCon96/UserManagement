//
//  File.swift
//  
//
//  Created by Connor Jones on 28/06/2022.
//

import Foundation

enum UserState {
    // Status of open and closed
    //  o registered and loggedIn == open
    case registered
    case loggedIn
    case loggedOut
    case closed
    case unknown // Unset or not yet defined
}

class User {
    // MARK: Need these properties
    private var _username: String
    var isUserLocked: Bool = false
    
    var username: String {
        get {
            return isUserLocked ? _username.obsfucate() : _username
        }
    }
    
    private var password: String
    public var emailAddress: String
    private let _uuid: UUID
    
    var status: UserState = .unknown
    
    var delegate: EditUserDelegate?
    
    init(email: String, username: String, password: String) {
        self._username = username
        self.password = password
        self.emailAddress = email
        self._uuid = UUID()
    }
    
    // Public User class interface
    
    // This should be moved the UserManager
    
//    // Logging in and out of a user
//    public func login(with password: String) throws {
//        if password == self.password {
//            self.status = .loggedIn
//            self.isUserLocked = false
//            return
//        }
//
//        logout()
//        throw LoginError.passwordIncorrect
//    }
//
//    public func logout() {
//        self.isUserLocked = true
//        self.status = .loggedOut
//    }
//
    // MARK: Change user details
    @discardableResult
    public func changeUsername(to newUsername: String) -> Bool {
        if isPotentialUsernameValid(newUsername) {
            self._username = newUsername
            log("Username successfully changed")
            return true
        }
        
        return false
    }
    
    @discardableResult
    public func changePassword(to newPassword: String) -> Bool {
        if isPotentialPasswordValid(newPassword) {
            self.password = newPassword
            delegate?.passwordChanged(for: self)
            log("Password successfully changed")
            return true
        }
        
        return false
    }
    
    public func matchPassword(_ password: String) -> Bool {
        return password == self.password ? true : false
    }
    
    public func changeEmailAdress(to newEmailAddress: String) {
        self.emailAddress = newEmailAddress
        delegate?.passwordChanged(for: self)
        log("Username successfully changed")
    }
    
    // Public helpers
    public func uuid() -> UUID? {
        guard !isUserLocked else { return nil }
        
        return _uuid
    }
    
    // Private helpers
    
    // MARK: Check the new user details pass the validity tests
    private func isPotentialUsernameValid(_ newUsername: String) -> Bool {
        return newUsername.containsLowercaseLetter() && newUsername.containsUppercaseLetter() && newUsername.containsNumber()
    }
    
    // *
    private func isUsernameAlreadyInUse(_ newUsername: String) -> Bool {
        return false
    }
    
    private func isPotentialPasswordValid(_ newPassword: String) -> Bool {
        // TODO: newPassword.rangeOfCharacter(from: CharacterSet.capitalizedLetters) returning nil regardless of whether capitalised letters are in
        return newPassword.containsLowercaseLetter() && newPassword.containsUppercaseLetter() && newPassword.containsNumber() && newPassword.containsSpecialCharacter()
    }
}

// TODO: Implement password encryption *
// TODO: Check usernames already in use before setting

