//
//  GetEssentialViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 1/2/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class GetEssentialViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var cannedFood:[String] = []
    //var cannedFood = ["Ayam Brand Baked Beans","Ayam Brand Tuna","Xiang Men Peanut","HOSEN Mushroom","HOSEN Longan","HOSEN Rambutan"]
    var price:[Double] = []
    let checkedImage = UIImage(named: "TickBox")! as UIImage
    let uncheckedImage = UIImage(named: "CheckBox")! as UIImage
    let darkgrey = UIColor.init(red: 205/255, green: 205/255, blue: 205/255, alpha: 1)
    let black = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    var cart = UserDefaults.standard.object(forKey: "Cart") as! [String]
    
    var bmi:String = ""
    var medical:[String] = []
    
    let database = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    
    @IBAction func cartBtn(_ sender: Any) {
        UserDefaults.standard.set(cart, forKey: "Cart")
        UserDefaults.standard.synchronize()
        performSegue(withIdentifier: "cart", sender: nil)
    }
    @IBOutlet weak var all: UIButton!
    @IBAction func AllBtn(_ sender: Any) {
        print(cart)
        all.setTitleColor(black, for: .normal)
        essentials.setTitleColor(darkgrey, for: .normal)
        canned.setTitleColor(darkgrey, for: .normal)
        condiments.setTitleColor(darkgrey, for: .normal)
        cannedFood = ["Ayam Brand Baked Beans","Ayam Brand Tuna","Xiang Men Peanut","HOSEN Mushroom","HOSEN Longan","HOSEN Rambutan"]
        collectionView.reloadData()
    }
   
    @IBOutlet weak var essentials: UIButton!
    
    @IBOutlet weak var condiments: UIButton!
    @IBOutlet weak var canned: UIButton!
    @IBAction func condimentsBtn(_ sender: Any) {
        all.setTitleColor(darkgrey, for: .normal)
        essentials.setTitleColor(darkgrey, for: .normal)
        canned.setTitleColor(darkgrey, for: .normal)
        condiments.setTitleColor(black, for: .normal)
        cannedFood = ["HOSEN Longan","HOSEN Rambutan"]
        collectionView.reloadData()
    }
    @IBAction func essentialsBtn(_ sender: Any) {
        all.setTitleColor(darkgrey, for: .normal)
        essentials.setTitleColor(black, for: .normal)
        canned.setTitleColor(darkgrey, for: .normal)
        condiments.setTitleColor(darkgrey, for: .normal)
        cannedFood = ["Xiang Men Peanut","HOSEN Mushroom"]
        collectionView.reloadData()
    }
    
    @IBAction func cannedFoodBtn(_ sender: Any) {
        all.setTitleColor(darkgrey, for: .normal)
        essentials.setTitleColor(darkgrey, for: .normal)
        canned.setTitleColor(black, for: .normal)
        condiments.setTitleColor(darkgrey, for: .normal)
        cannedFood = ["Ayam Brand Baked Beans","Ayam Brand Tuna"]
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cannedFood.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GetEssentialCollectionViewCell", for: indexPath) as! GetEssentialCollectionViewCell
        cell.configue(withImg: UIImage(named:cannedFood[indexPath.row])!, withTitle: cannedFood[indexPath.row], withPrice: price[indexPath.row] )
        cell.checkBoxAction = { [self]sender in
            print(cell.checkBox.isSelected)
            if(cell.checkBox.isSelected)
            {
                cell.checkBox.setImage(self.uncheckedImage, for: UIControl.State.normal)
                cell.checkBox.isSelected = false
                if let index = cart.firstIndex(of: cell.title.text!){
                    cart.remove(at: index)
                }
            }
            else
            {
                cell.checkBox.isSelected = true
                cell.checkBox.setImage(self.checkedImage, for: UIControl.State.normal)
                cart.append(cell.title.text!)
            }
        }
        if(!cart.isEmpty)
        {
            if(cart.contains(cell.title.text!))
            {
                cell.checkBox.isSelected = true
                cell.checkBox.setImage(self.checkedImage, for: UIControl.State.normal)
            }
            else
            {
                cell.checkBox.setImage(self.uncheckedImage, for: UIControl.State.normal)
                cell.checkBox.isSelected = false
            }
        }
        else
        {
            cell.checkBox.setImage(self.uncheckedImage, for: UIControl.State.normal)
            cell.checkBox.isSelected = false
        }
        
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GetEssentialCollectionViewCell
        let data = [cell.title.text,cell.price.text]
        UserDefaults.standard.set(data, forKey: "item")
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: "item", sender: self)
        //print(cell.title!)
        //display item info
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 174, height: 227)
    }
    

    @IBOutlet var collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(GetEssentialCollectionViewCell.nib(), forCellWithReuseIdentifier: "GetEssentialCollectionViewCell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 174, height: 227)
        collectionView.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        database.child("Storage").observeSingleEvent(of: .value) { (snapshot) in
//            let value = snapshot.value as? NSDictionary
//            //let temp = value?["vouchers"] as? NSDictionary
//            let x = value?.allKeys as? [String]
//
//            for child in snapshot.children
//            {
//                let snap = child as! DataSnapshot
//                print(snap.)
//            }
//            for i in x!
//            {
//                print(i)
//                self.cannedFood.append(i)
//                //let y = value?[i]
//
////                self.database.child("Storage").child(i).observeSingleEvent(of: .value) { (snapshot) in
////                    let value = snapshot.value as? NSDictionary
////                    let x = value?["Price"] as? Double ?? 0
////                    //let y = value
////                    self.price.append(x)
////                    print(x)
////                }
//            }
//            self.collectionView.reloadData()
//        }
        database.child("Storage").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children
            {
                let snap = child as! DataSnapshot
                self.cannedFood.append(snap.key)
                
                let x = snap.value as! [String:Any]
                
                let price = x["Price"] as! Double
                self.price.append(price)
                
            }
            self.collectionView.reloadData()
        }
        
        database.child("users").child(userID!).child("heightandweight").observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let x = value?["bmi"] as? String
            print(x)
            //BMI ^
            self.bmi = x ?? "0"
            self.collectionView.reloadData()
        }
        
        database.child("users").child(userID!).child("medical").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children
            {
                let snap = child as! DataSnapshot
                if snap.value as! String == "true" {
                    self.medical.append(snap.key)
                }
            }
            print(self.medical)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
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

