//
//  ItemViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 2/2/21.
//

import UIKit

class ItemViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var AllergyLbl: UILabel!
    @IBOutlet weak var PriceLbl: UILabel!
    var cart = UserDefaults.standard.object(forKey: "Cart") as! [String]
    var ItemData = UserDefaults.standard.object(forKey: "item") as! [String]
    @IBAction func AddBtn(_ sender: Any) {
        
        cart.append(ItemData[0])
        print(cart)
        UserDefaults.standard.set(cart, forKey: "Cart")
        UserDefaults.standard.synchronize()
        let alert = UIAlertController(title: "Successful", message: "\(ItemData[0]) has been added to your Picklist", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in
            _ = self.navigationController?.popViewController(animated: true)
            
        }))
        self.present(alert, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let price = ItemData[1]
        let title = ItemData[0]
        imageView.image = UIImage(named: title)
        if(title == "Ayam Brand Baked Beans")
        {
            //if user have bean allergy
            AllergyLbl.text = "This Canned food contain Beans ingredients"
            
        }
        else if (title == "Xiang Men Peanut")
        {
            //if user have nuts allergy
            AllergyLbl.text = "This Canned food contain Nuts ingredients"
        }
        else
        {
            AllergyLbl.text = ""
        }

        PriceLbl.text = "$" + price
        
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
