//
//  addViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 10/09/22.
//

import UIKit
import TaggerKit
class addExpnseViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var SlctdTagTitle: UILabel!
    @IBOutlet weak var tagsListedCnstr: NSLayoutConstraint!
    @IBOutlet weak var noTagTxtClickedCnstr: NSLayoutConstraint!
    @IBOutlet weak var dateTxt:UITextField!
    @IBOutlet var addTagsTextField    : TKTextField!
    @IBOutlet var searchContainer    : UIView!
    @IBOutlet var testContainer        : UIView!
    var datePicker : UIDatePicker!
    var productTags: TKCollectionView!
    var allTags: TKCollectionView!
    var tagselected:Bool!
    func tagOnload()
    {
        self.noTagTxtClickedCnstr.constant = 20
        self.tagsListedCnstr.constant = 0
        self.searchContainer.isHidden = true
        self.SlctdTagTitle.isHidden = true
        self.testContainer.isHidden = true
    }
    func tagtxtClicked()
    {
        self.noTagTxtClickedCnstr.constant = 164
        self.tagsListedCnstr.constant = 20
        self.searchContainer.isHidden = false
        self.SlctdTagTitle.isHidden = true
        self.testContainer.isHidden = true
    }
    func tagSelected()
    {
        self.noTagTxtClickedCnstr.constant = 354
        self.tagsListedCnstr.constant = 210
        self.searchContainer.isHidden = false
        self.SlctdTagTitle.isHidden = false
        self.testContainer.isHidden = false
    }
//    private func textFieldDidChangeSelection(_ textField: TKTextField) {
//        validateTextField(text:textField.text!)
//    }
//    func validateTextField(text:String) {
//      if text.count > 0 {
//          self.tagtxtClicked()
//      }
//        else
//        {
//            self.tagOnload()
//        }
//      }
    @objc final private func yourHandler(textField: UITextField) {
        print("Text changed")
        if(textField.text!.count>0)
        {
            if(self.tagselected! == true)
            {
                self.tagSelected()
                //self.tagtxtClicked()
            }
            else
            {
                self.tagtxtClicked()
            }
        }
        else if(textField.text!.count==0)
        {
            self.tagOnload()
        }
        
    }
    override func viewDidLoad() {
        self.addTagsTextField.addTarget(self, action: #selector(yourHandler(textField:)), for: .editingChanged)
        self.tagselected = false
        super.viewDidLoad()
        self.tagOnload()
        productTags = TKCollectionView(tags: [
                                        
                                       ],
                                       action: .removeTag,
                                       receiver: nil)
        
        allTags = TKCollectionView(tags: [
                                    "Cars", "Skateboard", "Freetime", "Humor", "Travel", "Music", "Places", "Journalism", "Sports"
                                   ],
                                   action: .addTag,
                                   receiver: productTags)
        
        // Set the current controller as the delegate of both collections
        productTags.delegate = self
        allTags.delegate = self
        
        // Set the sender and receiver of the TextField
        addTagsTextField.sender     = allTags
        addTagsTextField.receiver     = productTags
        
        add(productTags, toView: testContainer)
        add(allTags, toView: searchContainer)
        self.allTags.customTagBorderColor = UIColor.white
        self.allTags.customBackgroundColor = UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
        self.productTags.customTagBorderColor = UIColor.white
        self.productTags.customBackgroundColor = UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
        
        
        // Do any additional setup after loading the view.
    }
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor(red: 95/255, green: 185/255, blue: 238/255, alpha: 1)
        self.datePicker.datePickerMode = UIDatePicker.Mode.date
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 95/255, green: 185/255, blue: 238/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(addExpnseViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(addExpnseViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        self.dateTxt.text = dateFormatter1.string(from: datePicker.date)
        self.dateTxt.resignFirstResponder()
    }
    @objc func cancelClick() {
        self.dateTxt.resignFirstResponder()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == self.dateTxt)
        {
            self.pickUpDate(self.dateTxt)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        self.searchContainer.dropShadow(color: UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.3), opacity: 0.2, offSet: CGSize(width: -1, height: 1), radius: 17, scale: true)
        self.testContainer.dropShadow(color: UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.2), opacity: 0.2, offSet: CGSize(width: -1, height: 1), radius: 17, scale: true)
        
    }
    @IBAction func back()
    {
        self.dismiss(animated: false, completion: nil)
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
extension addExpnseViewController: TKCollectionViewDelegate {

    func tagIsBeingAdded(name: String?) {
        self.tagselected = true
        self.tagSelected()
        // Example: save testCollection.tags to UserDefault
        print("added \(name!)")
    }
    
    func tagIsBeingRemoved(name: String?) {
        print("removed \(name!)")
    }
}
