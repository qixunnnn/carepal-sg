//
//  GetEssentialViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 1/2/21.
//

import UIKit

class GetEssentialViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var cannedFood = ["Ayam Brand Baked Beans","Ayam Brand Tuna","Xiang Men Peanut","HOSEN Mushroom","HOSEN Longan","HOSEN Rambutan"]
    var price = [1.45,2.10,3.50,5.0,1.2,0.9,6.0,1.2]
    let checkedImage = UIImage(named: "TickBox")! as UIImage
    let uncheckedImage = UIImage(named: "CheckBox")! as UIImage
    let darkgrey = UIColor.init(red: 205/255, green: 205/255, blue: 205/255, alpha: 1)
    let black = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    var cart = UserDefaults.standard.object(forKey: "Cart") as! [String]
    
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
        let destinationVC = ItemViewController()
        destinationVC.ItemData = data
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

