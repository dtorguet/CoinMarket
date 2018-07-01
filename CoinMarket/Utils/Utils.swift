//
//  Utils.swift
//  CoinMarket
//
//  Created by David on 1/7/18.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation

final class Utils {
    
    class func getBackendAuthAut()-> String {
        let path = Bundle.main.path(forResource: "Info", ofType: "plist")
        let dictionary = NSDictionary.init(contentsOfFile: path!)
        let BackendUser = dictionary?.value(forKey: "BackendUser") as! String
        let BackendPassword = dictionary?.value(forKey: "BackendPassword") as! String
        let loginString = String(format: "%@:%@", BackendUser, BackendPassword)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        return base64LoginString
    }
    
    class func stringDateFormatter() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone?
        return formatter.string(from: now)
    }
}

