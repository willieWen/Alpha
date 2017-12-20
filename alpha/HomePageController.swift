//
//  HomePageController.swift
//  alpha
//
//  Created by william on 27/8/17.
//  Copyright © 2017 EWApps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomePageController: UIViewController {
    
    @IBOutlet weak var logOutTapped: UIButton!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    var ref:DatabaseReference!
    var refHandle: UInt!
    var fileUploadManager = FileUploadManager()
    
    @IBAction func logOutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
            //self.dismiss(animated: true, completion: nil)
            let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let logInPage:ViewController = storyBoard.instantiateViewController(withIdentifier: "LogInViewController") as! ViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = logInPage
            dismiss(animated: true, completion: nil)
            
        } catch{
            print("There was a problem logging out")
        }
    }
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
            let dataDict = snapshot.value as! [String: AnyObject]
        })
        let userID: String = (Auth.auth().currentUser?.uid)!
        ref.child("Users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? [String:AnyObject] {
                let email = value["Email"] as! String
                self.emailLabel.text = email

            }
        })

    }
}
