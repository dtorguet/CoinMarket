//
//  PortfolioViewController.swift
//  CoinMarket
//
//  Created by David on 1/7/18.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PortfolioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Constants
    
    /// ViewModel for coins
    private var viewModel = PortfolioViewControllerViewModel()
    
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
        self.viewModel.startFetch()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
    }
    
    /// Handles required actions when view appears
    ///
    /// - Parameter animated: Whether to use animation or not
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
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
        let cell = tableView.dequeueReusableCell(withIdentifier: PortfolioTableViewCell.cellIdentifier(), for: indexPath) as! PortfolioTableViewCell
        cell.viewModel = self.viewModel.cellViewModelAtIndexPath(index: indexPath.row)
        return cell
    }
    
    // MARK: - Interactions
    
    @objc func addTapped(){
        /// Create the alert controller.
        let alert = UIAlertController(title: "Add cryotocurrencie", message: "Add your Crypto", preferredStyle: .alert)
        
        /// Add ID Cryptocurrencie
        alert.addTextField { (textField) in
            textField.keyboardType = .numberPad
            textField.placeholder = "Id"
        }
        alert.addTextField { (textField) in
            textField.keyboardType = .numberPad
            textField.placeholder = "Amount"
        }
        alert.addTextField { (textField) in
            textField.keyboardType = .numberPad
            textField.placeholder = "Price"
        }
        
        /// Add amount Cryptocurrencie
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let idCoin = Int((alert?.textFields![0].text)!) ?? 0
            let amountCoin = Float((alert?.textFields![1].text)!) ?? 0
            let priceCoin = Float((alert?.textFields![2].text)!) ?? 0
            self.viewModel.addNewCryptocurrencie(id: idCoin, amount: amountCoin, price: priceCoin)
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
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
        NVActivityIndicatorPresenter.sharedInstance.setMessage("Loading Portfolio")
    }
}

extension PortfolioViewController: DidFetchDelegate {
    
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
