//
//  ProfileViewController.swift
//  alpha
//
//  Created by william on 19/9/17.
//  Copyright © 2017 EWApps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ProfileViewController: UIViewController {
    
    var ref:DatabaseReference!
    var refHandle: UInt!
    var fileUploadManager = FileUploadManager()
    
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var contactNumber: UILabel!
    
    @IBOutlet var profileImage: UIImageView!

    @IBOutlet weak var emailField: UILabel!
    
    @IBOutlet weak var passwordField: UILabel!
    
    
    override func viewDidLoad() {
       profileImage.layer.cornerRadius = 25
        ref = Database.database().reference()
        refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
            let dataDict = snapshot.value as! [String: AnyObject]
        })
        let userID: String = (Auth.auth().currentUser?.uid)!
        ref.child("Users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? [String:AnyObject] {
                let email = value["Email"] as! String
                let password = value["Password"] as! String
                self.emailField.text = email
                self.passwordField.text = password
                self.passwordField.text = String(password.characters.map { _ in return "*" })
                print(email + " " + password)
            }
        })
        
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        profileImage.isUserInteractionEnabled = true
    }

}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleSelectProfileImageView() {
        print("tapped")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            picker.dismiss(animated: true, completion: nil)
          fileUploadManager.uploadImage(image, progressBlock: { (percentage) in
            print(percentage)
            self.profileImage.image = image
          }, completionBlock: { (fileUrl, errorMessage) in
            print(fileUrl)
            print(errorMessage)
            
            
            })
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelled picker")
        dismiss(animated: true, completion: nil)
}
}

