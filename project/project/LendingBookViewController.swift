//
//  LendingBookViewController.swift
//  project
//
//  Created by Ling on 6/9/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import UIKit
import Firebase

class LendingBookViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    // Properties:
    var suggestedBooks = [Book]();
    var isValid_readerID: Bool = false;
    var isValid_bookIDOrName: Bool = false;
    var isValid_quantity: Bool = false;
    
    @IBOutlet weak var readerID: UITextField!
    @IBOutlet weak var bookIDOrName: UITextField!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var booksTableView: UITableView!
    @IBOutlet weak var message: UILabel!
    
    
    // First load:
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Reader borrows book";
        btnSubmit.backgroundColor = UIColor.init(red: 0/255, green: 130/255, blue: 200/255, alpha: 1.0);
        btnSubmit.setTitleColor(UIColor.white, for: .normal);
        
        // Delegation:
        readerID.delegate = self;
        bookIDOrName.delegate = self;
        quantity.delegate = self;
        self.booksTableView.delegate = self;
        self.booksTableView.dataSource = self;
    }
    
    //MARK: Hiding keyboard after tap "done":
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    //MARK: Hiding keyboard:
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    // Methods:
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil);
    }
    
    
    // Text changed:
    @IBAction func readerIDChanged(_ sender: Any) {
        var count: Int = 0;
        for r in ReadersManagement.readers {
            if r.readerID == Int(readerID.text ?? "") {
                count = count + 1;
                break;
            }
        }
        if count == 0 {
            isValid_readerID = false;
            message.text = "Reader ID doesn't exist!";
            message.textColor = UIColor.red;
        }
        else {
            isValid_readerID = true;
            message.text = "";
        }
    }
    
    @IBAction func bookIDOrNameChanged(_ sender: Any) {
        suggestedBooks = [];
        isValid_bookIDOrName = false;
        for b in BooksManagement.books {
            if b.bookID == Int(bookIDOrName.text ?? "") || b.bookName.lowercased().contains((bookIDOrName.text ?? "").lowercased()) {
                suggestedBooks.append(b);
                isValid_bookIDOrName = true;
            }
        }
        booksTableView.reloadData();
    }
    
    @IBAction func quantityChanged(_ sender: Any) {
        if let q = Int(quantity.text ?? "0") {
            if suggestedBooks.count == 1 {
                if suggestedBooks[0].bookQuantityCurrent < q {
                    isValid_quantity = false;
                    message.text = "Quantity must be less than \(suggestedBooks[0].bookQuantityCurrent)!";
                    message.textColor = UIColor.red;
                }
                else {
                    isValid_quantity = true;
                    message.text = "";
                }
            }
        }
        else {
            isValid_quantity = false;
            message.text = "Invalid quantity value!";
            message.textColor = UIColor.red;
        }
    }
    
    
    // Submit:
    @IBAction func submit(_ sender: Any) {
        if suggestedBooks.count == 1 {
            if quantity.text != "" && bookIDOrName.text != "" && readerID.text != "" {
                if isValid_readerID == true && isValid_bookIDOrName == true && isValid_quantity == true {
                    
                    // LENDING BOOK: (Add a new readerBooks element)
                    let rbID = ReaderBooksManagement.readerBooks[ReaderBooksManagement.readerBooks.count - 1].readerbooksID + 1;
                    let bID = suggestedBooks[0].bookID;
                    if let rb = ReaderBooks(id: rbID, readerId: Int(readerID.text!)!, bookId: bID, numberOfBooks: Int(quantity.text!)!) {
                        let ref = Database.database().reference();
                        
                        // Lending:
                        if rb.quantity > 0 {
                            ReaderBooksManagement.readerBooks.append(rb);
                            
                            ref.child("readerbooks/\(rbID)").setValue(["readerbooks_id": rb.readerbooksID,
                                                                       "reader_id": rb.readerID,
                                                                       "book_id": rb.bookID,
                                                                       "quantity": rb.quantity]);
                            
                            // After lending, update book quantity of BooksManagement.books:
                            for b in BooksManagement.books {
                                if b.bookID == bID {
                                    b.bookQuantityCurrent = b.bookQuantityCurrent - Int(quantity.text!)!;
                                    ref.child("books/\(b.bookID)/book_quantity_current").setValue(b.bookQuantityCurrent);
                                }
                            }
                        }
                        
                        booksTableView.reloadData();
                        
                        // Show message:
                        message.text = "Lend book successfully!";
                        message.textColor = UIColor.green;
                        
                        // Clear text fields:
                        bookIDOrName.text = "";
                        quantity.text = "";
                    }
                }
            }
            else {
                message.text = "All fields must contain value!";
                message.textColor = UIColor.red;
            }
        }
        else {
            message.text = "Please choose a book!";
            message.textColor = UIColor.red;
        }
    }
    
    
    
    
    // TableView:
    // (Import: UITableViewDataSource, UITableViewDelegate).
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.suggestedBooks.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.booksTableView.dequeueReusableCell(withIdentifier: "SuggestLendingTableViewCell", for: indexPath) as? SuggestLendingTableViewCell {
            
            let b = self.suggestedBooks[indexPath.row];
            cell.bookID.text = String(b.bookID);
            cell.bookName.text = b.bookName;
            cell.bookQuantity.text = String(b.bookQuantityCurrent);
            if Int(b.bookQuantityCurrent) > 0 {
                cell.message.text = "available to borrow!";
                cell.message.textColor = UIColor.green;
            }
            else {
                cell.message.text = "unavailable to borrow!";
                cell.message.textColor = UIColor.red;
            }
            
            return cell;
        }
        else {
            fatalError("Cannot create cell!");
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
