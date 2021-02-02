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
    
    var cannedFood:[String] = ["Ayam Brand Baked Bean","Ayam Brand Tuna","Xiang Men Peanut","HOSEN Mushroom","HOSEN Longan","HOSEN Rambutan"]
    var toShow:[String] = []
    var allShow:[String] = []
    var Essentials = ["3-ply Mask x30","Hand Sanitizer","Packet of Wet Wipes","Toilet Roll","Anti-Bacterial Spray","Thermometer"]
    //var cannedFood = ["Ayam Brand Baked Beans","Ayam Brand Tuna","Xiang Men Peanut","HOSEN Mushroom","HOSEN Longan","HOSEN Rambutan"]
    var toShowPrice:[Double] = []
    var price:[Double] = []
    var eprice:[Double] = []
    var sprice:[Double] = []
    let checkedImage = UIImage(named: "TickBox")! as UIImage
    let uncheckedImage = UIImage(named: "CheckBox")! as UIImage
    let darkgrey = UIColor.init(red: 205/255, green: 205/255, blue: 205/255, alpha: 1)
    let black = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    var cart = UserDefaults.standard.object(forKey: "Cart") as! [String]
    
    var bmi:String = ""
    var medical:[String] = []
    var allergy:[String] = []
    
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
        toShow = allShow
        toShowPrice = price
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
        toShow = cannedFood
        toShowPrice = price
        collectionView.reloadData()
    }
    @IBAction func essentialsBtn(_ sender: Any) {
        all.setTitleColor(darkgrey, for: .normal)
        essentials.setTitleColor(black, for: .normal)
        canned.setTitleColor(darkgrey, for: .normal)
        condiments.setTitleColor(darkgrey, for: .normal)
        toShow = Essentials
        toShowPrice = eprice
        collectionView.reloadData()
    }
    
    @IBAction func cannedFoodBtn(_ sender: Any) {
        all.setTitleColor(darkgrey, for: .normal)
        essentials.setTitleColor(darkgrey, for: .normal)
        canned.setTitleColor(black, for: .normal)
        condiments.setTitleColor(darkgrey, for: .normal)
        //to show recommened
        toShow = cannedFood
        toShowPrice = price
        if let abmi = Double(bmi)
        {
            if(abmi < 18.5)
            {
                //underweight
            }
            else if(abmi > 25.0)
            {
                //overweght
                let i = toShow.firstIndex(of: "Ayam Brand Tuna")!
                toShow.remove(at: i)
                toShowPrice.remove(at: i)
                
            }
        }
        
        if(allergy.contains("fish") || (medical.contains("obesity")))
        {
            if let i = toShow.firstIndex(of: "Ayam Brand Tuna")
            {
                toShow.remove(at: i)
                toShowPrice.remove(at: i)
            }
        }
        
        if(allergy.contains("nuts") || (medical.contains("cholesterol")))
        {
            if let i = toShow.firstIndex(of: "Xiang Men Peanut")
            {
                toShow.remove(at: i)
                toShowPrice.remove(at: i)
            }
        }
        
        if(medical.contains("diabetes"))
        {
            if let i = toShow.firstIndex(of: "HOSEN Longan")
            {
                toShow.remove(at: i)
                toShowPrice.remove(at: i)
            }
        }
        
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GetEssentialCollectionViewCell", for: indexPath) as! GetEssentialCollectionViewCell
        print(toShow[indexPath.row])
        cell.configue(withImg: UIImage(named:toShow[indexPath.row])!, withTitle: toShow[indexPath.row], withPrice: toShowPrice[indexPath.row] )
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
        

        database.child("Storage").child("CannedFood").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children
            {
                let snap = child as! DataSnapshot
                print(snap.key)
                self.toShow.append(snap.key)
                self.allShow.append(snap.key)
                
                let x = snap.value as! [String:Any]
                
                let price = x["Price"] as! Double
                print(price)
                self.price.append(price)
                self.toShowPrice.append(price)
                
            }
            self.collectionView.reloadData()
        }
        
        database.child("Storage").child("Essentials").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children
            {
                let snap = child as! DataSnapshot
                print(snap.key)
                self.toShow.append(snap.key)
                self.allShow.append(snap.key)
                
                let x = snap.value as! [String:Any]
                
                let price = x["Price"] as! Double
                print(price)

                self.price.append(price)
                self.toShowPrice.append(price)
                self.eprice.append(price)
                
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
        
        database.child("users").child(userID!).child("allergy").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children
            {
                let snap = child as! DataSnapshot
                if snap.value as! String == "true" {
                    self.allergy.append(snap.key)
                }
            }
            print(self.allergy)
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

