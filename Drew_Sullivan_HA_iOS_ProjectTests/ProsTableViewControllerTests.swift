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
    var vc: ProsTableViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: vcIdentifier) as? ProsTableViewController
        let proStore = ProStore.shared
        vc.proStore = proStore
    }

    override func tearDown() {
        vc.proStore = nil
        
        super.tearDown()
    }
    
    func testNumberOfRowsInSection() {
        let numPros = vc.proStore.numPros
        XCTAssert(numPros == vc.tableView(vc.tableView, numberOfRowsInSection: 0), "Number of rows in ProStore does not match number or rows in TableView")
    }

    func testCellForRowAt() {
        XCTAssertNotNil(vc.view, "Problem initializing view")
        vc.viewDidLoad()
        let cell = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! ProTableViewCell
        XCTAssertNotNil(cell, "Cell is nil")
    }
    
    func testSegueToDetailsVC() {
        let detailsVCIdentifier = "proDetailsSegue"
        let destination = ProDetailsViewController()
        let segue = UIStoryboardSegue(identifier: detailsVCIdentifier, source: vc, destination: destination)
        vc.prepare(for: segue, sender: vc)
        XCTAssertNotNil(destination, "Destination view controller is nil")
    }
}
