//
//  LystSneakersUITests.swift
//  LystSneakersUITests
//
//  Created by Jaz King on 13/07/2017.
//  Copyright © 2017 Jaz King. All rights reserved.
//

import XCTest

class LystSneakersUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //Test collection view has products to display
    func testProductCollectionView() {
        
        XCTAssertGreaterThan(app.collectionViews.cells.count, 0)
        
    }
    
    //Test if sort button exisits
    func testSortButton() {
        
        let sortButton = XCUIApplication().buttons["sort"]
        
        XCTAssertTrue(sortButton.exists)
        
    }
    
    //Test if filter button exisits
    func testFilterButton() {
        
        let filterButton = XCUIApplication().buttons["filter results button 4"]

        XCTAssertTrue(filterButton.exists)
        XCUIDevice.shared().orientation = .portrait
        
        
    }
}
