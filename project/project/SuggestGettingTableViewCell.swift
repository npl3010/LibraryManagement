//
//  SuggestGettingTableViewCell.swift
//  project
//
//  Created by Ling on 6/11/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import UIKit

class SuggestGettingTableViewCell: UITableViewCell {
    // Properties:
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookID: UILabel!
    @IBOutlet weak var bookQuantity: UILabel!
    @IBOutlet weak var borrowingID: UILabel!
    
    
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
