//
//  DonateViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 1/2/21.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

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
    
    let database = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    let storage = Storage.storage().reference()
    
    var conditionData = Data()
    var expiryData = Data()
    
    @IBAction func SubmitBtn(_ sender: Any) {
        if(donateBtn.isSelected && agreeBtn.isSelected)
        {
            if brandTF.text == "" || nameTF.text == "" {
                alert(message: "Empty Field", title: "Please enter all the fields")

            }
            else
            {
                if expiryDateImg.image == nil || conditionImg.image == nil {
                    alert(message: "Empty Image", title: "Please fill in both images for condition and expiry")
                }
                else
                {
                    let conditionURL = uploadImage(cimage: conditionImg.image!)
                    let expiryURL = uploadImage(cimage: expiryDateImg.image!)
                    //["FirstName" : firstName! as NSString, "LastName":lastName! as NSString, "Contact": cNo! as NSString, "Points": 0 as NSNumber]
                    self.database.child("Donations").childByAutoId().setValue(["userid" : self.userID! as NSString, "productname" : self.nameTF.text! as NSString, "brand" :self.brandTF.text! as NSString, "conditionURL" : conditionURL as NSString, "expiryURL": expiryURL])
                    alert(message: "You can collect now pass the product to the community center", title: "Sucessful")
                }
            }
            
        }
        else
        {
            //display error
            alert(message: "Empty Check Box!", title: "Please tick the terms and agreements")
        }
    }
    
    func uploadImage(cimage:UIImage) -> String
    {
        let identifier = UUID()
        let data = (cimage.jpegData(compressionQuality: 0.8))!
        //set upload path
        let filePath = "Donation/\(identifier)"
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        
        var sUrl:String = ""
        let ref = storage.child(filePath)
        ref.putData(data, metadata: metaData) { (metadata, error) in
            if error == nil
            {
                ref.downloadURL { (url, error) in
                    sUrl = String(describing: url)
                    print("Done, url is \(String(describing: url))")
                }
            } else
            {
                print(error)
            }
        }
        return sUrl
    }
    
    func alert(message:String, title:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
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
