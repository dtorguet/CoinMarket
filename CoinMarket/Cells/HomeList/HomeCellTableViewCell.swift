//
//  HomeCellTableViewCell.swift
//  CoinMarket
//
//  Created by David on 29/6/18.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

class HomeCellTableViewCell: UITableViewCell {

    // MARK: - Constants
    
    var viewModel: HomeCellViewModel?
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var modelName: UILabel!
    @IBOutlet weak var modelSymbol: UILabel!
    
    // MARK: - Layout
    
    /// Handles required actions when subviews are about to layout
    override func layoutSubviews() {
        super.layoutSubviews()
        self.modelName.text = self.viewModel?.nameModelText
        self.modelSymbol.text = self.viewModel?.symbolModelText
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
        return "homeCell"
    }
    
}
