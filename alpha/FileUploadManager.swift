//
//  FileUploadManager.swift
//  alpha
//
//  Created by william on 2/10/17.
//  Copyright © 2017 EWApps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

struct Constants {
    struct profileImages {
        static let imagesFolder: String = "profileImage"
    }
}

class FileUploadManager: NSObject {
    
    func uploadImage(_ image: UIImage, progressBlock: @escaping (_ percentage: Double) -> Void, completionBlock: @escaping (_ url:URL?, _ errorMessage:String?) -> Void) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let imageName = "\(Date().timeIntervalSince1970).jpg"
        let imagesReference = storageReference.child(Constants.profileImages.imagesFolder).child(imageName)
        
        if let imageData = UIImageJPEGRepresentation(image, 0.8) {
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
            
            let uploadTask = imagesReference.putData(imageData, metadata: metaData, completion: { (metaData, error) in
                if let metaData = metaData {
                    completionBlock(metaData.downloadURL(), nil)
                }else {
                    completionBlock(nil, error?.localizedDescription)
                }
                
            })
            uploadTask.observe(.progress, handler: { (snapshot) in
                guard let progress = snapshot.progress else {
                    return
                }
                
                let percentage = (Double(progress.completedUnitCount) / Double(progress.totalUnitCount)) * 100
                progressBlock(percentage)
            })
            
            
        } else {
            completionBlock(nil, "Image could not be converted to Data")
        }
        
    }
    
}
