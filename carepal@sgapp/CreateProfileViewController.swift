//
//  CreateProfileViewController.swift
//  carepal@sgapp
//
//  Created by Goh Qi Xun on 26/1/21.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class CreateProfileViewController: UIViewController {
    @IBOutlet weak var fNameTxt: UITextField!
    @IBOutlet weak var lNameTxt: UITextField!
    @IBOutlet weak var contactTxt: UITextField!
    
    let database = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        if userID == nil {
            performSegue(withIdentifier: "profileViewToLogin", sender: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    func validateField() -> String?{
        
        if fNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || contactTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        return nil
    }
    
    @IBAction func createBtn(_ sender: Any) {
        
        let error = validateField()
        
        let firstName = fNameTxt.text
        let lastName = lNameTxt.text
        let cNo = contactTxt.text
        
        if error != nil {
            alert(message: error!, title: "Cannot create profile")
        }
        else
        {
            database.child("users").child(userID!).setValue(["FirstName" : firstName! as NSString, "LastName":lastName! as NSString, "Contact": cNo! as NSString, "Points": 0 as NSNumber]){(error: Error?, ref:DatabaseReference) in
                if let error = error{
                    print("Data could not be saved: \(error).")
                }
                else
                {
                    print("Data saved successfully")
                    self.performSegue(withIdentifier: "ProfileToSurvey", sender: self)
                }
            }
        }
    }
        
    func alert(message: String, title:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
