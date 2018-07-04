//
//  CoinsListTest.swift
//  CoinMarketTests
//
//  Created by David on 4/7/18.
//  Copyright © 2018 David. All rights reserved.
//

import XCTest
@testable import CoinMarket

class CoinsListTest: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHomeListCount() {

        let HomeVCViewModelMockup = HomeViewControllerViewModel()
        let DataHandlerMockup = DataHandlerManager()
        let WebServicesMockup = WebServiceManager()
        WebServicesMockup.delegate = DataHandlerMockup
        
        /// Dict of coins
        let dataCoins: [[String: Any]] = [["id": "1", "name": "EthereumMoc", "symbol": "ETHM"],["id": "2", "name": "BitcoinMoc", "symbol": "BITM"]]
         let coinsDict: [String: Any] = ["data": dataCoins,"last_page": 1]
        let dictCoins: [String: Any] = ["coins": coinsDict]
        
        WebServicesMockup.delegate?.dataFromRequest(dict: dictCoins as NSDictionary, receiver: HomeVCViewModelMockup)
        
        XCTAssertEqual(HomeVCViewModelMockup.modelsCount(), dataCoins.count)
    }
}
