//
//  UserTests.swift
//  
//
//  Created by Connor Jones on 28/06/2022.
//

import XCTest
@testable import UserManagement

class UserTests: XCTestCase {
    internal let newUserDetails: [String : String] = [
        "username" : "DevCon96Tests",
        "password" : "Password1",
        "email" : "devcon96tests@email.com"
    ]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Test basic class functionality
    func testUserCreationSucces() throws {
        // Given
  
        // When
        let newUser = User(email: newUserDetails["email"] ?? "Unknown", username: newUserDetails["username"] ?? "Unknown", password: newUserDetails["password"] ?? "Unknown")
        
        // Then
        
        XCTAssertEqual(newUser.username, newUserDetails["username"]!, "Username was not set correctly")
    }
    
    // Test changing user details functionality
    func testChangingUsernameValidationPassed() throws {
        // Given
        let newUser = User(email: newUserDetails["email"] ?? "Unknown", username: newUserDetails["username"] ?? "Unknown", password: newUserDetails["password"] ?? "Unknown")
        // When
        let result = newUser.changeUsername(to: "N3wUsern4me")
        // Then
        XCTAssertTrue(result, "Changing username correctly passed validation")
    }
    
    func testChangingUsernameValidationFailed() throws {
        // Given
        let newUser = User(email: newUserDetails["email"] ?? "Unknown", username: newUserDetails["username"] ?? "Unknown", password: newUserDetails["password"] ?? "Unknown")
        
        // When
        let result = newUser.changeUsername(to: "NewUsername") // No number. Should fail validation
        
        // Then
        XCTAssertFalse(result, "Changing username incorrectly passed validation")
    }
    
    func testChangingPasswordValidationPassed() throws {
        // Given
        let newUser = User(email: newUserDetails["email"] ?? "Unknown", username: newUserDetails["username"] ?? "Unknown", password: newUserDetails["password"] ?? "Unknown")
        
        // When
        let result = newUser.changePassword(to: "NewPassword1!")
        
        // Then
        XCTAssertTrue(result, "Changing password inccorectly passed validation")
    }
    
    func testChangingPasswordValidationFailed() throws {
        // Given
        let newUser = User(email: newUserDetails["email"] ?? "Unknown", username: newUserDetails["username"] ?? "Unknown", password: newUserDetails["password"] ?? "Unknown")
        
        // When
        let result = newUser.changePassword(to: "NewPassword")
        
        // Then
        XCTAssertFalse(result, "Changing password inccorectly passed validation")
    }
    
    func testMatchPassword() throws {
        // Given && When
        let newUser = User(email:
                            newUserDetails["email"]!,
                           username: newUserDetails["username"]!,
                           password: newUserDetails["password"]!)
        // Then
        XCTAssertTrue(newUser.matchPassword(newUserDetails["password"]!))
    }
}
