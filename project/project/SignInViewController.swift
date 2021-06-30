//
//  SignInViewController.swift
//  project
//
//  Created by Ling on 6/16/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.loadGif(name: "writing2");
        
        btnSignUp.setTitle("", for: .normal);
        btnSignUp.isEnabled = false;

        // Delegation:
        username.delegate = self;
        password.delegate = self;
    }
    
    //MARK: Hiding keyboard after tap "done":
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    //MARK: Hiding keyboard:
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    // Sign in:
    @IBAction func btnSignInTapped(_ sender: Any) {
        let u = username.text ?? "";
        let p = password.text ?? "";
        
        // Check for empty fields:
        if u.isEmpty || p.isEmpty {
            displayAlertMessage(msg: "You must enter your username and password!");
            return;
        }
        
        // (SIGN IN) Check username and password:
        let ref = Database.database().reference();
        ref.child("accounts").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                if let accounts = snapshot.value as? [Any] {
                    for acc in accounts {
                        if let i = acc as? [String: AnyObject] {
                            let i_u = i["username"] as! String;
                            let i_p = i["password"] as! String;
                            
                            // Sign in successfully or not:
                            if u == i_u && p == i_p {
                                DispatchQueue.main.async {
                                    if let acc = Account(username: u, password: p) {
                                        AccountsManagement.accounts.removeAll();
                                        AccountsManagement.accounts.append(acc);
                                        self.dismiss(animated: true, completion: nil);
                                    }
                                }
                            }
                        }
                    }
                    // If there is no account that matches input:
                    DispatchQueue.main.async {
                        self.displayAlertMessage(msg: "Incorrect username or password!");
                    }
                }
            }
            else {
                print("No data available")
            }
        }
    }
    
    // Alert:
    func displayAlertMessage(msg: String) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert);
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default , handler: nil);
        alert.addAction(okAction);
        self.present(alert, animated: true, completion: nil);
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }*/

}
