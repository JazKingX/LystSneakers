//
//  LystNetworkTests.swift
//  LystNetworkTests
//
//  Created by Jaz King on 25/07/2017.
//  Copyright © 2017 Jaz King. All rights reserved.
//

import XCTest
@testable import LystNetwork

var network: NetworkManager!

class LystNetworkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        network = NetworkManager()
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
    
    //Default gender should be set to .none
    func testDefaultGender() {
        XCTAssertEqual(network.gender, .none)
    }
    
    
    //Default String category should be nil
    func testDefaultCategory() {
        XCTAssertNil(network.category)
    }
    
    //Default URL used for fetching products for feed
    func testDefaultURLString() {
        XCTAssertEqual(network.getUrl(network.gender, category:  network.category), "https://api.lyst.com/rest_api/components/feeds/?pre_product_type=Shoes")
        
    }
    
    
    
    
    
    
}
