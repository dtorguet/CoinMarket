//
//  Protocols.swift
//  CoinMarket
//
//  Created by David on 29/6/18.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation

/// Delegate for DataHandle interactions
protocol FetchProtocol {
    func arrayModels(models: [Coin], lastPage: Int)
    func arrayModels(models: [CoinPortfolio])
    func didFailData()
    func didFetch()
}

/// Delegate for ViewControlers interactions
protocol DidFetchDelegate {
    func didFetch()
    func noNetwork()
}

/// Delegate for service interactions
protocol WebServiceManagerDelegate {
    func dataFromRequest(dict: NSDictionary, receiver: FetchProtocol)
    func dataFromPortfolio(dict: NSDictionary, receiver: FetchProtocol)
    func didFetch(receiver: FetchProtocol)
    func didFailData(receiver: FetchProtocol)
}

/// Delegate for parse interactions
protocol DataModelsManagerDelegate {
    func didParseDataToModels(models: [Coin],lastPage: Int, receiver: FetchProtocol)
    func didParseDataFromPortfolio(models: [CoinPortfolio], receiver: FetchProtocol)
}
