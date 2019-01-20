//
//  Drew_Sullivan_HA_iOS_ProjectUITests.swift
//  Drew_Sullivan_HA_iOS_ProjectUITests
//
//  Created by Drew Sullivan on 12/29/18.
//  Copyright © 2018 Drew Sullivan. All rights reserved.
//

import XCTest

class Drew_Sullivan_HA_iOS_ProjectUITests: XCTestCase {
    
    let tableName = "prosTable"
    var app: XCUIApplication!
    var table: XCUIElement!

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
        app = XCUIApplication()
        table = app.tables[tableName]
    }

    override func tearDown() {
        table = nil
        app = nil

        super.tearDown()
    }
    
    func testRowClickToDetailView() {
        table.cells/*@START_MENU_TOKEN@*/.staticTexts["AAA Service Plumbing, Inc."]/*[[".cells.staticTexts[\"AAA Service Plumbing, Inc.\"]",".staticTexts[\"AAA Service Plumbing, Inc.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Details"].buttons["Pros"].tap()
    }
    
    func testCallButtonTap() {
        table.cells/*@START_MENU_TOKEN@*/.staticTexts["AAA Service Plumbing, Inc."]/*[[".cells.staticTexts[\"AAA Service Plumbing, Inc.\"]",".staticTexts[\"AAA Service Plumbing, Inc.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["CALL"].tap()
        app.navigationBars["Details"].buttons["Pros"].tap()
    }
    
    func testEmailButtonTap() {
        table.cells/*@START_MENU_TOKEN@*/.staticTexts["AAA Service Plumbing, Inc."]/*[[".cells.staticTexts[\"AAA Service Plumbing, Inc.\"]",".staticTexts[\"AAA Service Plumbing, Inc.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["EMAIL"].tap()
        app.navigationBars["Details"].buttons["Pros"].tap()
    }
    
    func testSortingButtonClickToCompanyNameIsValid() {
        app.navigationBars["Pros"].buttons["Sort by..."].tap()
        app.sheets["Sort by..."].buttons["Company Name"].tap()
    }
    
    func testSortingButtonClickToRatingIsValid() {
        app.navigationBars["Pros"].buttons["Sort by..."].tap()
        app.sheets["Sort by..."].buttons["Rating"].tap()
    }
    
    func testSortingButtonClickToNumRatingsIsValid() {
        app.navigationBars["Pros"].buttons["Sort by..."].tap()
        app.sheets["Sort by..."].buttons["Number of Ratings"].tap()
    }
    
    func testSearchingTriggersSearchBar() {
        app.searchFields["Search for a Pro"].tap()
        app.buttons["Cancel"].tap()
    }

}
