//
//  ReadersTableViewCell.swift
//  project
//
//  Created by Ling on 6/6/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import UIKit

class ReadersTableViewCell: UITableViewCell {
    // Properties:
    @IBOutlet weak var readerImage: UIImageView!
    @IBOutlet weak var booksBorrowed: UILabel!
    @IBOutlet weak var readerName: UILabel!
    @IBOutlet weak var condition: UILabel!
    
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
