//
//  UserApiTests.swift
//  gitHubProfileProjectTests
//
//  Created by Kailash Jangir on 22/02/22.
//

import XCTest
@testable import gitHubProfileProject


class UserApiTests: XCTestCase {
    
    func test_user_api_with_empty_userName(){
        let repositry = FetchUserRepository()
        let expectation = self.expectation(description: "api_with_empty_userName")
        var statusCheck = true
        
        repositry.getUserData(user: "") { (status, data, error) in
            XCTAssertNil(data)
            statusCheck = status
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
        XCTAssertFalse(statusCheck)
    }
    
    func test_user_api_with_incorrect_userName(){
        let repositry = FetchUserRepository()
        let expectation = self.expectation(description: "api_with_incorrect_userName")
        var statusCheck = true
        
        repositry.getUserData(user: "jdfjSajhfbdj") { (status, data, error) in
            XCTAssertNil(data)
            statusCheck = status
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
        XCTAssertFalse(statusCheck)
    }
    
    func test_user_api_with_correct_userName(){
        let repositry = FetchUserRepository()
        let expectation = self.expectation(description: "api_with_correct_userName")
        var statusCheck = false
        
        repositry.getUserData(user: "greenrobot") { (status, data, error) in
            XCTAssertNotNil(data)
            statusCheck = status
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
        XCTAssertTrue(statusCheck)
    }
   
    
}