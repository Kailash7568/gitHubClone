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
        XCTAssertEqual(Utils.short(4598), "4.5K")
    }
    
    func testShortNumberBetweenTenThousandToOneMillion(){
        XCTAssertEqual(Utils.short(234567), "234K")
    }
    
    func testShortNumberBetweenOneMillionToTenMillion(){
        XCTAssertEqual( Utils.short(4567899), "4.5M")
    }
    
    func testShortNumberAboveTenMillion(){
        XCTAssertEqual(Utils.short(67898765), "67M")
    }
    
    //MARK: testing date difference fxn
//    func testDifferneceForYears(){
//        XCTAssertEqual(Utils.dateDifference(repoDate: "2018-02-03T05:12:30Z"), "Updated 4 years ago")
//    }
//    func testDifferneceForMonths(){
//        XCTAssertEqual(Utils.dateDifference(repoDate: "2021-09-03T05:12:30Z"), "Updated 5 months ago")
//    }
//    func testDifferneceForDays(){
//        XCTAssertEqual(Utils.dateDifference(repoDate: "2022-02-20T05:12:30Z"), "Updated 3 days ago")
//    }
//    func testDifferneceForHours(){
//        XCTAssertEqual(Utils.dateDifference(repoDate: "2022-02-23T10:00:00Z"), "Updated 1 hour ago")
//    }
//    func testDifferneceForMinutes(){
//        XCTAssertEqual(Utils.dateDifference(repoDate: "2022-02-23T09:30:00Z"), "Updated 2 minutes ago")
//    }
    

}
