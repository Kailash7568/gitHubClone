//
//  UtilTests.swift
//  gitHubProfileProjectTests
//
//  Created by Kailash Jangir on 22/02/22.
//

import XCTest
@testable import gitHubProfileProject

class UtilTests: XCTestCase {
    
    //MARK: testing short function
    func testShortNumberBetweenThousandToTenThousand(){
        XCTAssertEqual(Utilities.short(4598), "4.5K")
    }
    
    func testShortNumberBetweenTenThousandToOneMillion(){
        XCTAssertEqual(Utilities.short(234567), "234K")
    }
    
    func testShortNumberBetweenOneMillionToTenMillion(){
        XCTAssertEqual( Utilities.short(4567899), "4.5M")
    }
    
    func testShortNumberAboveTenMillion(){
        XCTAssertEqual(Utilities.short(67898765), "67M")
    }
    
    //MARK: testing date difference fxn
    func testDifferneceForYears(){
        XCTAssertEqual(Utilities.dateDifference(repoDate: "2018-02-03T05:12:30Z"), "Updated 4 years ago")
    }
    func testDifferneceForMonths(){
        XCTAssertEqual(Utilities.dateDifference(repoDate: "2021-09-03T05:12:30Z"), "Updated 5 months ago")
    }
    func testDifferneceForDays(){
        XCTAssertEqual(Utilities.dateDifference(repoDate: "2022-02-20T05:12:30Z"), "Updated 2 days ago")
    }
    func testDifferneceForHours(){
        XCTAssertEqual(Utilities.dateDifference(repoDate: "2022-02-22T12:00:00Z"), "Updated 9 hours ago")
    }
    func testDifferneceForMinutes(){
        XCTAssertEqual(Utilities.dateDifference(repoDate: "2022-02-22T21:12:00Z"), "Updated 3 minutes ago")
    }
    

}
