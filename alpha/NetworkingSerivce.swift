//
//  NetworkingSerivce.swift
//  alpha
//
//  Created by william on 17/9/17.
//  Copyright © 2017 EWApps. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseStorage

struct networkingService {
    
    let databaseRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()
    
    private func saveInfo(user: FIRUser!, username: String, password: String, country: String) {
    //create user dictionary info
        let userInfo = ["email": user.email!, "username": username, "country": country, "uid": user.uid, "photoUrl": String(describing: user.photoURL!)]
    //create user reference
        let userRef = databaseRef.child("users").child(user.uid)
    //save the user info in database
        userRef.setValue(userInfo)
    //signing user
        signIn(email: user.email!, password: password)
    }
    
    func signIn(email: String, password: String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                print("\(user?.displayName!) has signed in succesfully")
            }
            else {
                print(error?.localizedDescription)
            }
        })
    }
    
    private func setUserInfo(user: FIRUser, username: String, password: String, country: String, data: NSData!) {
        //create path for image
        let imagePath = "profileImage\(user.uid)/userPic.jpg"
        // create image reference
        let imageRef = storageRef.child(imagePath)
        //create metaData for the image
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        //save the user image in the firebase storage file
        imageRef.put(data as Data, metadata: metaData) { (metaData, error) in
            if error == nil {
                    let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = username
                changeRequest.photoURL = metaData?.downloadURL()
                changeRequest.commitChanges(completion: { (error) in
                    if error == nil {
                        self.saveInfo(user: user, username: username, password: password, country: country)
                    } else {
                         print(error?.localizedDescription)
                    }
                })
            } else {
              print(error?.localizedDescription)
            }
        }
    }
    

}













