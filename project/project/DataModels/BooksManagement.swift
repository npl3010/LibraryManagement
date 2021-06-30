//
//  BooksManagement.swift
//  project
//
//  Created by Ling on 6/4/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import Foundation;
import UIKit;

public class BooksManagement {
    static var books = [Book]();
    
    static func loadData() -> Void {
        if let book = Book(id: 1, name: "Thay Doi Tu Duy Lanh Dao", authors: "Authors", type: "Type", quantity: 100, quantityCurrent: 90, path: "", image: UIImage(named: "ThayDoiTuDuyLanhDao")) {
            self.books.append(book);
        }
        if let book = Book(id: 2, name: "Quan Tri Marketing", authors: "Authors", type: "Type", quantity: 200, quantityCurrent: 195, path: "", image: UIImage(named: "QuanTriMarketing")) {
            self.books.append(book);
        }
        if let book = Book(id: 3, name: "Quan Tri Chien Luoc", authors: "Authors", type: "Type", quantity: 50, quantityCurrent: 42, path: "", image: UIImage(named: "QuanTriChienLuoc")) {
            self.books.append(book);
        }
        if let book = Book(id: 4, name: "Cay Cam Ngot Cua Toi", authors: "Authors", type: "Type", quantity: 80, quantityCurrent: 77, path: "", image: UIImage(named: "CayCamNgotCuaToi")) {
            self.books.append(book);
        }
        if let book = Book(id: 5, name: "Dac Nhan Tam", authors: "Authors", type: "Type", quantity: 3, quantityCurrent: 2, path: "", image: UIImage(named: "DacNhanTam")) {
            self.books.append(book);
        }
    }
    
    static func getBookByID(id: Int) -> Book? {
        for b in self.books {
            if id == b.bookID {
                return b;
            }
        }
        return nil;
    }
    
    static func toString() -> String {
        return "This is a list of books! There are \(self.books.count) books.";
    }
    
    static func get_books() -> Array<Book> {
        return books;
    }
    
    private func doSth() -> Void {
        // Do something here...
    }
}
