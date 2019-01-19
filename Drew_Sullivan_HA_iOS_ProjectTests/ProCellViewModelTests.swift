//
//  ProCellViewModelTests.swift
//  Drew_Sullivan_HA_iOS_ProjectTests
//
//  Created by Drew Sullivan on 1/19/19.
//  Copyright © 2019 Drew Sullivan. All rights reserved.
//

import XCTest

@testable import Drew_Sullivan_HA_iOS_Project

class ProCellViewModelTests: XCTestCase {

    var proCellViewModel: ProCellViewModel!
    
    override func setUp() {
        super.setUp()
        
        let pro = Pro(entityId: "FakeID",
                  companyName: "Fake Company Name",
                  ratingCount: "6",
                  compositeRating: "4.24",
                  companyOverview: "Fake overview",
                  canadianSP: true,
                  spanishSpeaking: true,
                  phoneNumber: "1234567890",
                  latitude: nil,
                  longitude: nil,
                  servicesOffered: nil,
                  specialty: "Plumbing",
                  primaryLocation: "Golden, CO",
                  email: "biz@fakecompany.com")
        proCellViewModel = ProCellViewModel(pro: pro)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test() {
        
    }
    
    func testRatingInfoColorSetProperly() {
        let rating4AndAbove = "4.0"
        proCellViewModel.pro.compositeRating = rating4AndAbove
        XCTAssert(proCellViewModel.ratingInfoColor == UIColor.green, "Color should be green")
        
        let rating3AndAbove = "3.0"
        proCellViewModel.pro.compositeRating = rating3AndAbove
        XCTAssert(proCellViewModel.ratingInfoColor == UIColor.orange, "Color should be orange")
        
        let ratingUnder3 = "2.9"
        proCellViewModel.pro.compositeRating = ratingUnder3
        XCTAssert(proCellViewModel.ratingInfoColor == UIColor.red, "Color should be red")
        
        let rating0 = "0.0"
        proCellViewModel.pro.compositeRating = rating0
        XCTAssert(proCellViewModel.ratingInfoColor == UIColor.black, "Color should be black")
        
        let ratingNotANumber = "Not a number"
        proCellViewModel.pro.compositeRating = ratingNotANumber
        XCTAssert(proCellViewModel.ratingInfoColor == UIColor.black, "Color should be black")
    }

}
