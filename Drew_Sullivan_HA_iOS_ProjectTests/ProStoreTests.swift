//
//  ProStoreTests.swift
//  Drew_Sullivan_HA_iOS_ProjectTests
//
//  Created by Drew Sullivan on 12/29/18.
//  Copyright © 2018 Drew Sullivan. All rights reserved.
//

import XCTest

@testable import Drew_Sullivan_HA_iOS_Project

class ProStoreTests: XCTestCase {
    
    var sut: ProStore!

    override func setUp() {
        super.setUp()
        
        sut = ProStore()
    }

    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testNumProsTotal() {
        XCTAssert(sut.numProsTotal > 0, "ProStore not set")
    }
    
    func testProsAreBrokenIntoGroupsBySpecialty() {
        let groups = sut.specialtyGroups
        for group in groups {
            for pro in group.prosWithSpecialty {
                XCTAssertTrue(group.specialtyName == pro.specialty, "Pro is in incorrect group")
            }
        }
    }
    
    func testThereAreNoEmptyGoups() {
        let groups = sut.specialtyGroups
        for group in groups {
            XCTAssertTrue(group.prosWithSpecialty.count > 0, "Pros list is unpopulated")
        }
    }
    
    func testAllProsIsEqualToNumTotalPros() {
        XCTAssertEqual(sut.allPros.count, sut.numProsTotal)
    }
}
