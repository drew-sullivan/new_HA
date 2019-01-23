//
//  ProsTableViewControllerTests.swift
//  Drew_Sullivan_HA_iOS_ProjectTests
//
//  Created by Drew Sullivan on 12/29/18.
//  Copyright © 2018 Drew Sullivan. All rights reserved.
//

import Foundation
import XCTest

@testable import Drew_Sullivan_HA_iOS_Project

class ProsTableViewControllerTests: XCTestCase {

    let storyboardName = "Main"
    let vcIdentifier = "prosTableViewController"
    var sut: ProsTableViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: vcIdentifier) as? ProsTableViewController
        let proStore = ProStore()
        sut.proStore = proStore
    }

    override func tearDown() {
        sut.proStore = nil
        
        super.tearDown()
    }

    func testCellForRowAt() {
        XCTAssertNotNil(sut.view, "Problem initializing view")
        sut.viewDidLoad()
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! ProTableViewCell
        XCTAssertNotNil(cell, "Cell is nil")
    }
    
    func testSegueToDetailsVC() {
        let detailsVCIdentifier = "proDetailsSegue"
        let destination = ProDetailsViewController()
        let segue = UIStoryboardSegue(identifier: detailsVCIdentifier, source: sut, destination: destination)
        sut.prepare(for: segue, sender: sut)
        XCTAssertNotNil(destination, "Destination view controller is nil")
    }
    
    func testSectionsAreSortedByCompanyName() {
        sut.proStore.sortProsWithinSpecialtyGroups(by: .companyName)
        let groups = sut.proStore.specialtyGroups
        for group in groups {
            let pros = group.prosWithSpecialty
            for i in 1..<pros.count {
                let lhsProName = pros[i - 1].companyName
                let rhsProName = pros[i].companyName
                XCTAssertTrue(lhsProName < rhsProName, "Pros are not sorted alphabetically by company name")
            }
        }
    }
    
    func testSectionsAreSortedByRating() {
        sut.proStore.sortProsWithinSpecialtyGroups(by: .rating)
        let groups = sut.proStore.specialtyGroups
        for group in groups {
            let pros = group.prosWithSpecialty
            for i in 1..<pros.count {
                let lhsProRating = Double(pros[i - 1].compositeRating) ?? 0.0
                let rhsProRating = Double(pros[i].compositeRating) ?? 0.0
                XCTAssertTrue(lhsProRating >= rhsProRating, "Pros are not sorted by rating (high to low)")
            }
        }
    }
    
    func testSectionsAreSortedByNumberOfRatings() {
        sut.proStore.sortProsWithinSpecialtyGroups(by: .rating)
        let groups = sut.proStore.specialtyGroups
        for group in groups {
            let pros = group.prosWithSpecialty
            for i in 1..<pros.count {
                let lhsProNumRatings = Int(pros[i - 1].compositeRating) ?? 0
                let rhsProNumRatings = Int(pros[i].compositeRating) ?? 0
                XCTAssertTrue(lhsProNumRatings >= rhsProNumRatings, "Pros are not sorted by number of ratings (high to low)")
            }
        }
    }
    
}
