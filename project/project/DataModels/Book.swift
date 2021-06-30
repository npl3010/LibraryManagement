//
//  Book.swift
//  project
//
//  Created by Ling on 6/4/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import Foundation;
import UIKit;

class Book {
    var bookID: Int;
    var bookName: String;
    var bookAuthors: String;
    var bookType: String;
    var bookQuantity: Int;
    var bookQuantityCurrent: Int;
    var bookImage: UIImage?;
    
    init?(id: Int, name: String, authors: String, type: String, quantity: Int, quantityCurrent: Int, image: UIImage?) {
        if name.isEmpty == true || authors.isEmpty == true || type.isEmpty == true {
            return nil;
        }
        bookID = id;
        bookName = name;
        bookAuthors = authors;
        bookType = type;
        bookQuantity = quantity;
        bookQuantityCurrent = quantityCurrent;
        bookImage = image;
    }
    
    public static func toString() -> String {
        return "This is a book!";
    }
}
