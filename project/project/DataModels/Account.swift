//
//  Account.swift
//  project
//
//  Created by Ling on 6/16/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import Foundation;
import UIKit;

class Account {
    var username: String;
    var password: String;
    
    init?(username: String, password: String) {
        if username.isEmpty == true || password.isEmpty == true {
            return nil;
        }
        self.username = username;
        self.password = password;
    }
    
    public static func toString() -> String {
        return "This is a account!";
    }
}
