//
//  CorrectRepoInfoTests.swift
//  gitHubProfileProjectTests
//
//  Created by Kailash Jangir on 25/02/22.
//

import XCTest
@testable import gitHubProfileProject

class CorrectRepoInfoTests: XCTestCase, GitUserProfileDelegate {
    
    var viewModel : GitUserProfileViewModel!
    var expectation : XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        let repository = FakeFetchUserRepository("CorrectRepoInfo")
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
        viewModel.getRepoData(user: "Vipinhelloindia")
        waitForExpectations(timeout: 15)
    }
    
    
    func didFinishFetchingUserData() {
        
    }
    
    func didNotFetchUserData() {
        
    }
    
    func didFinishFetchingRepoData() {
        XCTAssertNotNil(viewModel.repoData)
        self.expectation.fulfill()
    }
    
    func didNotFetchRepoData() {
        
    }
    
}



class IncorrectRepoInfoTests: XCTestCase, GitUserProfileDelegate {
    
    
    var viewModel : GitUserProfileViewModel!
    var expectation : XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        let repository = FakeFetchUserRepository("IncorrectRepoInfo")
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
        viewModel.getRepoData(user: "Vipinhelloindia")
        waitForExpectations(timeout: 15)
    }
    
    
    func didFinishFetchingUserData() {
        
    }
    
    func didNotFetchUserData() {
        
    }
    
    func didFinishFetchingRepoData() {
        
    }
    
    func didNotFetchRepoData() {
        XCTAssertNotNil(viewModel.repoData)
        self.expectation.fulfill()
    }
    
}

