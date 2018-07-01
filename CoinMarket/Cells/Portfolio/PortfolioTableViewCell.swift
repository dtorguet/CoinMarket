//
//  PortfolioTableViewCell.swift
//  CoinMarket
//
//  Created by David on 1/7/18.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell {

    // MARK: - Constants
    
    var viewModel: PortfolioCellViewModel?
    
    // MARK: - Outlets
    
    @IBOutlet weak var coinIdLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Layout
    
    /// Handles required actions when subviews are about to layout
    override func layoutSubviews() {
        super.layoutSubviews()
        self.coinIdLabel.text = self.viewModel?.coinId
        self.amountLabel.text = self.viewModel?.amount
        self.priceLabel.text = self.viewModel?.price
    }
    
    /// Handles required actions when view just moved to superview
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.layoutIfNeeded()
    }
    // MARK: - Interactions
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Cell identifier
    
    /// Gets identifier for this cell type
    ///
    /// - Returns: Cell identifier
    static func cellIdentifier() -> String {
        return "portfolioCell"
    }
    
}
