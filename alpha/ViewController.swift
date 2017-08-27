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
    
    @IBOutlet weak var segmentControll: UISegmentedControl!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    
    var isSignin: Bool = true
    
    @IBOutlet weak var invalidLabel: UILabel!
    
    @IBAction func logInButton(_ sender: Any) {
//        print("\(emailField.text!) + \(passwordField.text!)")
        if let email = emailField.text, let pass = passwordField.text
        {
            if isSignin  {
                FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: { (user, error) in
                    if let u = user {
                        //user is logging in
                        self.performSegue(withIdentifier: "welcomeHome", sender: self)
                        print("worked")
                    } else {
                        //check error
                        self.invalidLabel.isHidden = false
                        print("error")
                    }
                })
            } else {
                FIRAuth.auth()?.createUser(withEmail: email, password: pass, completion: { (user, error) in
                    if let u = user {
                        //create new user
                        self.performSegue(withIdentifier: "welcomeHome", sender: self)
                          print("worked")
                    } else {
             self.invalidLabel.isHidden = false
                        print("error")
                    }
                })
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        invalidLabel.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func logInorRegister(_ sender: Any) {
        isSignin = !isSignin
        if isSignin {
            logInButton.setTitle("Log In", for: UIControlState.normal)
        } else {
            logInButton.setTitle("Register", for: UIControlState.normal)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

