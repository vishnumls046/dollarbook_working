//
//  editViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 10/09/22.
//

import UIKit
import TaggerKit
import TransitionButton
import NVActivityIndicatorView
protocol editViewUpdt
{
    func updtTags(tags:[String])
    func updtCrncy(TblTyp:String)
    //func crncyTblSelect(crncy:String,crncyId:String,crncycode:String)
    func acntsTblSelect(acnt:String,acntId:String)
    func valdteAcntcrncy(alrtStr:String)
    func alerts(alrtStr:String)
    
    func closeSetAcntView()
    func BackAfterDataAdd()
    func fillValues(tnscn:TransactionDet)
    //func IncExpTypeValSet(typ:String)
    //var IncExpTypVal: String {get set}
 
}
class editViewController: UIViewController,UIGestureRecognizerDelegate,UITextFieldDelegate,editViewUpdt,UIScrollViewDelegate,NVActivityIndicatorViewable {
    func fillValues(tnscn: TransactionDet) {
        self.amountTxt.text = tnscn.transactionAmount!
        self.descrpnTxt.text = tnscn.transactionText!
        self.acntIdVal = tnscn.accountId!
        self.dateTxt.text = tnscn.clearedDate!
        
    }
    
    func BackAfterDataAdd() {
        self.back()
    }
    
    //var IncExpTypVal: String = ""
    
    
    
//    func IncExpTypeValSet(typ: String) {
//        var IncExpTypVal: String {
//                get {
//                    return "5"
//                }
//                set(newValue) {
//                    // ... do whatever is appropriate ...
//                }
//            }
//
//    }
//
    
    
    
    
    
    
    
    
    func closeSetAcntView() {
        self.addCrncyAcntView.isHidden = true
        self.addIncExpView.isHidden = false
        self.addbutton.isHidden = false
        //self.back()
    }
    
    func valdteAcntcrncy(alrtStr:String) {
        let alert = UIAlertController(title: "Dollar Book", message: alrtStr, preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    func alerts(alrtStr:String)
    {
        let alert = UIAlertController(title: "Dollar Book", message: alrtStr, preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) in
            self.back()}))
                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    func updtCrncy(TblTyp:String) {
        self.stopAnimating()
        if(TblTyp == "currency")
        {
            self.slctTblTitle.text = "Select Currency"
        }
        else
        {
            self.slctTblTitle.text = "Select Account"
        }
        self.crncyTbl.reloadData()
    }
//    func crncyTblSelect(crncy: String, crncyId: String,crncycode:String) {
//        //textView.attributedText = htmlText.htmlToAttributedString
//
//        self.crncyTxt.text = "\(crncy)"
//        self.crncyIdTxt.text = crncyId
//        self.crncyCodeTxt.text = crncycode
//        self.crncyTblView.isHidden = true
//
//    }
    func acntsTblSelect(acnt: String, acntId: String) {
        self.acntFillTxt.text = acnt
        self.acntIdVal = acntId
        self.crncyTblView.isHidden = true
        self.slctTblTitle.text = "Select Account"
    }
    
    
    func updtTags(tags: [String]) {
        print(tags)
        self.TagsArry.append(contentsOf: tags)
//        allTags = TKCollectionView(tags: tags,
//                                   action: .addTag,
//                                   receiver: productTags)
//        allTags.delegate = self
//        add(allTags, toView: searchContainer)
//        self.allTags.customTagBorderColor = UIColor.white
//        self.allTags.customBackgroundColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
//
//        productTags = TKCollectionView(tags: [
//
//                                       ],
//                                       action: .removeTag,
//                                       receiver: nil)
//        productTags.delegate = self
//        add(productTags, toView: testContainer)
//        self.productTags.customTagBorderColor = UIColor.white
//        self.productTags.customBackgroundColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
    }
    var IncExpTypVal = ""
    var crncyIdVal = ""
    var acntIdVal = ""
    var themeColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    var tagsAry:[String] = []
    var tagsIdAry:[String] = []
    
