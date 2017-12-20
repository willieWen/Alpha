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
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var invalidLabel: UILabel!
    
    var ref : DatabaseReference!
    
    @IBAction func logInButton(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
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
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                if let firebaseError = error {
                    self.invalidLabel.text =  (firebaseError.localizedDescription)
                    return
                }
                let userID:String = user!.uid
                let userEmail:String = self.emailField.text!
                let userPassword:String = self.passwordField.text!
                
                self.ref.child("Users").child(userID).setValue(["Email":userEmail, "Password": userPassword])
                print("User registered with firebase with uid of" + user!.uid)
                self.presentLoggedInScreen()
            })
        }
    }
    
    func presentLoggedInScreen() {
    /*  let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homePage:HomePageController = storyBoard.instantiateViewController(withIdentifier: "HomePage") as! HomePageController
        self.present(homePage, animated: true, completion: nil)
    */
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = tabBarController
    }
    
    @IBAction func forgotTapped(_ sender: Any) {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let forgotPage:ForgotPasswordController = storyBoard.instantiateViewController(withIdentifier: "forgotPassword") as! ForgotPasswordController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = forgotPage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

