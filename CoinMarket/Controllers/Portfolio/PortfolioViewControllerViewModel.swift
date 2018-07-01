//
//  PortfolioViewControllerViewModel.swift
//  CoinMarket
//
//  Created by David on 1/7/18.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

class PortfolioViewControllerViewModel: NSObject {
    //MARK: - Constants
    
    /// DataHandler instance
    let dataHandler = DataHandlerManager.sharedInstance
    
    /// Array models of coins
    private var arrayModels = NSMutableArray()
    
    /// Delegate for when the fetch is finish
    public var delegate: DidFetchDelegate?
    
    /// Start fetch
    func startFetch() {
        if ReachabilityHelper.sharedInstance.isNetworkReachable() {
            self.fetchPortfolio()
        }else{
            self.fetchPortfolioFromDB()        }
    }
    
    /// Hanldes the call of the service
    func fetchPortfolio(){
        dataHandler.fetchPortfolio(receiver: self)
    }
    
    /// handle model when off line
    func fetchPortfolioFromDB(){
        let dataHandler = DataHandlerManager.sharedInstance
        self.arrayModels.removeAllObjects()
        self.arrayModels.addObjects(from: dataHandler.fetchDataFromDataBase())
        self.delegate?.didFetch()
    }
    
    /// Handles the number of models in array
    ///
    /// - Returns: nombers of models
    func modelsCount() -> Int {
        return self.arrayModels.count
    }
    
    /// Handles the viewModel for a cell
    ///
    /// - Parameter index: index of the section
    /// - Returns: viewModel for this row
    func cellViewModelAtIndexPath(index: Int) -> PortfolioCellViewModel {
        let viewModel = PortfolioCellViewModel.init(model: self.arrayModels.object(at: index) as! CoinPortfolio)
        return viewModel
    }
    
    /// Handles to add new cryptocurrencie
    ///
    /// - Parameters:
    ///   - id: id coin
    ///   - amount: amount of currencie
    ///   - price: price of currencie
    func addNewCryptocurrencie(id: Int, amount: Float, price: Float){
        DispatchQueue.main.async {
            self.dataHandler.addCryptocurrenci(id: id, amount: amount, price: price, receiver: self)
        }
    }
}

extension PortfolioViewControllerViewModel: FetchProtocol {
    func didFetch() {
        self.arrayModels.removeAllObjects()
        self.startFetch()
    }
    
    /// Handles the response from API
    ///
    /// - Parameters:
    ///   - models: array of models
    func arrayModels(models: [CoinPortfolio]) {
        self.arrayModels.addObjects(from: models)
        self.delegate?.didFetch()
    }
    /// Handles the response from API
    ///
    /// - Parameters:
    ///   - models: array of models
    ///   - lastPage: last page of the service
    func arrayModels(models: [Coin], lastPage: Int) {
    }
    
    /// Handles the error in the service
    func didFailData() {
        
    }
}
