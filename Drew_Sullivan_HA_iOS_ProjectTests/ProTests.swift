//
//  Drew_Sullivan_HA_iOS_ProjectTests.swift
//  Drew_Sullivan_HA_iOS_ProjectTests
//
//  Created by Drew Sullivan on 12/27/18.
//  Copyright © 2018 Drew Sullivan. All rights reserved.
//

import XCTest

@testable import Drew_Sullivan_HA_iOS_Project

class ProTests: XCTestCase {
    
    var pro: Pro!
    
    override func setUp() {
        super.setUp()
        
        pro = Pro(entityId: "FakeID",
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

}
