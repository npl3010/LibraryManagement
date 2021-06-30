//
//  BooksBorrowedTableViewCell.swift
//  project
//
//  Created by Ling on 6/6/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import UIKit

class BooksBorrowedTableViewCell: UITableViewCell {
    // Properties:
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookID: UILabel!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookQuantity: UITextField!
    
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
