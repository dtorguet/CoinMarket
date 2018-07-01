//
//  Model.swift
//  CoinMarket
//
//  Created by David on 29/6/18.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation

final class Coin: NSObject {
    
    private var id : NSNumber = 0
    public var name : String = ""
    public var symbol : String = ""
    private var rank : NSNumber = 0
    private var price_usd : NSNumber = 0
    private var descriptionModel: String = ""
    private var url : String = ""
    private var extensionUrl : String = ""
    
    
    /// Handle the init for model
    ///
    /// - Parameter dict: dict object
    init(dict : NSDictionary) {
        self.id = dict["id"] as? NSNumber ?? 0
        self.name = dict["name"] as? String ?? kNoName
        self.name = dict["symbol"] as? String ?? kNoName
        self.id = dict["rank"] as? NSNumber ?? 0
        //        self.descriptionModel = dict["description"] as? String ?? kNoName
        //        self.thumbnailDict = dict["thumbnail"] as? NSDictionary ?? NSDictionary()
        //        self.extensionUrl = self.thumbnailDict["extension"] as? String ?? kNoName
        //        self.url = self.thumbnailDict["path"] as? String ?? kNoName
    }
}
