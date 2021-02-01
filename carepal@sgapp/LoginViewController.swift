//
//  LoginViewController.swift
//  carepal@sgapp
//
//  Created by Goh Qi Xun on 25/1/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        //var price = [1.45,2.10,3.50,5.0,1.2,0.9,6.0,1.2]
        database.child("Storage").child("Ayam Brand Baked Beans").setValue(["Price": 1.45, "Quantity": 318])
        database.child("Storage").child("Ayam Brand Tuna").setValue(["Price": 2.10, "Quantity": 83])
        database.child("Storage").child("Xiang Men Peanut").setValue(["Price": 3.50, "Quantity": 2812])
        database.child("Storage").child("HOSEN Mushroom").setValue(["Price": 5.0, "Quantity": 289])
        database.child("Storage").child("HOSEN Longan").setValue(["Price": 1.2, "Quantity": 391])
        database.child("Storage").child("HOSEN Rambutan").setValue(["Price": 1.5, "Quantity": 2981])

    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let email = emailTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if email == "" || password == "" {
            self.alert(message: "Please fill in all empty field", title: "Empty Field")
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil
            {
                //Wrong password or no such account
                self.alert(message: error!.localizedDescription, title: "Unable to login")
            }
            else
            {
                self.performSegue(withIdentifier: "temp", sender: self)
                //Login successful check if user done profile or details anot. If haven, redirect them to that page and continue
                self.database.child("users").child((result?.user.uid)!).observeSingleEvent(of: .value) { (snapshot) in
                    //print(snapshot.value)
//                    if snapshot.hasChild("allergy") == false
//                    {
//                        self.performSegue(withIdentifier: "LoginTo2", sender: self)
//                    }
//                    else if snapshot.hasChild("dietary") == false
//                    {
//                        self.performSegue(withIdentifier: "LoginTo3", sender: self)
//                    }
//                    else if snapshot.hasChild("medical") == false
//                    {
//                        self.performSegue(withIdentifier: "LoginTo4", sender: self)
//                    }
//                    else if snapshot.hasChild("heightandweight") == false
//                    {
//                        self.performSegue(withIdentifier: "LoginTo5", sender: self)
//                    }
//                    else if snapshot.hasChild("Contact") == false
//                    {
//                        self.performSegue(withIdentifier: "LoginToProfile", sender: self)
//                    }
//                    else
//                    {
//                        //Go Home
//                    }
                }
            }
        }
    }
    
    func alert(message: String, title:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        performSegue(withIdentifier: "loginToSignUp", sender: nil)
    }
    
}
