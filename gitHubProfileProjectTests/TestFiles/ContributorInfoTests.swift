//
//  CorrectContributorInfoTests.swift
//  gitHubProfileProjectTests
//
//  Created by Kailash Jangir on 24/02/22.
//

import XCTest
@testable import gitHubProfileProject

class CorrectContributorInfoTests: XCTestCase, ContributorDelegate {
    
    var viewModel : ContributorViewModel!
    var expectation : XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        let repository = FakeFetchUserRepository("CorrectContributorInfo")
        viewModel = ContributorViewModel(repositry: repository)
        viewModel.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    //MARK: test for valid user info
    func testContributorApiWithCorrectUserInfo(){
        expectation = self.expectation(description: "Waiting for the CorrectUserInfoTests call to complete.")
        viewModel.getContributorData(user: "vipinhelloindia", repoName: "ActionBarSherlock")
        waitForExpectations(timeout: 15)
    }
    
   func didFinishFetchingContributorData() {
       XCTAssertNotNil(viewModel.contributorData)
        self.expectation.fulfill()
    }
    
    func didNotFinishFetchingContributorData() {
        
    }
    
    
       
}


class IncorrectContributorInfoTests: XCTestCase, ContributorDelegate {
    
    var viewModel : ContributorViewModel!
    var expectation : XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        let repository = FakeFetchUserRepository("IncorrectContributorInfo")
        viewModel = ContributorViewModel(repositry: repository)
        viewModel.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    //MARK: test for valid user info
    func testContributorApiWithIncorrectUserInfo(){
        expectation = self.expectation(description: "Waiting for the CorrectUserInfoTests call to complete.")
        viewModel.getContributorData(user: "vipinhelloindia", repoName: "ActionBarSherlock")
        waitForExpectations(timeout: 15)
    }
    
   func didFinishFetchingContributorData() {
       
    }
    
    func didNotFinishFetchingContributorData() {
        XCTAssertEqual(viewModel.contributorData.count, 0)
        XCTAssertTrue(viewModel.errorInfetchingContributors)
        self.expectation.fulfill()
    }
    
    
}

