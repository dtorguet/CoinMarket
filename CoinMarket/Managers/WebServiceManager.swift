//
//  WebServiceManager.swift
//  CoinMarket
//
//  Created by David on 29/6/18.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation
import Alamofire

/// Service manager
final class WebServiceManager: NSObject {
    
    // MARK: - Constants
    
    /// Shared instance
    public static let sharedInstance: WebServiceManager = WebServiceManager()
    
    /// Delegate
    var delegate : WebServiceManagerDelegate?
    
    // MARK: - Services
    
    /// Get coins from API
    ///
    /// - Parameters:
    ///   - page: page for the request
    ///   - receiver: response receiver
    func fetchCoins(page: Int, receiver: FetchProtocol) {
        Alamofire.request(kUrlCoins + "\(page)").responseJSON { response in
            if let status = response.response?.statusCode {
                if status == 401{
                    self.delegate?.didFailData(receiver: receiver)
                    return
                }
            }
            if let data = response.data, let _ = String(data: data, encoding: .utf8) {
                do {
                    if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        DispatchQueue.main.async(execute: {
                            self.delegate?.dataFromRequest(dict: dict, receiver: receiver)
                        })
                    }
                } catch let error as NSError
                {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    /// Handles portfolio
    ///
    /// - Parameter receiver: response receiver
    func fetchPortfolio(receiver: FetchProtocol) {
        let headers: HTTPHeaders = [
            "Authorization": "Basic " + Utils.getBackendAuthAut(),
            "Accept": "application/json"
        ]
        
        Alamofire.request(kUrlPortfolio, headers: headers).responseJSON { response in
            debugPrint(response)
            if let status = response.response?.statusCode {
                if status == 401{
                    self.delegate?.didFailData(receiver: receiver)
                    return
                }
            }
            if let data = response.data, let _ = String(data: data, encoding: .utf8) {
                do {
                    if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        DispatchQueue.main.async(execute: {
                             self.delegate?.dataFromPortfolio(dict: dict, receiver: receiver)
                        })
                    }
                } catch let error as NSError
                {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    /// Handles add cryptocurrenci to portfolio
    ///
    /// - Parameters:
    ///   - id: id Coin
    ///   - amount: Amount
    ///   - price: price of coin
    ///   - receiver: response receiver
    func addCryptocurrencie(id: Int, amount: Float, price: Float, receiver: FetchProtocol){
        let parameters: [String: Any] = ["coin_id": id, "amount": amount, "price_usd": price, "traded_at": Utils.stringDateFormatter()]
        let url = URL(string: kUrlPortfolio)!
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("Basic " + Utils.getBackendAuthAut(), forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        Alamofire.request(request).responseJSON {
            (response) in
            debugPrint(response)
            if let status = response.response?.statusCode {
                if status == 400{
                    self.delegate?.didFailData(receiver: receiver)
                    return
                }
                if status == 401{
                    self.delegate?.didFailData(receiver: receiver)
                    return
                }
            }
            if let data = response.data, let _ = String(data: data, encoding: .utf8) {
                do {
                    if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        DispatchQueue.main.async(execute: {
                            self.delegate?.didFetch(receiver: receiver)
                        })
                    }
                } catch let error as NSError
                {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
