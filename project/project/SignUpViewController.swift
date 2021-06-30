//
//  SignUpViewController.swift
//  project
//
//  Created by Ling on 6/16/21.
//  Copyright © 2021 tranthihoaitrang. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirmed: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.loadGif(name: "writing1");

        // Delegation:
        username.delegate = self;
        password.delegate = self;
        passwordConfirmed.delegate = self;
    }
    
    //MARK: Hiding keyboard after tap "done":
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    //MARK: Hiding keyboard:
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    // Sign up:
    @IBAction func btnSignUpTapped(_ sender: Any) {
        let u = username.text ?? "";
        let p = password.text ?? "";
        let pc = passwordConfirmed.text ?? "";
        
        // Check for empty fields:
        if u.isEmpty || p.isEmpty || pc.isEmpty {
            displayAlertMessage(msg: "All fields are required!");
            return;
        }
        
        // Check if passwords match:
        if p != pc {
            displayAlertMessage(msg: "Passwords do not match!");
            return;
        }
        
        // (SIGN UP) Store data:
        let ref = Database.database().reference();
        ref.child("accounts").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                if let accounts = snapshot.value as? [Any] {
                    if accounts.count > 0 {
                        ref.child("accounts/\(accounts.count+1)").setValue(["username": u, "password": p]);
                    }
                }
            }
            else {
                DispatchQueue.main.async {
                    ref.child("accounts/0").setValue(["username": u, "password": p]);
                }
            }
        }
        
        // Notification:
        let alert = UIAlertController(title: "Alert", message: "Registration is successful!", preferredStyle: UIAlertController.Style.alert);
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) in
            self.dismiss(animated: true, completion: nil);
        }
        alert.addAction(okAction);
        self.present(alert, animated: true, completion: nil);
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
