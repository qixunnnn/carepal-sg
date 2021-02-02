//
//  Quiz2ViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 24/1/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class Quiz2ViewController: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
    
    //title divided into two TF(label)
    @IBOutlet weak var progressPV: UIProgressView!
    @IBOutlet weak var specialTF: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var dietaryTF: UILabel!
    
    @IBOutlet weak var vegetarainTF: UILabel!
    @IBOutlet weak var vegetarainBtn: UIButton!
    @IBOutlet weak var veganTF: UILabel!
    @IBOutlet weak var veganBtn: UIButton!
    @IBOutlet weak var porkTF: UILabel!
    @IBOutlet weak var beefTF: UILabel!
    @IBOutlet weak var porkBtn: UIButton!
    @IBOutlet weak var beefBtn: UIButton!
    
    let database = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        progressPV.progress = 0.2
        overrideUserInterfaceStyle = .light
        
    
        
        nextBtn.setTitle(TranslateText.quiz1btnTxt, for: .normal)
        
        // Do any additional setup after loading the view.
    }
   
    @IBAction func NextBtn(_ sender: Any) {
        
        var vegetarian:String = "nil"
        var vegan:String = "nil"
        var pork:String = "nil"
        var beef:String = "nil"
        
        if(vegetarainBtn.isSelected){
            vegetarian = "true"
        }
        if(veganBtn.isSelected){
            vegan = "true"
        }
        if(porkBtn.isSelected){
            pork = "true"
        }
        if(beefBtn.isSelected){
            beef = "true"
        }
        let Details: [String: Any] = [
            "vegetarian":vegetarian as NSString,
            "vegan": vegan as NSString,
            "pork": pork as NSString,
            "beef": beef as NSString]
        
        self.database.child("users").child(userID!).child("dietary").setValue(Details)

        performSegue(withIdentifier: "q2", sender: nil)
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
