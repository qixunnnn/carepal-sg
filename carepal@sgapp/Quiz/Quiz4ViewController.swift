//
//  Quiz4ViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 24/1/21.
//

import UIKit

class Quiz4ViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    
    //title divided into two TF(label)
    @IBOutlet weak var medicalTF: UILabel!
    @IBOutlet weak var conditionTF: UILabel!
    
    @IBOutlet weak var cholesterolTF: UILabel!
    @IBOutlet weak var cholesterolBtn: CheckBox!
    @IBOutlet weak var bloodPressureTF: UILabel!
    @IBOutlet weak var bloodPressureBtn: CheckBox!
    @IBOutlet weak var diabetesTF: UILabel!
    @IBOutlet weak var diabetesBtn: CheckBox!
    @IBOutlet weak var obesityBtn: CheckBox!
    @IBOutlet weak var obesityTF: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var progressPV: UIProgressView!
    
    @IBAction func NextBtn(_ sender: Any) {
        if(cholesterolBtn.isSelected){
            
        }
        if(bloodPressureBtn.isSelected){
            
        }
        if(diabetesBtn.isSelected){
            
        }
        if(obesityBtn.isSelected){
            
        }
        performSegue(withIdentifier: "q4", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        progressPV.progress = 0.6
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
