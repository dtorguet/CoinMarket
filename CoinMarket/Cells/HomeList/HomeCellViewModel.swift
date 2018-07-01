//
//  HomeCellViewModel.swift
//  CoinMarket
//
//  Created by David on 29/6/18.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

class HomeCellViewModel: NSObject {
    
    //MARK: - Constants
    
    /// Model of coin
    private var modelCoin: Model
    
    /// Field name of coin
    public var nameModelText: String
    
    /// Field symbol of coin
    public var symbolModelText: String

    /// Handles the initialize
    ///
    /// - Parameter model: model of coin
    init(model: Model) {
        self.modelCoin = model
        self.nameModelText = self.modelCoin.name
        self.symbolModelText = self.modelCoin.symbol
    }
    
//    func downloadImage(closure: @escaping (UIImage) -> Void){
//        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
//            if let data = try? Data(contentsOf: self.photoURL){
//                DispatchQueue.main.async(execute: {
//                    let image : UIImage? = UIImage(data: data)
//                    if image != nil{
//                        closure(image!)
//                    }
//                });
//            }
//
//        }
//    }
    
}