    var TagsArry:[String] = []
    var SlctdTagsArry:[String] = []
    var SlctdUserTagsArry:[String] = []
    @IBOutlet weak var closeImg:UIImageView!
    @IBOutlet weak var addTopTitle:UILabel!
    @IBOutlet weak var addamountTxtTitle:UILabel!
    @IBOutlet weak var addIncExpScroll:UIScrollView!
    @IBOutlet weak var crncyTxt:UITextField!
    @IBOutlet weak var crncyIdTxt:UITextField!
    @IBOutlet weak var crncyCodeTxt:UITextField!
    @IBOutlet weak var acntNmeTxt:UITextField!
    @IBOutlet weak var intlAmntTxt:UITextField!
    @IBOutlet weak var crncyTbl:UITableView!
    @IBOutlet weak var dateTxt:UITextField!
    @IBOutlet weak var acntFillTxt:UITextField!
    @IBOutlet weak var descrpnTxt:UITextField!
    @IBOutlet weak var amountTxt:UITextField!
    @IBOutlet weak var createTagBtn:UIButton!
    @IBOutlet weak var downImg:UIImageView!
    var datePicker : UIDatePicker!
    @IBOutlet weak var crtTagCnstrt: NSLayoutConstraint!
    @IBOutlet var addTagsTextField    : TKTextField!
    @IBOutlet var addTagsImgBg    : UIImageView!
    @IBOutlet var searchContainer    : UIView!
    @IBOutlet var testContainer        : UIView!
    @IBOutlet var crncyTblView : UIView!
    @IBOutlet var addIncExpView : UIView!
    @IBOutlet var addCrncyAcntView : UIView!
    @IBOutlet var addLbl : UILabel!
    @IBOutlet var bgLbl : UILabel!
    @IBOutlet var slctTblTitle : UILabel!
    @IBOutlet var crtTagBtn : UIButton!
    @IBOutlet var addbutton : TransitionButton!
    var userTagOrnot = 0
    var keybrdSts = 0
    var productTags: TKCollectionView!
    var allTags: TKCollectionView!
    var editTrnsViewMdlObj = editTrnscnViewModel()
    static var totTagArry = [Tags]()
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    override func viewDidLoad() {
        self.closeImg.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        super.viewDidLoad()
        //        self.startAnimating()
//        DispatchQueue.global().async {
//            self.editTrnsViewMdlObj.getTransactionValues()
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
//
//            self.annex()
//        })
        //IncExpTypeValSet(typ: "")
        //        if(UserDefaults.standard.value(forKey: "crncy") == nil || UserDefaults.standard.value(forKey: "acnt") == nil)
        //        {
        
       
        
        
    }
    
