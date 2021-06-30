//
//  ReaderBooks.swift
//  project
//
//  Created by Ling on 6/8/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import Foundation;
import UIKit;

class ReaderBooks {
    var readerbooksID: Int;
    var readerID: Int;
    var bookID: Int;
    var quantity: Int;
    
    init?(id: Int, readerId: Int, bookId: Int, numberOfBooks: Int) {
        readerbooksID = id;
        readerID = readerId;
        bookID = bookId;
        quantity = numberOfBooks;
    }
    
    public static func toString() -> String {
        return "Readers borrow books!";
    }
}
