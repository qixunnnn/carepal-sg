//
//  SignUpViewController.swift
//  carepal@sgapp
//
//  Created by Goh Qi Xun on 25/1/21.
//

import UIKit
import Foundation
import FirebaseAuth
import Firebase
import FirebaseDatabase

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var reEnterTxt: UITextField!
    
    private let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
    }
    
    func validateFields() -> String? {
        
        if emailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || reEnterTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        else if(passwordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) != reEnterTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)){
            return "Password and re-type password does not match"
            
        }
        let cleanedPassword = passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isPasswordValid(cleanedPassword) == false
        {
            //Password isn't secure enough
            return "Password must contains characters and one special characters and is minimum six char long."
        }
        
        return nil
    }
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        let error = validateFields()
        
        if error != nil {
            alert(message: error!, title: "Failed to create")
        }
        else
        {
            Auth.auth().createUser(withEmail: emailTxt.text!, password: passwordTxt.text!) { (result, error) in
                // Check for errors
                if let error = error
                {
                    //Got error creating user
                    print(error.localizedDescription)
                    //self.alert(message: error.localizedDescription, title: "Failed to create")
                }
                else
                {
                    
                    //User will be created and store in firebase
                    let userInfo: [String: Any] = [
                        "FirstName":"nil" as NSString,
                        "LastName": "nil" as NSString,
                        "Contact": "nil" as NSString,
                        "Points": 0 as NSNumber]
                    
                    self.database.child("users").setValue(result!.user.uid)
                    self.database.child("users").child(result!.user.uid).setValue(userInfo)
                    
                    self.performSegue(withIdentifier: "mySegueID", sender: nil)
                }
            }
        }
        
    }
    
    func isPasswordValid(_ password : String) -> Bool
    {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
        //check if password contains characters and one special characters and is minimum six char long.
        return passwordTest.evaluate(with: password)
    }
    
    func alert(message: String, title:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
}
