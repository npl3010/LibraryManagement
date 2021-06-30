//
//  ViewController.swift
//  project
//
//  Created by Ho Viet Long on 5/23/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    public var firstTimeHere: Bool = true;
    var account: Account?;
    
    @IBOutlet weak var lblHelloUser: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load data if you don't want to connect database:
        // BooksManagement.loadData();
        // ReadersManagement.loadData();
        // ReaderBooksManagement.loadData();
        
        // Load data from Firebase Realtime Database:
        let ref = Database.database().reference();
        
        // READ:
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let db = snapshot.value as? [String : AnyObject] {
                // Get length:
                print(db.keys)
                // Get list:
                for str in db.keys {
                    if str == "books" {
                        ref.child("books").observeSingleEvent(of: .value) { (snapshot) in
                            if let books = snapshot.value as? [Any] {
                                for book in books {
                                    if let b = book as? [String:Any] {
                                        let id = b["book_id"] as! Int;
                                        let name = b["book_name"] as! String;
                                        let authors = b["book_authors"] as! String;
                                        let type = b["book_type"] as! String;
                                        let quantity = b["book_quantity"] as! Int;
                                        let quantityCurrent = b["book_quantity_current"] as! Int;
                                        let imagePath = b["book_image"] as! String;
                                        let bookImage = UIImage(named: "icon_photo");
                                        if let b = Book(id: id, name: name, authors: authors, type: type, quantity: quantity, quantityCurrent: quantityCurrent, path: imagePath, image: bookImage) {
                                            BooksManagement.books.append(b);
                                        }
                                        print(name)
                                    }
                                }
                            }
                        }
                    }
                    else if str == "readers" {
//                        ref.child("readers").observeSingleEvent(of: .value) { (snapshot) in
//                            if let readers = snapshot.value as? [Any] {
//                                print("wdwdwdwdwdwd")
//                                for reader in readers {
//                                    if let r = reader as? [String:Any] {
//                                        let id = r["reader_id"] as! Int;
//                                        let name = r["reader_name"] as! String;
//                                        let phone = r["reader_phone"] as! String;
//                                        let email = r["reader_email"] as! String;
//                                        if let r = Reader(id: id, name: name, phone: phone, email: email) {
//                                            ReadersManagement.readers.append(r);
//                                        }
//                                        print(name)
//                                    }
//                                }
//                            }
//                        }
                        
                        ref.child("readers").getData { (error, snapshot) in
                            if let error = error {
                                print("Error getting data \(error)")
                            }
                            else if snapshot.exists() {
                                if let readers = snapshot.value as? [Any] {
                                    for reader in readers {
                                        if let r = reader as? [String:Any] {
                                            let id = r["reader_id"] as! Int;
                                            let name = r["reader_name"] as! String;
                                            let phone = r["reader_phone"] as! String;
                                            let email = r["reader_email"] as! String;
                                            if let r = Reader(id: id, name: name, phone: phone, email: email) {
                                                ReadersManagement.readers.append(r);
                                            }
                                            print(name)
                                        }
                                    }
                                }
                            }
                            else {
                                print("No data available")
                            }
                        }
                        
                    }
                    else if str == "readerbooks" {
                        ref.child("readerbooks").observeSingleEvent(of: .value) { (snapshot) in
                            if let readerbooks = snapshot.value as? [Any] {
                                for readerbook in readerbooks {
                                    if let rb = readerbook as? [String:Any] {
                                        let readerbooksID = rb["readerbooks_id"] as! Int;
                                        let readerID = rb["reader_id"] as! Int;
                                        let bookID = rb["book_id"] as! Int;
                                        let quantity = rb["quantity"] as! Int;
                                        if let rb = ReaderBooks(id: readerbooksID, readerId: readerID, bookId: bookID, numberOfBooks: quantity) {
                                            ReaderBooksManagement.readerBooks.append(rb);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        
        /*
         // SOLUTION 0:
        ref.child("readers").getData { (error, snapshot) in
            print("ededed")
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                if let readers = snapshot.value as? [Any] {
                    for reader in readers {
                        if let r = reader as? [String:Any] {
                            let id = r["reader_id"] as! Int;
                            let name = r["reader_name"] as! String;
                            let phone = r["reader_phone"] as! String;
                            let email = r["reader_email"] as! String;
                            if let r = Reader(id: id, name: name, phone: phone, email: email) {
                                ReadersManagement.readers.append(r);
                            }
                            print(name)
                        }
                    }
                }
            }
            else {
                print("No data available")
            }
        }*/
        
        /*
         // SOLUTION 1:
        ref.child("books/").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                // print("SHOW: \(snapshot.value)")
                if let books = snapshot.value as? [String : AnyObject] {
                     print(books.keys)
                    for b in books.values {
                        let id = b["book_id"] as! Int;
                        let name = b["book_name"] as! String;
                        let authors = b["book_authors"] as! String;
                        let type = b["book_type"] as! String;
                        let quantity = b["book_quantity"] as! Int;
                        let quantityCurrent = b["book_quantity_current"] as! Int;
                        let imagePath = b["book_image"] as! String;
                        let bookImage = UIImage(named: "icon_photo");

                        if let book = Book(id: id, name: name, authors: authors, type: type, quantity: quantity, quantityCurrent: quantityCurrent, path: imagePath, image: bookImage) {
                            BooksManagement.books.append(book);
                        }
                        print(">> ID: \(id)")
                    }
                }
            }
        }*/
        
        
        
        /*
         // SOLUTION 2:
        ref.child("books").observeSingleEvent(of: .value) { (snapshot) in
            if let books = snapshot.value as? [Any] {
                for book in books {
                    if let b = book as? [String:Any] {
                        let id = b["book_id"] as! Int;
                        let name = b["book_name"] as! String;
                        let authors = b["book_authors"] as! String;
                        let type = b["book_type"] as! String;
                        let quantity = b["book_quantity"] as! Int;
                        let quantityCurrent = b["book_quantity_current"] as! Int;
                        let imagePath = b["book_image"] as! String;
                        let bookImage = UIImage(named: "icon_photo");
                        if let b = Book(id: id, name: name, authors: authors, type: type, quantity: quantity, quantityCurrent: quantityCurrent, path: imagePath, image: bookImage) {
                            BooksManagement.books.append(b);
                        }
                    }
                }
            }
        }*/
        
        
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        if self.firstTimeHere == true {
            self.firstTimeHere = false;
            
            let ref = Database.database().reference();

            ref.child("accounts").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                }
                else if snapshot.exists() {
                    if let accounts = snapshot.value as? [Any] {
                        if accounts.count > 0 {
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "signinView", sender: self)
                            }
                        }
                    }
                    else {
                        print("Data is not valid!")
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "signupView", sender: self)
                    }
                }
            }
        }
        else {
            if AccountsManagement.accounts.count == 1 {
                self.account = AccountsManagement.accounts[0];
                if let a = self.account {
                    self.lblHelloUser.text = "User: \(a.username).";
                }
            }
        }
    }
    
    
    
    @IBAction func btnSignOutTapped(_ sender: Any) {
        AccountsManagement.accounts.removeAll();
        self.performSegue(withIdentifier: "signinView", sender: self);
    }
    
}
