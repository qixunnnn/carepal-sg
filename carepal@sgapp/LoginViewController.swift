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
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
    
    let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        //var price = [1.45,2.10,3.50,5.0,1.2,0.9,6.0,1.2]

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
                
                //Login successful check if user done profile or details anot. If haven, redirect them to that page and continue
                self.database.child("users").child((result?.user.uid)!).observeSingleEvent(of: .value) { (snapshot) in
                    //print(snapshot.value)
                    if snapshot.hasChild("Contact") == false
                                        {
                                            self.performSegue(withIdentifier: "LoginToProfile", sender: self)
                                        }
                                        else if snapshot.hasChild("allergy") == false
                                        {
                                            self.performSegue(withIdentifier: "LoginTo2", sender: self)
                                        }
                                        else if snapshot.hasChild("dietary") == false
                                        {
                                            self.performSegue(withIdentifier: "LoginTo3", sender: self)
                                        }
                                        else if snapshot.hasChild("medical") == false
                                        {
                                            self.performSegue(withIdentifier: "LoginTo4", sender: self)
                                        }
                                        else if snapshot.hasChild("heightandweight") == false
                                        {
                                            self.performSegue(withIdentifier: "LoginTo5", sender: self)
                                        }
                                        else if snapshot.hasChild("Contact") == false
                                        {
                                            self.performSegue(withIdentifier: "LoginToProfile", sender: self)
                                        }
                                        else
                                        {
                                            //Go Home
                                            self.performSegue(withIdentifier: "home", sender: self)
                                        }
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
