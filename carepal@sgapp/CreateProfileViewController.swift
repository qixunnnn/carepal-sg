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
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
    
    let database = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
            database.child("users").child(userID!).setValue(["FirstName" : firstName! as NSString, "LastName":lastName! as NSString, "Contact": cNo! as NSString, "Points": 888 as NSNumber, "allowance": 300]){(error: Error?, ref:DatabaseReference) in
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
   
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardAdjusted == false {
            lastKeyboardOffset = getKeyboardHeight(notification: notification)
            view.frame.origin.y -= lastKeyboardOffset
            keyboardAdjusted = true
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardAdjusted == true {
            view.frame.origin.y += lastKeyboardOffset
            keyboardAdjusted = false
        }
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
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
