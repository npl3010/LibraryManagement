//
//  ReaderBooksManagement.swift
//  project
//
//  Created by Ling on 6/8/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import Foundation;
import UIKit;

public class ReaderBooksManagement {
    static var readerBooks = [ReaderBooks]();
    
    static func loadData() -> Void {
        if let rb = ReaderBooks(id: 1, readerId: 1, bookId: 1, numberOfBooks: 10) {
            self.readerBooks.append(rb);
        }
        if let rb = ReaderBooks(id: 2, readerId: 1, bookId: 2, numberOfBooks: 5) {
            self.readerBooks.append(rb);
        }
        if let rb = ReaderBooks(id: 3, readerId: 2, bookId: 3, numberOfBooks: 8) {
            self.readerBooks.append(rb);
        }
        if let rb = ReaderBooks(id: 4, readerId: 2, bookId: 4, numberOfBooks: 3) {
            self.readerBooks.append(rb);
        }
        if let rb = ReaderBooks(id: 5, readerId: 2, bookId: 5, numberOfBooks: 1) {
            self.readerBooks.append(rb);
        }
    }
    
    static func toString() -> String {
        return "This is a list of readers that borrowed books!";
    }
    
    static func get_readers() -> Array<ReaderBooks> {
        return readerBooks;
    }
    
    private func doSth() -> Void {
        // Do something here...
    }
}
