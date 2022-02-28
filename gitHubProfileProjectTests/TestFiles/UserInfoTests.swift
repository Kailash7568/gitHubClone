//
//  CorrectUserInfoTests.swift
//  gitHubProfileProjectTests
//
//  Created by Kailash Jangir on 24/02/22.
//

import XCTest
@testable import gitHubProfileProject

class CorrectUserInfoTests: XCTestCase, GitUserProfileDelegate {
   
    var viewModel : GitUserProfileViewModel!
    var expectation : XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        let repository = FakeFetchUserRepository("CorrectUserInfo")
        viewModel = GitUserProfileViewModel(repositry: repository)
        viewModel.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    //MARK: test for valid user info
    func testUserApiWithCorrectUserInfo(){
        expectation = self.expectation(description: "Waiting for the CorrectUserInfoTests call to complete.")
        viewModel.getUserData(user: "vipinhelloindia")
        waitForExpectations(timeout: 15)
    }
    
    func didFinishFetchingUserData() {
        XCTAssertNotNil(viewModel.userData)
        XCTAssertEqual(viewModel.userInfoNumbers.count, 4)
        XCTAssertEqual(viewModel.userInfoNumbers, [67,100,11,43])
        self.expectation.fulfill()
    }
    
    func didNotFetchUserData() {
        
    }
    
    
    func didFinishFetchingRepoData() {
        
    }
    
    func didNotFetchRepoData() {

    }
    

}


class IncorrectUserInfoTests: XCTestCase, GitUserProfileDelegate {

    var viewModel : GitUserProfileViewModel!
    var expectation : XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        let repository = FakeFetchUserRepository("IncorrectUserInfo")
        viewModel = GitUserProfileViewModel(repositry: repository)
        viewModel.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    //MARK: test for valid user info
    func testUserApiWithInCorrectUserInfo(){
        expectation = self.expectation(description: "Waiting for the CorrectUserInfoTests call to complete.")
        viewModel.getUserData(user: "vipinhelloindia")
        waitForExpectations(timeout: 15)
    }
    
    func didFinishFetchingUserData() {
        
    }
    
    func didNotFetchUserData() {
        XCTAssertNil(viewModel.userData)
        XCTAssertEqual(viewModel.userInfoNumbers.count, 0)
        self.expectation.fulfill()
    }
    
    
    func didFinishFetchingRepoData() {
        
    }
    
    func didNotFetchRepoData() {
        
    }

    
}

