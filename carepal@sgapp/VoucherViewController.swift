//
//  VoucherViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 2/2/21.
//

import UIKit
import QRCode

class VoucherViewController: UIViewController{

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var qrCode: UIImageView!
    var ItemData = UserDefaults.standard.object(forKey: "voucher") as! [String]
    @IBAction func copyBtn(_ sender: Any) {
        UIPasteboard.general.string = codeTF.text
        let alert = UIAlertController(title: "Text Copied", message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if(ItemData[0].prefix(4) == "NTUC")
        {
            codeTF.text = "NTUC0001"
            logoImageView.image = UIImage(named: "NTUC Fairprice")
            
            if codeTF.text != "" {
                var QR = QRCode(codeTF.text!)
                QR?.color = CIColor(rgba: "910003")
                qrCode.image = QR?.image
            }
        }
        else if (ItemData[0].prefix(4) == "Grab")
        {
            codeTF.text = "GF0001"
            logoImageView.image = UIImage(named: "GrabFood")
        }
        else
        {
            codeTF.text = "PM0001"
            logoImageView.image = UIImage(named: "PandaMart")
        }
        detailsLbl.text = ItemData[0]
      
       // logoImageView = img
        
       
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
