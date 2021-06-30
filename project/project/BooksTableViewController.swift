//
//  BooksTableViewController.swift
//  project
//
//  Created by Ling on 6/4/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import UIKit

class BooksTableViewController: UITableViewController, UISearchBarDelegate {
    // Properties:
    enum NavigationType {
        case addNewBook
        case updateBook
    }
    var navigationType: NavigationType = .addNewBook;
    var filteredBooks = [Book]();
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // First load:
    override func viewDidLoad() {
        super.viewDidLoad();
        
        filteredBooks = BooksManagement.books;
        
        // Delegation:
        searchBar.delegate = self;

        // self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.title = "Books";
        self.navigationItem.rightBarButtonItems?.append(editButtonItem);
    }
    
    // Methods:
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil);
    }
    
    
    
    
    
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredBooks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell", for: indexPath) as? BooksTableViewCell {
            
            let book = filteredBooks[indexPath.row];
            cell.bookImage.image = book.bookImage;
            cell.bookName.text = book.bookName;
            cell.bookAuthors.text = book.bookAuthors;
            cell.bookQuantity.text = String(book.bookQuantity);
            cell.bookQuantityCurrent.text = String(book.bookQuantityCurrent);
            return cell;
        }
        else {
            fatalError("Cannot create cell!");
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from data model:
            for i in 0...BooksManagement.books.count-1 {
                if BooksManagement.books[i].bookID == filteredBooks[indexPath.row].bookID {
                    BooksManagement.books.remove(at: i);
                    break;
                }
            }
            // Delete the row from filteredBooks:
            filteredBooks.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade);
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender);

        if let segueName = segue.identifier {
            let destinationController = segue.destination as? BookDetailController

            if segueName == "AddNewBookSegue" {
                navigationType = .addNewBook;
                // Set navigationType of destination:
                if destinationController != nil {
                    destinationController?.navigationType = .addNewBook;
                }
            }
            else if segueName == "UpdateBookSegue" {
                navigationType = .updateBook;
                var b: Book? = nil;
                if let selectedRow = tableView.indexPathForSelectedRow?.row {
                    print(">> Selected row: \(selectedRow)")
                    b = filteredBooks[selectedRow];
                }
                // Set navigationType of destination:
                if destinationController != nil {
                    destinationController!.book = b!;
                    destinationController?.navigationType = .updateBook;
                }
            }
        }
        else {
            print("You must define identifier for segue!")
        }
    }

    
    
    @IBAction func unwind_toBooks(sender: UIStoryboardSegue) {
        // Get data from BookDetailController:
        if let sourceController = sender.source as? BookDetailController,
            let b = sourceController.book {
            
            // Indentify route:
            if navigationType == .addNewBook {
                // Update filteredBooks:
                filteredBooks.append(b);
                // Update data model:
                BooksManagement.books.append(b);
                // Reload table:
                tableView.reloadData();
            }
            else if navigationType == .updateBook {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    // Update filteredBooks:
                    filteredBooks[selectedIndexPath.row] = b;
                    // Update data model:
                    for i in 0...BooksManagement.books.count-1 {
                        if b.bookID == BooksManagement.books[i].bookID {
                            BooksManagement.books[i] = b;
                        }
                    }
                    // Reload table:
                    tableView.reloadData();
                }
            }
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredBooks = [];
        
        if searchText == "" {
            filteredBooks = BooksManagement.books;
        }
        else {
            for b in BooksManagement.books {
                if b.bookName.lowercased().contains(searchText.lowercased()) {
                    filteredBooks.append(b);
                }
            }
        }
        self.tableView.reloadData();
    }
}
