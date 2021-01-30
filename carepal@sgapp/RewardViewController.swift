//
//  RewardViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 31/1/21.
//

import UIKit

class RewardViewCell:UITableViewCell {
    
    @IBOutlet weak var LogoImg: UIImageView!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var DetailLbl: UILabel!
    @IBOutlet weak var UseNotBtn: UIButton!
    
    
}
class RewardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self

        self.tableView.dataSource = self
        self.tableView.rowHeight = 103
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return fetchArticles.count
        return 1//array count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCell", for: indexPath) as! RewardViewCell
        //let cNew = fetchArticles[indexPath.row] //Passing later
        
       // cell.titleText?.text = fetchArticles[indexPath.row].title
        cell.TitleLbl.text = "PandaMart"
        cell.DetailLbl.text = "100% off delivery using PandaMart"
        cell.LogoImg.image = UIImage(named: "FoodPanda")
//        cell.titleText.numberOfLines = 0
//        cell.titleText.sizeToFit()
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //go into page
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
