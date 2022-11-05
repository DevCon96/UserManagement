//
//  UserManagerTests.swift
//  
//
//  Created by Connor Jones on 03/11/2022.
//

import Foundation
import XCTest

@testable import UserManagement

class UserManagerTests: XCTestCase {
    var testManager: UserManager = UserManager()
    
    internal let newUserDetails: [String : String] = [
        "username" : "DevCon96Tests",
        "password" : "Password1",
        "email" : "devcon96tests@email.com"
    ]
    
    // Basic user manager functionality
    func testLoginUser() throws {
        // Given
        let email: String = newUserDetails["email"]!
        let username: String = newUserDetails["username"]!
        let password: String = newUserDetails["password"]!
        
        // When
        let user = testManager.createNewUser(email: email, userName: username, password: password)
        
        // Then
        XCTAssertNoThrow(try testManager.login(email: user.emailAddress, password: password), "Logging into user failed")
    }
    
    func testLogoutUser() throws {
        // Given
        try testLoginUser()
        
        // When
        try testManager.logout()
        let _ = try testManager.getUser(username: newUserDetails["username"], password: newUserDetails["password"])
        
        // Then
        XCTAssertNil(testManager.currentUser, "Current user has not been reset. User not logged out")
        // Test that the user is not deleted.
        let _ = try testManager.getUser(username: newUserDetails["username"], password: newUserDetails["password"])
    }
    
    func testCreateUser() throws {
        // Given
        let email: String = newUserDetails["email"]!
        let username: String = newUserDetails["username"]!
        let password: String = newUserDetails["password"]!
    
        // When
        let user = testManager.createNewUser(email: email, userName: username, password: password)
        
        // Then
        XCTAssertEqual(user.username, username, "username of return user is incorrect")
        XCTAssertEqual(user.emailAddress, email, "email of return user incorrect")
        XCTAssertTrue(user.matchPassword(password), "password of return user is incorrect")
        XCTAssertNoThrow(try testManager.login(email: user.emailAddress, password: password), "Could not log new user in")
    }
    
    func testRemoveUser() throws {
        // Given
        let email: String = newUserDetails["email"]!
        let username: String = newUserDetails["username"]!
        let password: String = newUserDetails["password"]!
        let user = testManager.createNewUser(email: email, userName: username, password: password)
        guard user.uuid() != nil else { throw LoginError.userNotFound }
        
        // When
        // Then
        XCTAssertNoThrow(try testManager.login(email: email, password: password), "Remove user failed with error")
    }
    
    func testGetUser() throws {
        // Given
        let email: String = newUserDetails["email"]!
        let username: String = newUserDetails["username"]!
        let password: String = newUserDetails["password"]!
        let user = testManager.createNewUser(email: email, userName: username, password: password)
        
        // When
        let fetchedUser = try testManager.getUser(username: username, password: password, uuid: user.uuid())
        
        // Then
        XCTAssertEqual(user.username, fetchedUser.username, "User name incorrect on fetched user")
        XCTAssertEqual(user.emailAddress, fetchedUser.emailAddress, "Email address on fetched user is incorrect")
        XCTAssertEqual(user.uuid()?.uuidString
                       , fetchedUser.uuid()?.uuidString, "UUID incorrect for fetched user")
        
    }
    // Editting user details tests
    func testChangeUsername() throws {
        // Given
        let email: String = newUserDetails["email"]!
        let username: String = newUserDetails["username"]!
        let secondUsername: String = "DefJJ9013"
        let password: String = newUserDetails["password"]!
        let user = testManager.createNewUser(email: email, userName: username, password: password)
        
        // This will set the current user to the newly created user.
        try testManager.login(email: email, password: password)
        
        // When
        user.changeUsername(to: secondUsername)
        
        // Then
        // Test current user
        XCTAssertEqual(user.username, testManager.currentUser?.username ?? "", "Username not changed for current user")
        XCTAssertEqual(user.emailAddress, testManager.currentUser?.emailAddress ?? "", "Email address not changed for current user")
        XCTAssertTrue(testManager.currentUser?.matchPassword(password) ?? false, "Password does not match current logged in user")
        
        // Test stored user
        let storedUser = try testManager.getUser(username: username, password: password, uuid: user.uuid())
        XCTAssertEqual(user.username, storedUser.username, "Username does not match stored user")
        XCTAssertEqual(user.emailAddress, storedUser.emailAddress, "Email address does not match stored user")
        XCTAssertTrue(storedUser.matchPassword(password))
        
    }
    
    func testChangePassword() throws {
        // Given
        let email: String = newUserDetails["email"]!
        let username: String = newUserDetails["username"]!
        let secondPassowrd: String = "DefJJ9013!"
        let password: String = newUserDetails["password"]!
        let user = testManager.createNewUser(email: email, userName: username, password: password)
        
        // This will set the current user to the newly created user.
        try testManager.login(email: email, password: password)
        
        // When
        user.changePassword(to: secondPassowrd)
        // Then
        
        // Test current user
        XCTAssertEqual(user.username, testManager.currentUser?.username ?? "", "Username not changed for current user")
        XCTAssertEqual(user.emailAddress, testManager.currentUser?.emailAddress ?? "", "Email address not changed for current user")
        XCTAssertTrue(testManager.currentUser?.matchPassword(secondPassowrd) ?? false, "Password does not match current logged in user")
        
        // Test stored user
        let storedUser = try testManager.getUser(username: username, password: password, uuid: user.uuid())
        XCTAssertEqual(user.username, storedUser.username, "Username does not match stored user")
        XCTAssertEqual(user.emailAddress, storedUser.emailAddress, "Email address does not match stored user")
        XCTAssertTrue(storedUser.matchPassword(secondPassowrd))
    }
    
    
}
