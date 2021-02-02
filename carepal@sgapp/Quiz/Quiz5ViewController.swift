//
//  Quiz5ViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 24/1/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class Quiz5ViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    //title divided into two TF(label)
    @IBOutlet weak var heightTF: UILabel!
    @IBOutlet weak var weightTF: UILabel!
    @IBOutlet weak var weightBtn: UITextField!
    @IBOutlet weak var heightBtn: UITextField!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var bmiTF: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var progressPV: UIProgressView!
    
    let database = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
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
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height - 150
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
    @IBAction func weightBtn(_ sender: Any) {
        if(heightBtn.text == "" || weightBtn.text == "")
        {
            
        }
        else
        {
            let w = Double(weightBtn.text!)!
            let h = Double(heightBtn.text!)! / 100
            bmiTF.text = String(format: "%.2f",w/(h * 2))
        }
    }
    @IBAction func heightBtn(_ sender: Any) {
        if(heightBtn.text == "" || weightBtn.text == "")
        {
            
        }
        else
        {
            let w = Double(weightBtn.text!)!
            let h = Double(heightBtn.text!)! / 100
            bmiTF.text = String(format: "%.2f",w/(h * h))
        }
    }
    
    @IBAction func DoneBtn(_ sender: Any) {
        let error = validateFields()
        
        if error == "" {
            self.alert(message: error, title: "Please try again")
        }
        else
        {
            let Details: [String: Any] = [
                "height": heightTF.text! as NSString,
                "weight": weightTF.text! as NSString,
                "bmi": bmiTF.text! as NSString]
            
            self.database.child("users").child(userID!).child("heightandweight").setValue(Details)
            performSegue(withIdentifier: "q5", sender: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        progressPV.progress = 0.8
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func alert(message: String, title:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    func validateFields() -> String{
        
        if heightTF.text! == "" || weightTF.text! == ""
        {
            return "Please fill in all fields"
        }
        return ""
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
