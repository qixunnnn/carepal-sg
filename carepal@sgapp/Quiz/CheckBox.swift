//
//  CheckBox.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 24/1/21.
//

import Foundation
import UIKit

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "TickBox")! as UIImage
    let uncheckedImage = UIImage(named: "CheckBox")! as UIImage

    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
                self.isSelected = true
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
                self.isSelected = false
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }

    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
    func isSelect() -> Bool {
        return isChecked
    }
}
