//
//  ForgotPasswordController.swift
//  alpha
//
//  Created by william on 4/9/17.
//  Copyright © 2017 EWApps. All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgotPasswordController : UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
/*    @IBAction func resetTapped(_ sender: Any) {
        let email = emailTextField.text
        FIRAuth.auth()?.sendPasswordReset(withEmail: email!, completion: { (error) in
            if error == nil {
          //  self.resultLabel.text = "An email to reset your password has been sent to you"
            } else {
          //  self.resultLabel.text = error?.localizedDescription
            }
        })
        
    }
    
    */
    @IBAction func backToLoginTapped(_ sender: Any) {
    }
    
}
