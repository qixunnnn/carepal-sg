//
//  HomeViewController.swift
//  carepal@sgapp
//
//  Created by Goh Qi Xun on 12/1/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {
    
    let database = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    
    @IBOutlet weak var pointsBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        database.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let y = value?["Points"] as? Int ?? 0 //cUser points
            self.pointsBtn.setTitle(String(y), for: .normal)
            
        }
         //Do any additional setup after loading the view.
//        let source = Source(id: "null", name: "Endofound.org")
//        let articles = Article(source: source, author: "Endofound.org", title: "Everything You Need to Know About Cervical Cancer - Endometriosis Foundation of America - The Blossom", description: "January is Cervical Health Awareness Month", url: "https://www.endofound.org/everything-you-need-to-know-about-cervical-cancer", urlToImage: "https://www.endofound.org/member_files/object_files/endofound.org/2021/01/28/january_is_cervical_health_awareness_month.png", publishedAt: 2021-01-28T16:46:33Z, content: "January is Cervical Health Awareness Month. This month, various organizations embark on campaigns geared towards increasing awareness and public education on cervical cancer in their communities, enc… [+5979 chars]")
        //let sample = News(status: "ok", totalResults: 70, articles:)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
        database.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let y = value?["Points"] as? Int ?? 0 //cUser points
            self.pointsBtn.setTitle(String(y), for: .normal)
            
        }
    }
    //    This is news
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
