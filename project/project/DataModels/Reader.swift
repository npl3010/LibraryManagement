//
//  Reader.swift
//  project
//
//  Created by Ling on 6/6/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import Foundation;
import UIKit;

class Reader {
    var readerID: Int;
    var readerName: String;
    var readerPhone: String;
    var readerEmail: String;
    
    init?(id: Int, name: String, phone: String, email: String) {
        if name.isEmpty == true || phone.isEmpty == true || email.isEmpty == true {
            return nil;
        }
        readerID = id;
        readerName = name;
        readerPhone = phone;
        readerEmail = email;
    }
    
    public static func toString() -> String {
        return "This is a reader!";
    }
}
