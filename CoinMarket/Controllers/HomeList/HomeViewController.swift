//
//  HomeViewController.swift
//  CoinMarket
//
//  Created by David on 29/6/18.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

/// ViewController for coins list
final class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Constants
    
    /// ViewModel for coins
    private var viewModel = HomeViewControllerViewModel()
    
    // MARK: - Outlets
    
    /// Outlet for tableView
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life cycle
    
    /// Handles required actions upon view load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
    }
    
    /// Handles required actions when view appears
    ///
    /// - Parameter animated: Whether to use animation or not
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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

}

extension HomeViewController: DidFetchDelegate {
    /// Handles when fetch is finish
    func didFetch() {
        self.tableView.reloadData()
    }
}

