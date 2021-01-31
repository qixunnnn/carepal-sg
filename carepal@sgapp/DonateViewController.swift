//
//  DonateViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 1/2/21.
//

import UIKit

class DonateViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
    @IBOutlet weak var conditionBtn: UIButton!
    @IBOutlet weak var conditionImg: UIImageView!
    @IBOutlet weak var expiryDateImg: UIImageView!
    @IBOutlet weak var expiryDateBtn: UIButton!
    let imagePicker1 = UIImagePickerController()
    let imagePicker = UIImagePickerController()
   
    @IBOutlet weak var brandTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var otherDetailsTV: UITextView!
    @IBOutlet weak var donateBtn: CheckBox!
    @IBOutlet weak var agreeBtn: CheckBox!
    @IBAction func SubmitBtn(_ sender: Any) {
        if(donateBtn.isSelected && agreeBtn.isSelected)
        {
            //do submit data
            //perform segue back home
            //performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
        }
        else
        {
            //display error
            let alert = UIAlertController(title: "Empty Check Box!", message: "Please tick the terms and agreements", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func conditionBtnA(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
        {
            //for condition
            imagePicker1.delegate = self
            imagePicker1.sourceType = UIImagePickerController.SourceType.camera
            imagePicker1.allowsEditing = false
            self.present(imagePicker1, animated: true, completion: nil)
        }
    }
    @IBAction func expiryDateBtnA(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
        {
            //for expiry date
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if(picker == imagePicker)
        {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            {
                expiryDateImg.image = pickedImage
                expiryDateBtn.setImage(nil, for: .normal)
            }
        }
        else
        {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            {
                conditionImg.image = pickedImage
                conditionBtn.setImage(nil, for: .normal)
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
   
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardAdjusted == false {
            lastKeyboardOffset = getKeyboardHeight(notification: notification)
            view.frame.origin.y -= lastKeyboardOffset
            keyboardAdjusted = true
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardAdjusted == true {
            view.frame.origin.y += lastKeyboardOffset
            keyboardAdjusted = false
        }
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let Lesserheight = keyboardSize.cgRectValue.height
        return Lesserheight - 200.0
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
