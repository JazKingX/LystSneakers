//
//  NotificationMock.swift
//  LystSneakers
//
//  Created by Jaz King on 09/08/2017.
//  Copyright © 2017 Jaz King. All rights reserved.
//

import XCTest
@testable import LystSneakers

class NotificationMock: XCTestCase {
    
    var mockNotificationManager: MockNotificationManager!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockNotificationManager = MockNotificationManager()
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
    
    //Test notification
    
    func testDidSetNotification() {
        
        mockNotificationCenter.setNotificationIn5("Test", type: "Type")
        
        XCTAssertTrue(mockNotificationManager.didRecieveNotification, "Product notification did not post")
        
        //XCTAssertFalse(mockNotificationCenter.didRecieveNotification)
    }
    
    //Mock Notification
    class MockNotificationManager: NotificationManager {
        
        var didRecieveNotification = false
        
        override func setNotificationIn5(_ name: String, type: String) {
            if name == "Test" {
                didRecieveNotification = true
            }
        }
    }
}
