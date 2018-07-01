//
//  PortfolioCellViewModel.swift
//  CoinMarket
//
//  Created by David on 1/7/18.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

class PortfolioCellViewModel: NSObject {
    //MARK: - Constants
    
    /// Model of coin
    private var modelCoin: CoinPortfolio
    
    /// Field coin_id of coin
    public var coinId: String
    
    /// Field amount of coin
    public var amount: String
    
    /// Field price of coin
    public var price: String
    
    /// Handles the initialize
    ///
    /// - Parameter model: model of coin
    init(model: CoinPortfolio) {
        self.modelCoin = model
        self.coinId = String(self.modelCoin.coinId)
        self.amount = self.modelCoin.amount
        self.price = self.modelCoin.priceUsd
    }
}
