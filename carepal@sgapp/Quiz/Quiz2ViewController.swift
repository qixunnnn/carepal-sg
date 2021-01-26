//
//  Quiz2ViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 24/1/21.
//

import UIKit

class Quiz2ViewController: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    
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
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressPV.progress = 0.2
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func NextBtn(_ sender: Any) {
        if(vegetarainBtn.isSelected){
            
        }
        if(veganBtn.isSelected){
            
        }
        if(porkBtn.isSelected){
            
        }
        if(beefBtn.isSelected){
            
        }
        performSegue(withIdentifier: "q2", sender: nil)
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
