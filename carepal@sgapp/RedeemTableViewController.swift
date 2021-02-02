//
//  RedeemTableViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 31/1/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RedeemTableViewController: UITableViewController {
    
    @IBOutlet weak var pointsLbl: UIButton!
    let database = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    var points:Int = 0
    
    let CellTitle: Array<String> =
        ["PandaMart",
         "NTUC Fairprice",
         "GrabFood",
         "PandaMart",
          "NTUC Fairprice",
          "GrabFood"
        ]
    let CellDetails: Array<String> =
        ["100% off delivery using PandaMart",
         "15% off NTUC products",
         "100% off delivery using GrabFood",
         "50% off delivery using PandaMart",
          "30% off NTUC products",
          "50% off delivery using GrabFood"
        ]
    let CellPoints: Array<String> =
        ["500",
         "750",
         "500",
         "275",
          "900",
          "275"
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 103
        overrideUserInterfaceStyle = .light
        
        database.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.points = value?["Points"] as? Int ?? 0 //cUser points
            self.pointsLbl.setTitle(String(self.points), for: .normal)
        }
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CellTitle.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCell", for: indexPath) as! RewardViewCell
        
        cell.TitleLbl.text = String(CellTitle[indexPath.row])
        cell.DetailLbl.text = String(CellDetails[indexPath.row])
        cell.LogoImg.image = UIImage(named: String(CellTitle[indexPath.row]))
        cell.UseNotBtn.setTitle(String(CellPoints[indexPath.row]) + " Points", for: .normal)
      
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print()
        //go into page
        let alert = UIAlertController(title: "Are you sure?", message: "Are you sure you want to purchase  \(CellDetails[indexPath.row]) ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let newPoints = self.points - Int(self.CellPoints[indexPath.row])!
            
            if(newPoints > 0)
            {
                var xz:Int = 0
                self.database.child("users").child(self.userID!).child("Points").setValue(newPoints)
                self.alert(message: "You have purchase successfully",title: "Successfully purchased")
                self.database.child("users").child(self.userID!).child("vouchers").observeSingleEvent(of: .value) { (snapshot) in
                    let value = snapshot.value as? [String:Any]
                    print(value)
                    //xz = value?[self.CellTitle] as? Int ?? 0
                    //now can 1 only idk why the fuck
                }
                self.database.child("users").child(self.userID!).child("vouchers").child(self.CellTitle[indexPath.row] + " " + self.CellDetails[indexPath.row]).setValue(xz+1)
                
                tableView.reloadData()
            }
            else
            {
                self.alert(message: "You don't have enough points",title: "Unable to redeem")
            }
            tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func alert(message:String, title:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
