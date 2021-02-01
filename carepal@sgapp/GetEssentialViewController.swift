//
//  GetEssentialViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 1/2/21.
//

import UIKit

class GetEssentialViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let itemTitle = "Ayam Brand Baked Beans"
    let cannedFood = ["Ayam Brand Baked Beans","Ayam Brand Tuna","Xiang Men Peanut","HOSEN Mushroom","HOSEN Longan","HOSEN Rambutan"]
    let checkedImage = UIImage(named: "TickBox")! as UIImage
    let uncheckedImage = UIImage(named: "CheckBox")! as UIImage
    
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