    func annex()
    {
        self.stopAnimating()
        self.amountTxt.text = editTrnscnViewModel.trans.transactionAmount!
        self.descrpnTxt.text = editTrnscnViewModel.trans.transactionText!
        self.acntFillTxt.text = editTrnscnViewModel.trans.accountName!
        self.acntIdVal = editTrnscnViewModel.trans.accountId!
        self.dateTxt.text = editTrnscnViewModel.trans.clearedDate!
        self.IncExpTypVal = editTrnscnViewModel.trans.transactionType!
        self.closeImg.isHidden = true
//        if(UserDefaults.standard.value(forKey: "accountExist") as! String == "0")
//        {
//            self.addCrncyAcntView.isHidden = false
//            self.addIncExpView.isHidden = true
//            self.addbutton.isHidden = true
//        }
//        else
//        {
            self.addCrncyAcntView.isHidden = true
            self.addIncExpView.isHidden = false
            self.addbutton.isHidden = false
            //self.SlctdTagsArry.append(contentsOf: editTrnscnViewModel.tagsNameArry)
            productTags = TKCollectionView(tags: editTrnscnViewModel.tagsNameArry,
                                           action: .removeTag,
                                           receiver: nil)
            self.SlctdTagsArry.append(contentsOf: editTrnscnViewModel.tagsIdArry)
            //self.SlctdTagsArry = editTrnscnViewModel.tagsIdArry
            if(self.IncExpTypVal == "1")
            {
                allTags = TKCollectionView(tags: editTrnscnViewModel.incmTagArry,
                                           action: .addTag,
                                           receiver: productTags)
                self.themeColor =  UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
                self.addTopTitle.text = "Edit Income"
                self.addamountTxtTitle.text = "Income Amount"
                self.addbutton.setTitle("Edit Income", for: .normal)
                self.addbutton.backgroundColor = self.themeColor
            }
            else
            {
                self.themeColor =  UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
                allTags = TKCollectionView(tags: editTrnscnViewModel.expnsTagArry,
                                           action: .addTag,
                                           receiver: productTags)
                self.addTopTitle.text = "Edit Expense"
                self.addamountTxtTitle.text = "Expense Amount"
                self.addbutton.setTitle("Edit Expense", for: .normal)
                self.addbutton.backgroundColor = self.themeColor
                
            }
            self.amountTxt.textColor = self.themeColor
            self.descrpnTxt.textColor = self.themeColor
            self.acntFillTxt.textColor = self.themeColor
            self.dateTxt.textColor = self.themeColor
//            self.createTagBtn.borderWidth = 1
//            self.createTagBtn.layer.cornerRadius = 22
//            self.createTagBtn.borderColor = self.themeColor
//            self.downImg.tintColor = themeColor
            
            //Set Input controls theme coclor
            
            // Set the current controller as the delegate of both collections
            productTags.delegate = self
            
            
            // Set the sender and receiver of the TextField
            addTagsTextField.sender     = allTags
            addTagsTextField.receiver     = productTags
            addTagsTextField.delegate = self
            
            add(productTags, toView: testContainer)
            allTags.delegate = self
            add(allTags, toView: searchContainer)
            
            self.productTags.customTagBorderColor = UIColor.white
            self.productTags.customBackgroundColor = self.themeColor
            
            self.allTags.customTagBorderColor = UIColor.white
            self.allTags.customBackgroundColor = self.themeColor
    //        Timer.scheduledTimer(timeInterval: 1.7, target: self, selector: #selector(self.alarmAlertActivate), userInfo: nil, repeats: true)
            // Do any additional setup after loading the view.
            self.addbutton.spinnerColor = .white
            self.addbutton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            
//            self.crncyTbl.layer.cornerRadius = 15
//            self.crncyTbl.layer.masksToBounds = true
            //self.crncyTbl.dropShadow(color: UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.3), opacity: 0.5, offSet: CGSize(width: -1, height: 1), radius: 17, scale: true)
//            self.crncyTbl.borderColor = self.themeColor
//            self.crncyTbl.borderWidth = 1
       // }
        
        
        self.crncyTblView.isHidden = true
       // self.crtTagCnstrt.constant = 45
//        self.addTagsImgBg.isHidden = true
//        self.addTagsTextField.isHidden = true
        self.editTrnsViewMdlObj.editViewDlgt = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
    }
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 416))
        self.datePicker.backgroundColor = self.themeColor
        self.datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle = .wheels
        } else {
            
            // Fallback on earlier versions
        }
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .darkGray
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
        dateFormatter1.dateFormat = "yyyy-MM-dd hh:mm:ss"
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
        if(textField == self.addTagsTextField)
        {
            self.userTagOrnot = 1
            self.addIncExpScroll.setContentOffset(CGPointMake(0, max(self.addIncExpScroll.contentSize.height - self.addIncExpScroll.bounds.size.height+150, 0) ), animated: true)
        }
        
    }
    @IBAction func closeAcntVIew()
    {
        self.crncyTblView.isHidden = true
    }
