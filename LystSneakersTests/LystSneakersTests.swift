//
//  LystSneakersTests.swift
//  LystSneakersTests
//
//  Created by Jaz King on 13/07/2017.
//  Copyright © 2017 Jaz King. All rights reserved.
//

import XCTest
@testable import LystSneakers

class LystSneakersTests: XCTestCase {
    
    var color: ColorPicker!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        color = ColorPicker()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //Test is the default app color is the correct value used in the app
    func testAppDefaultColor() {
        
        let orange = UIColor(red:1.00, green:0.51, blue:0.46, alpha:1.0)
        
        XCTAssertEqual(color.defaultOrange, orange)
        
    }
}
