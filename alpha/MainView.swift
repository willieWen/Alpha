//
//  MainView.swift
//  alpha
//
//  Created by william on 27/8/17.
//  Copyright © 2017 EWApps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MainView: UIViewController {
    
    @IBAction func logOutTapped(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
            
            self.dismiss(animated: true, completion: nil)
        } catch{
            print("There was a problem logging out")
        }
    }
}