//    @IBAction func clkCrncy()
//    {
//        self.view.endEditing(true)
//        self.crncyTblView.isHidden = false
//        self.editTrnsViewMdlObj.getCurrency()
//        self.editTrnsViewMdlObj.editViewDlgt = self
//        //self.crncyTbl.dataSource = addDataViewMdlObj
//        //self.crncyTbl.delegate = addDataViewMdlObj
//    }
    @IBAction func clkAccount()
    {
        self.closeImg.isHidden = false
        self.view.endEditing(true)
        self.crncyTblView.isHidden = false
        self.startAnimating()
        DispatchQueue.global().async {
            self.editTrnsViewMdlObj.getAcnts()
        }
        
        self.editTrnsViewMdlObj.editViewDlgt = self
        self.crncyTbl.dataSource = editTrnsViewMdlObj
        self.crncyTbl.delegate = editTrnsViewMdlObj
    }
    @IBAction func clkCrtTag()
    {
        if(self.addTagsImgBg.isHidden == true)
        {
            self.crtTagCnstrt.constant = 101
            self.addTagsImgBg.isHidden = false
            self.addTagsTextField.isHidden = false
            self.crtTagBtn.transform = self.crtTagBtn.transform.rotated(by: CGFloat(Double.pi))
            self.addIncExpScroll.setContentOffset(CGPointMake(0, max(self.addIncExpScroll.contentSize.height - self.addIncExpScroll.bounds.size.height+130, 0) ), animated: true)
            self.addTagsTextField.becomeFirstResponder()
            
        }
        else
        {
            self.crtTagCnstrt.constant = 35
            self.addTagsImgBg.isHidden = true
            self.addTagsTextField.isHidden = true
            self.crtTagBtn.transform = self.crtTagBtn.transform.rotated(by: CGFloat(Double.pi))
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.startAnimating()
        DispatchQueue.global().async {
            self.editTrnsViewMdlObj.getTransactionValues()
            self.editTrnsViewMdlObj.getTags()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            
            self.annex()
        })
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    @objc func keyboardWillAppear() {
        //Do something here
        //print("A")
        self.keybrdSts = 1
    }

    @objc func keyboardWillDisappear() {
        self.keybrdSts = 0
        //print("A")
        //Do something here
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil)
    {
        if(self.keybrdSts == 1)
        {
            self.dismissKeyboard()
            self.keybrdSts = 0
        }
        else if(self.crncyTblView.isHidden != false)
        {
            self.back()
        }
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func buttonAction(_ button: TransitionButton) {
        self.addbutton.startAnimation() // 2: Then start the animation when the user tap the button
            let qualityOfServiceClass = DispatchQoS.QoSClass.background
            let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
            backgroundQueue.async(execute: {
                
                sleep(3) // 3: Do your networking task or background work here.
                
                DispatchQueue.main.async(execute: { () -> Void in
                    // 4: Stop the animation, here you have three options for the `animationStyle` property:
                    // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                    // .shake: when you want to reflect to the user that the task did not complete successfly
                    // .normal
                    self.addbutton.stopAnimation(animationStyle: .shake, completion: {
                        //let secondVC = UIViewController()
                        //self.present(secondVC, animated: true, completion: nil)
                    })
                })
            })
        }
//    @IBAction func crncyAcntSubmit()
//    {
//        self.addDataViewMdlObj.validateAcntCrncy(crncy: self.crncyTxt.text!, acnt: self.acntNmeTxt.text!,intlAmnt:self.intlAmntTxt.text!,crncyIdVal:self.crncyIdTxt.text!,crncyCode: self.crncyCodeTxt.text!)
//
//    }
    @IBAction func IncExpSubmit()
    {
        self.editTrnsViewMdlObj.validateIncmExpsAddiotion(amnt: self.amountTxt.text!, descrptn: self.descrpnTxt.text!, acnt: self.acntIdVal, date: self.dateTxt.text!, tag: self.SlctdTagsArry,typeVal:self.IncExpTypVal,userTags:self.SlctdUserTagsArry)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        self.searchContainer.dropShadow(color: UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.3), opacity: 0.2, offSet: CGSize(width: -1, height: 1), radius: 17, scale: true)
        self.testContainer.dropShadow(color: UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.2), opacity: 0.2, offSet: CGSize(width: -1, height: 1), radius: 17, scale: true)
        //self.addBtn.doGlowAnimation(withColor: UIColor.purple, withEffect: .big)
        
    }
    @IBAction func back()
    {
        self.dismiss(animated: false, completion: nil)
    }
    @objc func alarmAlertActivate(){
            UIView.animate(withDuration: 0.7) {
                //self.addLbl.alpha = self.addLbl.alpha == 1.0 ? 0.8 : 1.0
//                self.addLbl.backgroundColor = self.addLbl.backgroundColor == UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0) ? UIColor(red: 145/255, green: 111/255, blue: 200/255, alpha: 1.0) : UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
                self.addLbl.doGlowAnimation(withColor: UIColor.white, withEffect: .big)
                self.addLbl.layer.cornerRadius = 20
            }
        }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view!.isDescendant(of: self.crncyTbl) == true || touch.view!.isDescendant(of: self.addIncExpView) == true {
            
            return false
         }
        else
        {
            return true
        }
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
extension editViewController: TKCollectionViewDelegate {

