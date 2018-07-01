//
//  HomeViewController.swift
//  CoinMarket
//
//  Created by David on 29/6/18.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

/// ViewController for coins list
final class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Constants
    
    /// ViewModel for coins
    private var viewModel = HomeViewControllerViewModel()
    
    /// Activity view
    let activityData = ActivityData()
    
    // MARK: - Outlets
    
    /// Outlet for tableView
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life cycle
    
    /// Handles required actions upon view load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setActivityView()
        self.viewModel.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
    }
    
    /// Handles required actions when view appears
    ///
    /// - Parameter animated: Whether to use animation or not
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.startFetch()
    }
    
    // MARK: - UITableViewDataSource
    
    /// Gets number of rows to display in given section
    ///
    /// - Parameters:
    ///   - tableView: UITableView instance
    ///   - section: Section to return number of rows to display for
    /// - Returns: Number of rows to display for given section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.modelsCount()
    }
    
    /// Gets cell to display for given index path
    ///
    /// - Parameters:
    ///   - tableView: UITableView instance
    ///   - indexPath: Index path to return cell to display for
    /// - Returns: Cell to display for given index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCellTableViewCell.cellIdentifier(), for: indexPath) as! HomeCellTableViewCell
        cell.viewModel = self.viewModel.cellViewModelAtIndexPath(index: indexPath.row)
        if indexPath.row == self.viewModel.modelsCount() - 1 {
            self.viewModel.startFetch()
        }
        return cell
    }
    
    // MARK: - Interactions
    
    /// Handles required actions when user selects a row
    ///
    /// - Parameters:
    ///   - tableView: UITableView instance
    ///   - indexPath: Index path of selected cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Views
    
    /// Set activity view just for the first fetch
    func setActivityView() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
        NVActivityIndicatorPresenter.sharedInstance.setMessage("Loading CoinsMarket")
    }
}

extension HomeViewController: DidFetchDelegate {
    
    /// Handles when fetch is finish
    func didFetch() {
        self.tableView.reloadData()
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    /// Halldes when no network
    func noNetwork() {
         NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        // Create action sheet instance
        let alert = UIAlertController(title: "UPS!!!", message: "It seems you don't have a network connection", preferredStyle: .alert)
        
        // Add cancel button
        let cancel = UIAlertAction(title: "Got it", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        if self.viewModel.modelsCount() == 0 {
            // Add reload button
            let reload = UIAlertAction(title: "Reload", style: .default, handler: { _ in
                self.viewModel.startFetch()
            })
            alert.addAction(reload)
        }
        
        // Present action sheet
        self.present(alert, animated: true) {
        }
    }
}

