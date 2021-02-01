//
//  VoucherViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 2/2/21.
//

import UIKit
//import QRCode

class VoucherViewController: UIViewController{

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var qrCode: UIImageView!
    @IBAction func copyBtn(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if codeTF.text != "" {
//            var qrCode = QRCode(codeTF.text)
//            qrCode?.color = CIColor(rgba: "910003")
//            qrcodeIV.image = qrCode?.image
//        }
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