    func tagIsBeingAdded(name: String?) {
        // Example: save testCollection.tags to UserDefault
        print("added \(name!)")
        //var tagsAry = UserDefaults.standard.value(forKey: "incDefltTags")! as! [String]
        //var tagsIdAry = UserDefaults.standard.value(forKey: "incDefltIdTags")! as! [String]
        if(self.IncExpTypVal == "1")
        {
            self.tagsAry = editTrnscnViewModel.incmTagArry
            self.tagsIdAry = editTrnscnViewModel.incmTagIdArry
        }
        else
        {
            //self.tagsAry = AddDataViewModel.expnsTagArry
            self.tagsAry.append(contentsOf: editTrnscnViewModel.expnsTagArry)
            //self.tagsIdAry = AddDataViewModel.expnsTagIdArry
            self.tagsIdAry.append(contentsOf: editTrnscnViewModel.expnsTagIdArry)
        }
        if let index = self.tagsAry.firstIndex(of: name!) {
            print("Index - \(index)")
            print("ID - \(self.tagsIdAry[index])")
            self.SlctdTagsArry.append(self.tagsIdAry[index])
            print(self.SlctdTagsArry)
            
            //index has the position of first match
        } else {
            print("User tag or not - \(self.userTagOrnot)")
            
            self.SlctdUserTagsArry.append(name!)
            //element is not present in the array
        }
        self.view.endEditing(true)
        self.addIncExpScroll.setContentOffset(CGPointMake(0, max(self.addIncExpScroll.contentSize.height - self.addIncExpScroll.bounds.size.height+100, 0) ), animated: true)
    }
    
    func tagIsBeingRemoved(name: String?) {
        print("removed \(name!)")
        if(self.IncExpTypVal == "1")
        {
            //self.tagsAry = AddDataViewModel.incmTagArry
            self.tagsAry.append(contentsOf: editTrnscnViewModel.incmTagArry)
            //self.tagsIdAry = AddDataViewModel.incmTagIdArry
            self.tagsIdAry.append(contentsOf: editTrnscnViewModel.incmTagIdArry)
        }
        else
        {
            //self.tagsAry = AddDataViewModel.expnsTagArry
            self.tagsAry.append(contentsOf: editTrnscnViewModel.expnsTagArry)
            //self.tagsIdAry = AddDataViewModel.expnsTagIdArry
            self.tagsIdAry.append(contentsOf: editTrnscnViewModel.expnsTagIdArry)
        }
//        var tagsAry = UserDefaults.standard.value(forKey: "incDefltTags")! as! [String]
//        var tagsIdAry = UserDefaults.standard.value(forKey: "incDefltIdTags")! as! [String]
        if let index = tagsAry.firstIndex(of: name!) {
            print("Index - \(index)")
            print("ID - \(tagsIdAry[index])")
            self.SlctdTagsArry.removeAll(where: { $0 == tagsIdAry[index] })
            print(self.SlctdTagsArry)
            //index has the position of first match
        } else {
            self.SlctdUserTagsArry.removeAll(where: { $0 == name! })
            //element is not present in the array
        }
        self.view.endEditing(true)
    }
}



