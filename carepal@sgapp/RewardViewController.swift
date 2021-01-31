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
    let CellTitle: Array<String> =
        ["PandaMart",
         "NTUC Fairprice",
         "GrabFood"//clementi cc
        ]
    let CellDetails: Array<String> =
        ["100% off delivery using PandaMart",
         "15% off NTUC products",
         "100% off delivery using GrabFood"//clementi cc
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self

        self.tableView.dataSource = self
        self.tableView.rowHeight = 103
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
        cell.DetailLbl.text = String(CellDetails[indexPath.row])
        cell.LogoImg.image = UIImage(named: String(CellTitle[indexPath.row]))


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
