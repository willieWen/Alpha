//
//  ViewController.swift
//  alpha
//
//  Created by william on 8/8/17.
//  Copyright © 2017 EWApps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var invalidLabel: UILabel!
    
    @IBAction func logInButton(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if let firebaseError = error {
                    self.invalidLabel.text = firebaseError.localizedDescription
                    return
                }
                self.presentLoggedInScreen()
                print("success!")
            })
        }
    }
    
    @IBAction func createAccount(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if let firebaseError = error {
                    self.invalidLabel.text =  (firebaseError.localizedDescription)
                    return
                }
                self.presentLoggedInScreen()
                print("success!")
            })
        }
    }
    
    func presentLoggedInScreen() {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainView:MainView = storyBoard.instantiateViewController(withIdentifier: "MainView") as! MainView
        self.present(mainView, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        invalidLabel.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
}

