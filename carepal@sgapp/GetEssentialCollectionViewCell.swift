//
//  GetEssentialCollectionViewCell.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 1/2/21.
//

import UIKit

class GetEssentialCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var title:UILabel!
    @IBOutlet var checkBox:UIButton!
    @IBOutlet var price:UILabel!
    var checkBoxAction: ((Any) -> Void)?
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    @IBAction func checkBoxBtnA(_ sender: Any) {
        self.checkBoxAction?(sender)
        
    }
    public func configue(withImg image: UIImage, withTitle text:String, withPrice p:Double ) {
        imageView.image = image
        title.text = text
        price.text = String(format: "%.2f", p)
    }
    
    static func nib() -> UINib
    {
        return UINib(nibName: "GetEssentialCollectionViewCell", bundle: nil)
    }

}
