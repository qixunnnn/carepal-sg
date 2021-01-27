//
//  GamesViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 27/1/21.
//

import UIKit

class GamesViewController: UIViewController {
    var count = 60
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var equationLabel: UILabel!
    @IBOutlet weak var option1Btn: UIButton!
    @IBOutlet weak var option2Btn: UIButton!
    @IBOutlet weak var option3Btn: UIButton!
    @IBOutlet weak var option4Btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Int.random(in: 1..<3))
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    @objc func update() {
        if(count > 0) {
            if(count < 5)
            {
                timeLabel.textColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
            }
            count -= 1
            timeLabel.text = String(count)
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
