//
//  SettingsViewController.swift
//  carepal@sgapp
//
//  Created by Goh Qi Xun on 2/2/21.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btnLogout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        
        do
        {
            try firebaseAuth.signOut()
            //go home
        }
        catch let error as NSError
        {
            print("Error signing out :%@", error)
        }
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
