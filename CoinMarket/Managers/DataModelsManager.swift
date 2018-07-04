//
//  DataModelsManager.swift
//  CoinMarket
//
//  Created by David on 29/6/18.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation
import RealmSwift
/// Data parser
final class DataModelsManager: NSObject {
    
    // MARK: - Constants
    
    /// Shared instance
    public static let sharedInstance: DataModelsManager = DataModelsManager()
   
    /// Delegate
    var delegate: DataModelsManagerDelegate?
    
    let realm = try! Realm()
    
    
    /// Parse data from API to models
    ///
    /// - Parameters:
    ///   - dict: Dict from Json
    ///   - receiver: response receiver
    func parseDataToModelsCoins(dict: NSDictionary, receiver: FetchProtocol){
        var arrayOfModels = [Coin]()
        var lastPage = 0
        if dict["coins"] != nil{
            let dataObjects = dict["coins"] as! NSDictionary
            lastPage = dataObjects["last_page"] as! Int
            if dataObjects["data"] != nil{
                let modelsObjects = dataObjects["data"] as! [NSDictionary]
                for i in 0 ..< modelsObjects.count {
                    let item =  modelsObjects[i]
                    let model = Coin()
                    model.fillCoin(dict: item)
                    arrayOfModels.append(model)
                }
            }
        }
        self.delegate?.didParseDataToModels(models: arrayOfModels, lastPage: lastPage, receiver: receiver)
    }
    
    /// Parse data from API to models
    ///
    /// - Parameters:
    ///   - dict: Dict from Json
    ///   - receiver: response receiver
    func parseDataToModelsPortfolio(dict: NSDictionary, receiver: FetchProtocol){
        var arrayOfModels = [CoinPortfolio]()
        self.deleteAll()
        if dict["coins"] != nil{
                let dataObjects = dict["coins"] as! [NSDictionary]
                for i in 0 ..< dataObjects.count {
                    let item =  dataObjects[i]
                    //let model = Coin(dict:item)
                    let model = CoinPortfolio()
                    model.fillCoin(dict: item)
                    self.saveModel(model: model)
                    arrayOfModels.append(model)
                }  
        }
        self.delegate?.didParseDataFromPortfolio(models: arrayOfModels, receiver: receiver)
    }
    
    /// Save model to Realm
    ///
    /// - Parameter model: coin
    func saveModel(model: CoinPortfolio) {
        try! realm.write {
            realm.add(model)
        }
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    /// Fetch models from Realm
    ///
    /// - Returns: array coins
    func dataFromDataBase() -> [CoinPortfolio]{
        let arrayCoins = realm.objects(CoinPortfolio.self)
        var array = [CoinPortfolio]()
        for i in arrayCoins {
            array.append(i)
        }
        return array
    }
}
