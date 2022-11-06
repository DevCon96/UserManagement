//
//  UserManager.swift
//  
//
//  Created by Connor Jones on 02/11/2022.
//

import Foundation

/* This should only ever be a used as a singleton */
public class UserManager: NSObject, EditUserDelegate {
    public var currentUser: User?
    private var userbase: [UUID : User] = [:] // TODO: Store this in a DB no on the manager
    
    public func login(email: String, password: String) throws {
        guard !userbase.isEmpty else { throw LoginError.userBaseEmpty }
        
        for (_, user) in userbase {
            if user.emailAddress == email && user.matchPassword(password) {
                currentUser = user
                return
            }
        }
        
        throw LoginError.userNotFound
    }
    
    public func logout() throws {
        guard currentUser != nil else { throw LoginError.userNotFound }
        currentUser = nil
    }
    
    public func createNewUser(email: String, userName: String, password: String) -> User {
        // TODO: save user into Core Data.
        // TODO: STRETCH GOAL - Send user to server for remote saving.
        let newUser = User(email: email, username: userName, password: password)
        newUser.delegate = self
        
        if let uuid = newUser.uuid() {
            userbase[uuid] = newUser
        }
        
        return newUser
    }
    
    public func removeUser(uuid: UUID) {
        userbase.removeValue(forKey: uuid)
    }
    
    public func getUser(username: String?, password: String?, uuid: UUID? = nil) throws -> User {
        guard let password else { throw LoginError.passwordIncorrect }
        if let uuid, let user = userbase[uuid], user.matchPassword(password) {
            return user
        }
        
        if let username {
            for (_, user) in userbase {
                if user.username == username { return user }
            }
        }
        
        throw LoginError.userNotFound
    }
    
    // Conform to EditUserDelegate
    public func userNameChanged(for user: User) {
        updateUser(user)
    }
    
    public func passwordChanged(for user: User) {
        updateUser(user)
    }
    
    // Private helpers
    private func updateUser(_ user: User) {
        if currentUser?.uuid() == user.uuid(), checkIfCurrentUser(user) {
            currentUser = user
        }
        
        for (uuid, storedUser) in userbase {
            if user.uuid() == storedUser.uuid() {
                userbase[uuid] = user
            }
        }
    }
    
    private func checkIfCurrentUser(_ user: User) -> Bool {
        guard user.uuid() != nil else {
            log("Editting user is locked")
            return false
        }
        
        return true
    }
        
}

public protocol EditUserDelegate {
    func userNameChanged(for user: User)
    func passwordChanged(for user: User)
}
