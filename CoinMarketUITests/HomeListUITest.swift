//
//  CoinMarketUITests.swift
//  CoinMarketUITests
//
//  Created by David on 29/6/18.
//  Copyright © 2018 David. All rights reserved.
//

import XCTest

class HomeListUITest: XCTestCase {
    
    /// Instance of myApp
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        self.app = XCUIApplication()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewsEsxists() {
        self.app.launch()
        let HomeTableView = app.tables["HomeTableView"]
        let PortfolioBarButton = app.buttons["PortfolioButton"]
        
        XCTAssertTrue(HomeTableView.exists, "The HomeTableView exists")
        XCTAssertTrue(PortfolioBarButton.exists, "The HomeList BarButton exists")
        
    }
    
}
