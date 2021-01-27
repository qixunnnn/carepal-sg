//
//  Quiz5ViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 24/1/21.
//

import UIKit

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
            bmiTF.text = String(format: "%.2f",w/(h * 2))
        }
    }
    
    @IBAction func DoneBtn(_ sender: Any) {
        
        performSegue(withIdentifier: "q5", sender: nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
