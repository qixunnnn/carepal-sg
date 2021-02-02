//
//  CartViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 1/2/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CartViewCell:UITableViewCell{
    @IBOutlet weak var ItemImg:UIImageView!
    @IBOutlet weak var TitleLbl:UILabel!
    @IBOutlet weak var DetailsLbl:UILabel!
    @IBOutlet weak var PriceLbl:UILabel!
}
class SummaryCell:UITableViewCell{
    @IBOutlet weak var TotalPriceLbl:UILabel!
    @IBOutlet weak var LimitItemLbl:UILabel!
}

let database = Database.database().reference()
let userID = Auth.auth().currentUser?.uid

class CartViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView:UITableView!
    var cart = UserDefaults.standard.object(forKey: "Cart") as! [String]
    var totalPrice = 0.0
    var fakeprice = 1.45
    var price = [1.45,2.10,3.50,5.0,1.2,0.9,6.0,1.2]
    var AllowCheckOut = true
    var points:Double = 0.0
    
    @IBAction func CheckOutBtn(_ sender: Any) {
        if(AllowCheckOut)
        {
            //storedatabase
            if totalPrice > points {
                let alert = UIAlertController(title: "Unable to purchase", message: "You do not have enough allowance left", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                
            }
            else
            {
                database.child("users").child(userID!).child("allowance").setValue(points - totalPrice)
            }
        }
        else
        {
            let alert = UIAlertController(title: "Allergy Warning", message: "You may be allergic to One of the item in the list", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Im buying for my family", style: .default, handler: {action in
                //storedatabse
                
            }))
            self.present(alert, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count + 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row+1 > cart.count)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as! SummaryCell
            database.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
                let value = snapshot.value as? NSDictionary
                self.points = value?["allowance"] as? Double ?? 0.0
                print(self.points)
                
                cell.TotalPriceLbl.text = "Total Value:$" + String(format: "%.2f", self.totalPrice)
                cell.LimitItemLbl.text = "Max Value you are entitled to claim: $" + String(format: "%.2f",self.points)
            }
            
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartViewCell
            cell.ItemImg.image = UIImage(named: String(cart[indexPath.row]))
            cell.TitleLbl.text = String(cart[indexPath.row])
            cell.PriceLbl.text = "$" + String(price[indexPath.row])
            if(String(cart[indexPath.row]) == "Ayam Brand Baked Beans")
            {
                //if user have bean allergy
                cell.DetailsLbl.text = "Allergy Warning: Beans"
                AllowCheckOut = false
            }
            else if (String(cart[indexPath.row]) == "Xiang Men Peanut")
            {
                //if user have nuts allergy
                cell.DetailsLbl.text = "Allergy Warning: Nuts"
                AllowCheckOut = false
            }
            else
            {
                cell.DetailsLbl.text = ""
            }
            totalPrice = totalPrice + price[indexPath.row]
            return cell
        }
        
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCell", for: indexPath) as! RewardViewCell
//
//        cell.TitleLbl.text = String(CellTitle[indexPath.row])
//        cell.DetailLbl.text = String(CellDetails[indexPath.row])
//        cell.LogoImg.image = UIImage(named: String(CellTitle[indexPath.row]))
//        cell.UseNotBtn.setTitle(String(CellPoints[indexPath.row]), for: .normal)
//
//
//        return cell
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 101
        self.tableView.delegate = self

        self.tableView.dataSource = self
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        database.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.points = value?["allowance"] as? Double ?? 0.0
            print(self.points)
        }
        tableView.reloadData()
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
