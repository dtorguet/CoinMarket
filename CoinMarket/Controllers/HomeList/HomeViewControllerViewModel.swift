//
//  HomeViewControllerViewModel.swift
//  CoinMarket
//
//  Created by David on 29/6/18.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

class HomeViewControllerViewModel: NSObject {
    //MARK: - Constants
    
    /// Array models of coins
    private var arrayModels = NSArray()
    
    /// Current page for fethc
    private var currentPage = 0
    
    /// Last page of the service
    private var lastPage = 1
    
    /// Delegate for when the fetch is finish
    public var delegate: DidFetchDelegate?
    
    
    /// Handles when initialize
    override init() {
        super.init()
        self.fetchCoins()
    }
    
    /// Hanldes the call of the service
    func fetchCoins(){
        if self.currentPage < self.lastPage {
            let dataHandler = DataHandlerManager.sharedInstance
            dataHandler.fetchCoins(page: self.currentPage, receiver: self)
        }
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
    func cellViewModelAtIndexPath(index: Int) -> HomeCellViewModel {
        let viewModel = HomeCellViewModel.init(model: self.arrayModels.object(at: index) as! Model)
        return viewModel
    }
}

extension HomeViewControllerViewModel: FetchProtocol {
    
    /// Handles the response from API
    ///
    /// - Parameters:
    ///   - models: array of models
    ///   - lastPage: last page of the service
    func arrayModels(models: [Model], lastPage: Int) {
        self.currentPage += 1
        self.lastPage = lastPage
        self.arrayModels = models as NSArray
        self.delegate?.didFetch()
    }
    
    /// Handles the error in the service
    func didFailData() {
        
    }
}

