//
//  BooksTableViewCell.swift
//  project
//
//  Created by Ling on 6/4/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import UIKit

class BooksTableViewCell: UITableViewCell {
    // Properties:
    @IBOutlet weak var bookQuantityCurrent: UILabel!
    @IBOutlet weak var bookQuantity: UILabel!
    @IBOutlet weak var bookAuthors: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    
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
