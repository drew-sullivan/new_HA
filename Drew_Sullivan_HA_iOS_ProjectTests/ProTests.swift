//
//  Drew_Sullivan_HA_iOS_ProjectTests.swift
//  Drew_Sullivan_HA_iOS_ProjectTests
//
//  Created by Drew Sullivan on 12/27/18.
//  Copyright © 2018 Drew Sullivan. All rights reserved.
//

import XCTest

@testable import Drew_Sullivan_HA_iOS_Project

class Drew_Sullivan_HA_iOS_ProjectTests: XCTestCase {
    
    var pro: Pro!
    
    override func setUp() {
        super.setUp()
        
        let proStore = ProStore.shared
        pro = proStore.pro(forIndex: 0)
    }

    override func tearDown() {
        pro = nil
        
        super.tearDown()
    }
    
    func testRatingInformationSetCorrectly() {
        let numRatingsNotANumber = "three"
        pro.ratingCount = numRatingsNotANumber
        XCTAssert(pro.ratingInformation == "References Available", "Pro's rating count is not a number and cannot be converted to an int")
        
        let sampleCompositeRating = "3.5"
        let numRatingsAsANumber = "3"
        pro.compositeRating = sampleCompositeRating
        pro.ratingCount = numRatingsAsANumber
        XCTAssert(pro.ratingInformation == "Ratings: 3.5 | 3 rating(s)")
    }
    
    func testServiceInformationSetCorrectly() {
        pro.servicesOffered = nil
        XCTAssert(pro.serviceInformation == "Services Not Available", "Pro's services offered is nil and should read 'Services Not Available'")
        
        let populatedService = "Any service"
        pro.servicesOffered = populatedService
        XCTAssert(pro.serviceInformation == populatedService)
    }

    func testRatingInfoColorSetProperly() {
        let rating4AndAbove = "4.0"
        pro.compositeRating = rating4AndAbove
        XCTAssert(pro.ratingInfoColor == UIColor.green, "Color should be green")
        
        let rating3AndAbove = "3.0"
        pro.compositeRating = rating3AndAbove
        XCTAssert(pro.ratingInfoColor == UIColor.orange, "Color should be orange")
        
        let ratingUnder3 = "2.9"
        pro.compositeRating = ratingUnder3
        XCTAssert(pro.ratingInfoColor == UIColor.red, "Color should be red")
        
        let rating0 = "0.0"
        pro.compositeRating = rating0
        XCTAssert(pro.ratingInfoColor == UIColor.black, "Color should be black")
        
        let ratingNotANumber = "Not a number"
        pro.compositeRating = ratingNotANumber
        XCTAssert(pro.ratingInfoColor == UIColor.black, "Color should be black")
    }

}
