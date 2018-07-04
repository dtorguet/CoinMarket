//
//  Model.swift
//  CoinMarket
//
//  Created by David on 29/6/18.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation
import RealmSwift

final class Coin: Object {
    /// Model properties
    @objc dynamic private var id : Int = 0
    @objc dynamic public var name : String = ""
    @objc dynamic public var symbol : String = ""
    @objc dynamic private var rank : Int = 0
    @objc dynamic private var price : Int = 0
    
    func fillCoin(dict : NSDictionary) {
        self.id = dict["id"] as? Int ?? 0
        self.name = dict["name"] as? String ?? kNoName
        self.symbol = dict["symbol"] as? String ?? kNoName
        self.rank = dict["rank"] as? Int ?? 0
        self.price = dict["price_usd"] as? Int ?? 0
    }
}
