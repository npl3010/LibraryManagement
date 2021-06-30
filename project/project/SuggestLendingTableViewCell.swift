//
//  SuggestLendingTableViewCell.swift
//  project
//
//  Created by Ling on 6/9/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import UIKit

class SuggestLendingTableViewCell: UITableViewCell {
    // Properties:
    @IBOutlet weak var bookID: UILabel!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookQuantity: UILabel!
    @IBOutlet weak var message: UILabel!
    
    // Methods:
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
