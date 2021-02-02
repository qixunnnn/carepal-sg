//
//  QuizViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 24/1/21.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var nextBtn: UIButton!
    
    //title divided into two TF(label)
    @IBOutlet weak var HelpUsAnsTF: UILabel!
    @IBOutlet weak var FirstTimeHereTF: UILabel!
    @IBOutlet weak var q1ProgressiveView:
        UIProgressView!
    
    
    let appDelegate = AppDelegate.init()
    //---------------------first page----------------
    @IBAction func q1nextBtn(_ sender: Any) {

        performSegue(withIdentifier: "q1", sender: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
 
        q1ProgressiveView.progress = 0
            FirstTimeHereTF.text = TranslateText.quiz1headerTxt1
            HelpUsAnsTF.text = TranslateText.quiz1headerTxt2
            nextBtn.setTitle(TranslateText.quiz1btnTxt, for: .normal)
       
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
extension String {
    var localized: String {
        if let _ = UserDefaults.standard.string(forKey: "i18n_language") {} else {
            // we set a default, just in case
            UserDefaults.standard.set("fr", forKey: "i18n_language")
            UserDefaults.standard.synchronize()
        }

        let lang = UserDefaults.standard.string(forKey: "i18n_language")

        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)

        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
