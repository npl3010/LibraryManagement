//
//  ViewController.swift
//  project
//
//  Created by Ho Viet Long on 5/23/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load data if you don't want to connect database:
        BooksManagement.loadData();
        ReadersManagement.loadData();
        ReaderBooksManagement.loadData();
    }


}

