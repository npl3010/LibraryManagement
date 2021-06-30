//
//  AccountsManagement.swift
//  project
//
//  Created by Ling on 6/16/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import Foundation;
import UIKit;

public class AccountsManagement {
    static var accounts = [Account]();
    
    static func toString() -> String {
        return "This is a list of accounts! There are \(self.accounts.count) accounts.";
    }
    
    static func get_accounts() -> Array<Account> {
        return accounts;
    }
    
    private func doSth() -> Void {
        // Do something here...
    }
}
