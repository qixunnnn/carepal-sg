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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light

        // Do any additional setup after loading the view.
    }
    @IBAction func CreateBtn(_ sender: Any) {
        let firstName = fNameTxt.text
        let lastName = lNameTxt.text
        let cNo = contactTxt.text
        
        
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
