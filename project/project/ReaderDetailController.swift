//
//  ReaderDetailController.swift
//  project
//
//  Created by Ling on 6/6/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import UIKit

class ReaderDetailController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    // Properties:
    enum NavigationType {
        case addNewReader
        case updateReader
    }
    var navigationType: NavigationType = .addNewReader;
    public var reader: Reader?;
    var readerBooks = [ReaderBooks]();
    var booksBorrowed = [Book]();
    
    @IBOutlet weak var readerID: UITextField!
    @IBOutlet weak var readerName: UITextField!
    @IBOutlet weak var readerPhone: UITextField!
    @IBOutlet weak var readerEmail: UITextField!
    @IBOutlet weak var booksTableView: UITableView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    @IBOutlet weak var lblForTableView: UILabel!
    
    
    
    // First load:
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Reader's detail";
        btnSave.isEnabled = false;
        if navigationType == .addNewReader {
            readerID.isEnabled = true;
            lblForTableView.text = "";
        }
        else {
            readerID.isEnabled = false;
            lblForTableView.text = "Books borrowed:";
        }
        
        // Delegation:
        readerID.delegate = self;
        readerName.delegate = self;
        readerPhone.delegate = self;
        readerEmail.delegate = self;
        
        // Get reader to updated from ReadersTableViewController if it exists:
        if let r = self.reader {
            readerID.text = String(r.readerID);
            readerName.text = r.readerName;
            readerPhone.text = r.readerPhone;
            readerEmail.text = r.readerEmail;
            
            // Books borrowed from library:
            for rb in ReaderBooksManagement.readerBooks {
                if rb.readerID == r.readerID {
                    if let b = BooksManagement.getBookByID(id: rb.bookID) {
                        self.readerBooks.append(rb);
                        self.booksBorrowed.append(b);
                    }
                }
            }
        }
    }
    
    // Methods:
    
    //MARK: Hiding keyboard after tap "done":
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    //MARK: Hiding keyboard:
    func textFieldDidEndEditing(_ textField: UITextField) {
        if navigationType == .addNewReader {
            checkIfSaveBtnIsEnabledAfterAdding();
        }
        else {
            checkIfSaveBtnIsEnabledAfterUpdating();
        }
    }
    
    // When text changes:
    @IBAction func readerIDChanged(_ sender: Any) {
        if navigationType == .addNewReader {
            checkIfSaveBtnIsEnabledAfterAdding();
        }
    }
    
    @IBAction func readerPhoneChanged(_ sender: Any) {
        if navigationType == .addNewReader {
            checkIfSaveBtnIsEnabledAfterAdding();
        }
        else {
            checkIfSaveBtnIsEnabledAfterUpdating();
        }
    }
    
    
    // Check text fields after enabling btnSave:
    func checkIfSaveBtnIsEnabledAfterAdding() {
        var isEnabled = true;
        if readerID.text != "" && readerName.text != "" && readerPhone.text != "" && readerEmail.text != "" {
            // Check id and phone:
            for r in ReadersManagement.readers {
                if r.readerID == Int(readerID.text ?? "0") {
                    isEnabled = false;
                    message.text = "This ID already exists!";
                    break;
                }
            }
            // Check number:
            if Int64(readerPhone.text ?? "") != nil {}
            else {
                isEnabled = false;
                message.text = "Invalid phone number!";
            }
            // Message:
            if isEnabled == true {
                message.text = "";
            }
        }
        else {
            message.text = "All fields must contain values!";
            isEnabled = false;
        }
        btnSave.isEnabled = isEnabled;
    }
    
    func checkIfSaveBtnIsEnabledAfterUpdating() {
        var isEnabled = true;
        if readerID.text != "" && readerName.text != "" && readerPhone.text != "" && readerEmail.text != "" {
            // Check number:
            if Int64(readerPhone.text ?? "") != nil {}
            else {
                isEnabled = false;
                message.text = "Invalid phone number!";
            }
            // Message:
            if isEnabled == true {
                message.text = "";
            }
        }
        else {
            message.text = "All fields must contain values!";
            isEnabled = false;
        }
        btnSave.isEnabled = isEnabled;
    }
    
    
    
    // Cancel button:
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        if navigationType == .addNewReader {
            dismiss(animated: true, completion: nil);
        }
        else if navigationType == .updateReader {
            navigationController?.popViewController(animated: true);
        }
    }
    
    
    
    // TableView:
    // (Import: UITableViewDataSource, UITableViewDelegate).
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.booksBorrowed.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.booksTableView.dequeueReusableCell(withIdentifier: "BooksBorrowedTableViewCell", for: indexPath) as? BooksBorrowedTableViewCell {
            
            let b = self.booksBorrowed[indexPath.row];
            let rb = self.readerBooks[indexPath.row];
            cell.bookID.text = String(b.bookID);
            cell.bookName.text = b.bookName;
            cell.bookQuantity.text = String(rb.quantity);
            cell.bookQuantity.isEnabled = false;
            cell.bookImage.image = b.bookImage;
            
            return cell;
        }
        else {
            fatalError("Cannot create cell!");
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender);
        if let btn = sender as?  UIBarButtonItem {
            
            if btn === btnSave {
                let id = Int(readerID.text ?? "0");
                let name = readerName.text ?? "";
                let phone = readerPhone.text ?? "";
                let email = readerEmail.text ?? "";
                
                self.reader = Reader(id: id!, name: name, phone: phone, email: email);
            }
        }
    }

}
