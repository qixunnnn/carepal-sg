//
//  Quiz3ViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 24/1/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class Quiz3ViewController: UIViewController {

    @IBOutlet weak var allergyTF: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var dairyBtn: CheckBox!
    @IBOutlet weak var dairyTF: UILabel!
    @IBOutlet weak var fishTF: UILabel!
    @IBOutlet weak var fishBtn: CheckBox!
    @IBOutlet weak var nutsBtn: CheckBox!
    @IBOutlet weak var nutsTF: UILabel!
    @IBOutlet weak var gluttonTF: UILabel!
    @IBOutlet weak var gluttonBtn: CheckBox!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var progressPV: UIProgressView!
    
    let database = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    
    @IBAction func NextBtn(_ sender: Any) {
        
        var dairy:String = "nil"
        var fish:String = "nil"
        var nuts:String = "nil"
        var glutton:String = "nil"
        
        if(dairyBtn.isSelected){
            dairy = "true"
        }
        if(fishBtn.isSelected){
            fish = "true"
        }
        if(nutsBtn.isSelected){
            nuts = "true"
        }
        if(gluttonBtn.isSelected){
            glutton = "true"
        }
        
        let Details: [String: Any] = [
            "dairy":dairy as NSString,
            "fish": fish as NSString,
            "nuts": nuts as NSString,
            "gluttons": glutton as NSString]
        
        self.database.child("users").child(userID!).child("allergy").setValue(Details)
        performSegue(withIdentifier: "q3", sender: nil)
    }
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light
        super.viewDidLoad()
        progressPV.progress = 0.4
        // Do any additional setup after loading the view.
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
