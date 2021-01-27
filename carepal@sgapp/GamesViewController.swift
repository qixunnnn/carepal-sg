//
//  GamesViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 27/1/21.
//

import UIKit

class GamesViewController: UIViewController {
    var count = 60
    var score = 0
    var num1 = 0
    var num2 = 0
    var correctAns = 0
    var timer = Timer()
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var equationLabel: UILabel!
    @IBOutlet weak var option1Btn: UIButton!
    @IBOutlet weak var option2Btn: UIButton!
    @IBOutlet weak var option3Btn: UIButton!
    @IBOutlet weak var option4Btn: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.alpha = 0
        // Do any additional setup after loading the view.
       
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let alert = UIAlertController(title: "Stage 1, Level 1", message: "60 Seconds! Maximum score you can get is 30! Good luck!", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Start", style: .default, handler: {action in
            //resume
             self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        }))
    
        self.present(alert, animated: true)
       setup()
        
    }
    @IBAction func backBtn(_ sender: Any) {
        timer.invalidate()
        let alert = UIAlertController(title: "Are you sure you want to quit?", message: "Leaving the game will not save your progress", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "No", style: .default, handler: {action in
            //resume
             self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: {action in
           
            //leave game
            self.performSegue(withIdentifier: "gameback", sender: nil)
        }))

        self.present(alert, animated: true)
    }
    func btnaction (btn:UIButton){
        if(btn.titleLabel?.text == String(correctAns))
        {
            
            statusLabel.text = "Correct!"
            statusLabel.textColor = UIColor(red: 0, green: 159/255.0, blue: 0, alpha: 1)
            score += 1
            scoreLabel.text = String(score)
            if(score == 30)
            {
                count = 0
            }
           
        }
        else
        {
            if(score > 0)
            {
                score -= 1
            }
            statusLabel.text = "Wrong!"
            statusLabel.textColor = UIColor(red: 159/255.0, green: 0, blue: 0, alpha: 1)
        }
        statusLabel.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseOut, animations: {
            self.statusLabel.alpha = 0.0
                    })
        setup()
    }
    @IBAction func FirstBtn(_ sender: Any) {
       btnaction(btn: option1Btn)
    }
   
    @IBAction func SecondBtn(_ sender: Any) {
        btnaction(btn: option2Btn)
    }
    
    @IBAction func ThirdBtn(_ sender: Any) {
        btnaction(btn: option3Btn)
    }
    
    @IBAction func FourthBtn(_ sender: Any) {
        btnaction(btn: option4Btn)
    }
    @objc func update() {
        if(count > 0) {
            if(count < 6)
            {
                timeLabel.textColor = UIColor(red: 199/255.0, green: 0, blue: 0, alpha: 1)
            }
            count -= 1
            timeLabel.text = String(count)
        }
        else
        {
            timer.invalidate()
            var alert = UIAlertController()
            if(score == 30)
            {
                alert = UIAlertController(title: "Congrats!", message: "Thank you for playing your, you have gain the maximum points which is 30!", preferredStyle: .alert)
            }
            else
            {
                alert = UIAlertController(title: "Game Over!", message: "Thank you for playing your final score is \(score), the maximum points you can get from this stage is 30", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: {action in
                    //restart game
                    self.restartGame()
                }))

            }
           
        
            alert.addAction(UIAlertAction(title: "Back", style: .cancel, handler: {action in
                //save and go back
                self.performSegue(withIdentifier: "gameback", sender: nil)
            }))

            self.present(alert, animated: true)
        }
    }
    func restartGame(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        setup()
        count = 60
        timeLabel.text = String(count)
        score = 0
        scoreLabel.text = String(score)
        
    }
    
    func setup(){
        num1 = Int.random(in: 1..<15)
        num2 = Int.random(in: 1..<15)
        
        equationLabel.text = "\(num1)+\(num2) = ?"
        correctAns = num1 + num2
        var o3 = (correctAns+10)%8
        if(o3 == 0)
        {
            o3 = (correctAns + Int.random(in: 1..<4) )
        }
        switch(Int.random(in: 1..<5)){
        case 1:
            option1Btn.setTitle(String(correctAns), for: .normal)
            option2Btn.setTitle(String(correctAns + Int.random(in: 7..<11)), for: .normal)
            option3Btn.setTitle(String(o3), for: .normal)
            option4Btn.setTitle(String(correctAns/2), for: .normal)
            break
        case 2:
            option2Btn.setTitle(String(correctAns), for: .normal)
            option1Btn.setTitle(String(correctAns + Int.random(in: 7..<11)), for: .normal)
            option4Btn.setTitle(String(o3), for: .normal)
            option3Btn.setTitle(String(correctAns/2), for: .normal)
            break
        case 3:
            option3Btn.setTitle(String(correctAns), for: .normal)
            option4Btn.setTitle(String(correctAns + Int.random(in: 7..<11)), for: .normal)
            option1Btn.setTitle(String(o3), for: .normal)
            option2Btn.setTitle(String(correctAns/2), for: .normal)
            break
        case 4:
            option4Btn.setTitle(String(correctAns), for: .normal)
            option3Btn.setTitle(String(correctAns + Int.random(in: 7..<11)), for: .normal)
            option2Btn.setTitle(String(o3), for: .normal)
            option1Btn.setTitle(String(correctAns/2), for: .normal)
            break
        default:
            break
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
