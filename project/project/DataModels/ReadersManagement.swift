//
//  ReadersManagement.swift
//  project
//
//  Created by Ling on 6/6/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import Foundation;
import UIKit;

public class ReadersManagement {
    static var readers = [Reader]();
    
    static func loadData() -> Void {
        if let user = Reader(id: 1, name: "Nguyen Moc Mac", phone: "0123456789", email: "nguyenmocmac@mail.com") {
            self.readers.append(user);
        }
        if let user = Reader(id: 2, name: "Tran Gia Tran", phone: "0123456788", email: "trangiatran@mail.com") {
            self.readers.append(user);
        }
    }
    
    static func toString() -> String {
        return "This is a list of readers! There are \(self.readers.count) readers.";
    }
    
    static func get_readers() -> Array<Reader> {
        return readers;
    }
    
    private func doSth() -> Void {
        // Do something here...
    }
}
