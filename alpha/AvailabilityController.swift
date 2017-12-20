//
//  AvailabilityController.swift
//  alpha
//
//  Created by william on 29/9/17.
//  Copyright © 2017 EWApps. All rights reserved.
//

import UIKit
import Firebase


class AvailabilityController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var dateField: UITextField!
    
    @IBAction func update(_ sender: Any) {
        updateDate()
    }
    
    @IBOutlet weak var hourField: UITextField!
    @IBOutlet weak var tblView: UITableView!
    
    var availabilityRef: DatabaseReference!
    var availabilityList = [AvaialabilityModel]()
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let available = availabilityList[indexPath.row]
        
        
        let alertController = UIAlertController(title: available.date, message: "Give new value to update the date", preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "Update", style: .default) { (_) in
            let id = available.id
            
            let date = alertController.textFields?[0].text
            let time = alertController.textFields?[1].text
            
            self.updateDateTime(id: id!, date: date!, time: time!)
            
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (_) in
            self.deleteArtist(id: available.id!)
        }
        
        alertController.addTextField { (textField) in
            textField.text = available.date
        }
        alertController.addTextField { (textField) in
            textField.text = available.time
        }
        
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func updateDateTime(id: String, date: String, time: String){
        let available = [
        "id": id,
        "Date": date,
        "Time": time
        ]
        
        availabilityRef.child(id).setValue(available)
        
    }
    
    func deleteArtist(id:String){
        availabilityRef.child(id).setValue(nil)
    }


    override func viewDidLoad() {
        availabilityRef = Database.database().reference().child("Avaialabilities")
        
        availabilityRef.observe(.value, with: {(snapshot) in
            if snapshot.childrenCount > 0 {
                self.availabilityList.removeAll()
                
                for availabilities in snapshot.children.allObjects as![DataSnapshot]{
                    let available = availabilities.value as? [String: AnyObject]
                    let date = available?["Date"]
                    let time = available?["Time"]
                    let id = available?["id"]
                    
                    let available1 = AvaialabilityModel(id: id as! String?, date: date as! String?, time: time as! String?)
                    
                    self.availabilityList.append(available1)
                }
            
                self.tblView.reloadData()
            }
            
        })
    }
    
        func updateDate() {
            let key = availabilityRef.childByAutoId().key
            
            let availability = ["id":key,
                                "Date": dateField.text! as String,
                                "Time": hourField.text! as String
               
            ]
            availabilityRef.child(key).setValue(availability)
            
        }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availabilityList.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! availabilityTableViewCell
        let available: AvaialabilityModel
        available = availabilityList[indexPath.row]
        cell.dateLabel.text = available.date
        cell.timeLabel.text = available.time
        
        return cell
        
    }
    
}
