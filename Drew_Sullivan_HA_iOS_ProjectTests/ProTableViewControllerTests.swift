//
//  ProTableViewControllerTests.swift
//  Drew_Sullivan_HA_iOS_ProjectTests
//
//  Created by Drew Sullivan on 12/29/18.
//  Copyright © 2018 Drew Sullivan. All rights reserved.
//

import XCTest

@testable import Drew_Sullivan_HA_iOS_Project

class ProTableViewControllerTests: XCTestCase {
    
    let storyboardName = "Main"
    let vcIdentifier = "proTableViewController"
    var vc: ProsTableViewController!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let proStore = ProStore()
        vc = storyboard.instantiateViewController(withIdentifier: vcIdentifier) as! ProsTableViewController
        vc.proStore = proStore
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
    }

}
