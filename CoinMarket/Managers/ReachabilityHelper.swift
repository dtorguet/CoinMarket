//
//  ReachabilityManager.swift
//  CoinMarket
//
//  Created by David on 29/6/18.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit
import Reachability

/// Reachability manager
final class ReachabilityHelper {
    // MARK: - Constants
    
    /// Reachability instance
    private let reachability = Reachability()!

    /// Shared instance
    public static let sharedInstance = ReachabilityHelper()
    
    // MARK: - Initializers
    
    /// Initializes a new instance
    private init() {
        
        // Reachable handler
        self.reachability.whenReachable = { _ in
            self.whenReachable()
        }
        
        // Unreachable handler
        self.reachability.whenUnreachable = { _ in
            self.whenUnreachable()
        }
        
        // Setup life cycle notifications
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    // MARK: - Life cycle
    
    /// Handles required actions when application did enter background
    @objc private func applicationDidEnterBackground() {
        self.stopNotifier()
    }
    
    @objc private func applicationWillEnterForeground() {
        self.startNotifier()
    }
    
    // MARK: - Notifiers
    
    /// Starts notifier
    public func startNotifier() {
        do {
            try self.reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    /// Stops notifier
    public func stopNotifier() {
        self.reachability.stopNotifier()
    }
    
    // MARK: - Current state
    
    /// Whether or not network is reachable
    ///
    /// - Returns: True if network is reachable; false otherwise
    public func isNetworkReachable() -> Bool {
        return self.reachability.connection != .none
    }
    
    // MARK: - State changes handling
    
    // Handles required actions when network is reachable
    public func whenReachable() {
        
    }
    
    /// Handles required actions when network is unreachable
    public func whenUnreachable() {
    }
}
