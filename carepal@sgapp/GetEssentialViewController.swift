//
//  GetEssentialViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 1/2/21.
//

import UIKit

class GetEssentialViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cannedFood = ["Ayam Brand Baked Beans","Ayam Brand Tuna","Xiang Men Peanut","HOSEN Mushroom","HOSEN Longan","HOSEN Rambutan"]
    let checkedImage = UIImage(named: "TickBox")! as UIImage
    let uncheckedImage = UIImage(named: "CheckBox")! as UIImage
    let darkgrey = UIColor.init(red: 205/255, green: 205/255, blue: 205/255, alpha: 1)
    let black = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    @IBOutlet weak var all: UIButton!
    @IBAction func AllBtn(_ sender: Any) {
     
        all.setTitleColor(black, for: .normal)
        essentials.setTitleColor(darkgrey, for: .normal)
        canned.setTitleColor(darkgrey, for: .normal)
        condiments.setTitleColor(darkgrey, for: .normal)
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
        collectionView.reloadData()
    }
    @IBAction func essentialsBtn(_ sender: Any) {
        all.setTitleColor(darkgrey, for: .normal)
        essentials.setTitleColor(black, for: .normal)
        canned.setTitleColor(darkgrey, for: .normal)
        condiments.setTitleColor(darkgrey, for: .normal)
        collectionView.reloadData()
    }
    
    @IBAction func cannedFoodBtn(_ sender: Any) {
        all.setTitleColor(darkgrey, for: .normal)
        essentials.setTitleColor(darkgrey, for: .normal)
        canned.setTitleColor(black, for: .normal)
        condiments.setTitleColor(darkgrey, for: .normal)
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cannedFood.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GetEssentialCollectionViewCell", for: indexPath) as! GetEssentialCollectionViewCell
        cell.configue(withImg: UIImage(named:cannedFood[indexPath.row])!, withTitle: cannedFood[indexPath.row])
        cell.checkBoxAction = { [self]sender in
            if(cell.checkBox.isSelected)
            {
                cell.checkBox.setImage(self.uncheckedImage, for: UIControl.State.normal)
                cell.checkBox.isSelected = false
            }
            else
            {
                cell.checkBox.isSelected = true
                cell.checkBox.setImage(self.checkedImage, for: UIControl.State.normal)
            }
        }
        
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GetEssentialCollectionViewCell
        
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

