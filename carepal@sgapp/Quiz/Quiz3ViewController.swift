//
//  Quiz3ViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 24/1/21.
//

import UIKit

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
    
    @IBAction func NextBtn(_ sender: Any) {
        if(dairyBtn.isSelected){
            
        }
        if(fishBtn.isSelected){
            
        }
        if(nutsBtn.isSelected){
            
        }
        if(gluttonBtn.isSelected){
            
        }
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
