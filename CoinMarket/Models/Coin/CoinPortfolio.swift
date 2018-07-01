//
//  CoinPortfolio.swift
//  CoinMarket
//
//  Created by David on 1/7/18.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit
import RealmSwift

class CoinPortfolio: Object {
    /// Model properties
    @objc dynamic public var coinId : Int = 0
    @objc dynamic public var amount : String = ""
    @objc dynamic public var priceUsd : String = ""
    
    func fillCoin(dict : NSDictionary) {
        self.coinId = dict["coin_id"] as? Int ?? 0
        self.amount = dict["amount"] as? String ?? kNoName
        self.priceUsd = dict["price_usd"] as? String ?? kNoName
    }
}
