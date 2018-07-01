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
    @objc dynamic private var price_usd : Int = 0
    @objc dynamic private var descriptionModel: String = ""
    @objc dynamic private var url : String = ""
    @objc dynamic private var extensionUrl : String = ""
    
    func fillCoin(dict : NSDictionary) {
        self.id = dict["id"] as? Int ?? 0
        self.name = dict["name"] as? String ?? kNoName
        self.symbol = dict["symbol"] as? String ?? kNoName
        self.id = dict["rank"] as? Int ?? 0
    }
}
