//
//  ReadersTableViewController.swift
//  project
//
//  Created by Ling on 6/6/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import UIKit

class ReadersTableViewController: UITableViewController, UISearchBarDelegate {
    // Properties:
    enum NavigationType {
        case addNewReader
        case updateReader
    }
    var navigationType: NavigationType = .addNewReader;
    var filteredReaders = [Reader]();
    
    @IBOutlet weak var searchBar: UISearchBar!
    

    // First load:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredReaders = ReadersManagement.readers;
        
        // Delegation:
        searchBar.delegate = self;

        // self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.title = "Readers";
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
        return filteredReaders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ReadersTableViewCell", for: indexPath) as? ReadersTableViewCell {
            
            let reader = filteredReaders[indexPath.row];
            cell.readerName.text = reader.readerName;
            var count: Int = 0;
            for rb in ReaderBooksManagement.readerBooks {
                if rb.readerID == reader.readerID {
                    count = count + rb.quantity;
                }
            }
            cell.booksBorrowed.text = String(count);
            
            if count > 0 {
                cell.condition.text = "is borrowing";
                cell.condition.textColor = UIColor.green;
            }
            else {
                cell.condition.text = "inactive";
                cell.condition.textColor = UIColor.red;
            }
            
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
            for i in 0...ReadersManagement.readers.count-1 {
                if ReadersManagement.readers[i].readerID == filteredReaders[indexPath.row].readerID {
                    ReadersManagement.readers.remove(at: i);
                    break;
                }
            }
            // Delete the row from filteredReaders:
            filteredReaders.remove(at: indexPath.row);
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
            let destinationController = segue.destination as? ReaderDetailController
            
            if segueName == "AddNewReaderSegue" {
                navigationType = .addNewReader;
                // Set navigationType of destination:
                if destinationController != nil {
                    destinationController?.navigationType = .addNewReader;
                }
            }
            else if segueName == "UpdateReaderSegue" {
                navigationType = .updateReader;
                var r: Reader? = nil;
                if let selectedRow = tableView.indexPathForSelectedRow?.row {
                    print(">> Selected row: \(selectedRow)")
                    r = filteredReaders[selectedRow];
                }
                // Set navigationType of destination:
                if destinationController != nil {
                    destinationController!.reader = r!;
                    destinationController?.navigationType = .updateReader;
                }
            }
        }
        else {
            print("You must define identifier for segue!")
        }
    }
    
    
    
    @IBAction func unwind_toReaders(sender: UIStoryboardSegue) {
        if let sourceController = sender.source as? ReaderDetailController,
            let r = sourceController.reader {
            
            // Indentify route:
            if navigationType == .addNewReader {
                // Update filteredReaders:
                filteredReaders.append(r);
                // Update data model:
                ReadersManagement.readers.append(r);
                // Reload table:
                tableView.reloadData();
            }
            else if navigationType == .updateReader {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    // Update filteredReaders:
                    filteredReaders[selectedIndexPath.row] = r;
                    // Update data model:
                    for i in 0...ReadersManagement.readers.count-1 {
                        if r.readerID == ReadersManagement.readers[i].readerID {
                            ReadersManagement.readers[i] = r;
                        }
                    }
                    // Reload table:
                    tableView.reloadData();
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredReaders = [];
        
        if searchText == "" {
            filteredReaders = ReadersManagement.readers;
        }
        else {
            for r in ReadersManagement.readers {
                if r.readerName.lowercased().contains(searchText.lowercased()) {
                    filteredReaders.append(r);
                }
            }
        }
        self.tableView.reloadData();
    }
}
