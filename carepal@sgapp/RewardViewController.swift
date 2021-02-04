//
//  RewardViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 31/1/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RewardViewCell:UITableViewCell {
    
    @IBOutlet weak var LogoImg: UIImageView!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var DetailLbl: UILabel!
    @IBOutlet weak var UseNotBtn: UIButton!
    @IBOutlet weak var QuantityLbl: UILabel!
    
}
class RewardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pointsLbl: UILabel!
    
    let database = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    var points:Int = 0
    var temp:[Int] = []
    
    var CellTitle:[String] =
        [//clementi cc
        ]
    let CellDetails:[String] =
        [//clementi cc
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        self.tableView.delegate = self

        self.tableView.dataSource = self
        self.tableView.rowHeight = 103
        overrideUserInterfaceStyle = .light
        
        if CellTitle == nil {
            getData()
        }
        self.tableView.reloadData()
    }
       override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        getData()
        self.tableView.reloadData()
        print(temp)
       
       }
    
    func getData() {
        CellTitle = []
        temp = []
        database.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.points = value?["Points"] as? Int ?? 0
            self.pointsLbl.text = String(self.points)
        }
        database.child("users").child(userID!).child("vouchers").observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            //let temp = value?["vouchers"] as? NSDictionary
            let x = value?.allKeys as? [String]
            
            if(x != nil)
            {
                for i in x!
                {
                    self.CellTitle.append(i)
                }
                
            }
            self.tableView.reloadData()
            
        // Do any additional setup after loading the view.
        }
        database.child("users").child(userID!).child("vouchers").observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            //let temp = value?["vouchers"] as? NSDictionary
            let x = value?.allValues as? [Int]
            
            if(x != nil)
            {
                for i in x!
                {
                    self.temp.append(i)
                }
                
            }
            self.tableView.reloadData()

        }
    }
 

    override func viewWillDisappear( _ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return fetchArticles.count
        return CellTitle.count//array count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCell", for: indexPath) as! RewardViewCell
    
        cell.TitleLbl.text = String(CellTitle[indexPath.row])
        cell.QuantityLbl.text = "x " + String(temp[indexPath.row])
        //cell.DetailLbl.text = ""
        let temp = CellTitle[indexPath.row].prefix(4)
        if temp == "Pand"{
            cell.LogoImg.image = UIImage(named: "PandaMart")
        }
        else if temp == "Grab"
        {
            cell.LogoImg.image = UIImage(named: "GrabFood")
        }
        else
        {
            cell.LogoImg.image = UIImage(named: "NTUC Fairprice")
        }


        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RewardViewCell
        let data = [cell.TitleLbl.text]
        UserDefaults.standard.set(data, forKey: "voucher")
        UserDefaults.standard.synchronize()
        performSegue(withIdentifier: "voucher", sender: nil)
    }
    
    func alert(message:String, title:String)
    {

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
