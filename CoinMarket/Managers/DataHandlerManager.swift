//
//  DataHandlerManager.swift
//  CoinMarket
//
//  Created by David on 29/6/18.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation
import RealmSwift

/// Hanldes comunications between viewControllers and service or parser
final class DataHandlerManager: NSObject {
    //MARK: - Constants
    /// Single-shared instance
    public static let sharedInstance: DataHandlerManager = DataHandlerManager()
    
    
    // MARK: GetServices
    
    /// Handles the fetch
    ///
    /// - Parameters:
    ///   - page: page for fetch
    ///   - receiver: response receiver
    func fetchCoins(page: Int, receiver: FetchProtocol) {
        let webServices: WebServiceManager = WebServiceManager.sharedInstance
        webServices.delegate = self
        webServices.fetchCoins(page: page, receiver: receiver)
    }
    
    /// Handles objects from memory
    ///
    /// - Returns: array of models
    func fetchDataFromDataBase() -> [CoinPortfolio] {
        let dataModelsManager = DataModelsManager.sharedInstance
        dataModelsManager.delegate = self
        return dataModelsManager.dataFromDataBase()
    }
    
    /// Handles portfolio
    ///
    /// - Parameter receiver: response receiver
    func fetchPortfolio(receiver: FetchProtocol) {
        let webServices: WebServiceManager = WebServiceManager.sharedInstance
        webServices.delegate = self
        webServices.fetchPortfolio(receiver: receiver)
    }
    
    func addCryptocurrenci(id: Int, amount: Float, price: Float, receiver: FetchProtocol){
        let webServices: WebServiceManager = WebServiceManager.sharedInstance
        webServices.delegate = self
        webServices.addCryptocurrencie(id: id, amount: amount, price: price, receiver: receiver)
    }
}

extension DataHandlerManager: WebServiceManagerDelegate{
    
    func didFetch(receiver: FetchProtocol) {
        receiver.didFetch()
    }
    
    
    /// Handles the data from service
    ///
    /// - Parameters:
    ///   - dict: data from service
    ///   - receiver: response receiver
    func dataFromRequest(dict: NSDictionary, receiver: FetchProtocol) {
        let dataModelsManager = DataModelsManager.sharedInstance
        dataModelsManager.delegate = self
        dataModelsManager.parseDataToModelsCoins(dict: dict, receiver: receiver)
    }
    
    /// Handles the data from service
    ///
    /// - Parameters:
    ///   - dict: data from service
    ///   - receiver: response receiver
    func dataFromPortfolio(dict: NSDictionary, receiver: FetchProtocol) {
        let dataModelsManager = DataModelsManager.sharedInstance
        dataModelsManager.delegate = self
        dataModelsManager.parseDataToModelsPortfolio(dict: dict, receiver: receiver)
    }
    
    /// Handles the error in the fetch
    ///
    /// - Parameter receiver: response receiver
    func didFailData(receiver: FetchProtocol) {
        receiver.didFailData()
    }
}

extension DataHandlerManager: DataModelsManagerDelegate{
    /// Handles the parser of the data to models
    ///
    /// - Parameters:
    ///   - models: array of models
    ///   - receiver: response receiver
    func didParseDataFromPortfolio(models: [CoinPortfolio], receiver: FetchProtocol) {
        receiver.arrayModels(models: models)
    }
    
    
    /// Handles the parser of the data to models
    ///
    /// - Parameters:
    ///   - models: array of models
    ///   - lastPage: last page to fetch
    ///   - receiver: response receiver
    func didParseDataToModels(models: [Coin],lastPage: Int, receiver: FetchProtocol) {
        receiver.arrayModels(models: models,lastPage: lastPage)
    }
}
