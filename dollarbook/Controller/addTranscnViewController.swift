//
//  addTranscnViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 12/01/23.
//

import UIKit
import TagsList
import NVActivityIndicatorView
import Toaster
import GLWalkthrough
import Kingfisher
protocol addTrnsnViewUpdt
{
    //func updtTags(tags:[String])
    func updtCrncy(TblTyp:String)
    func crncyTblSelect(crncy:String,crncyId:String,crncycode:String)
    func acntsTblSelect(acnt:String,acntId:String)
    func trnsfrAcntSelect(acnt:String,acntId:String,typ:String)
    func Tags()
    func BackAfterDataAdd()
    func closeSetAcntView()
    func valdteAcntcrncy(alrtStr:String)
    func loadAcntCln()
    func clkCtgryFill(ctgryNme:String, ctgryId:String,tagIcnUrl:String,tagIcnClr:UIColor)
    
    //func IncExpTypeValSet(typ:String)
    //var IncExpTypVal: String {get set}
 
}
class addTranscnViewController: UIViewController,UITextFieldDelegate,NVActivityIndicatorViewable,addTrnsnViewUpdt {
    var coachMarker:GLWalkThrough!
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor(red: 244/255, green: 243/255, blue: 249/255, alpha: 1.0).cgColor,
            UIColor.white.cgColor
        ]
        gradient.locations = [0,0.25]
        return gradient
    }()
    
    @IBOutlet weak var ctgryVieBtmCnstrt: NSLayoutConstraint!
    var addTrnscViewMdlObj = addTrnscnViewModel()
    @IBOutlet weak var acntClctnView:UICollectionView!
    @IBOutlet weak var acntIcn:UIImageView!
    @IBOutlet weak var crncyIcn:UIImageView!
    @IBOutlet weak var acntNmeIcn:UIImageView!
    @IBOutlet weak var acntAmntIcn:UIImageView!
    @IBOutlet weak var amountTxt:UITextField!
    @IBOutlet weak var amntBackBtn:UIButton!
    @IBOutlet weak var tickBtn:UIButton!
    @IBOutlet weak var tickImg:UIImageView!
    @IBOutlet weak var dateTxt:UITextField!
    @IBOutlet weak var noteTxt:UITextField!
    @IBOutlet weak var acntTxt:UITextField!
    @IBOutlet weak var acntBtn:UIButton!
    @IBOutlet weak var crncyTxt:UITextField!
    @IBOutlet weak var crncyIdTxt:UITextField!
    @IBOutlet weak var crncyCodeTxt:UITextField!
    @IBOutlet weak var backImg:UIImageView!
    @IBOutlet weak var backBtn:UIButton!
    @IBOutlet weak var ctgryLbl:UILabel!
    @IBOutlet weak var ctgrySlcIcn:UIImageView!
    @IBOutlet weak var ctgryIcnBgLbl:UILabel!
    @IBOutlet weak var ctgryArrw:UIImageView!
    @IBOutlet weak var ctgryBtn:UIButton!
    @IBOutlet weak var ctgryLineLbl:UILabel!
    @IBOutlet weak var ctgryBgBlckLbl:UILabel!
    @IBOutlet weak var notesToAmntCnstrt:NSLayoutConstraint!
    @IBOutlet weak var frmAcntTxt:UITextField!
    @IBOutlet weak var frmAcntBtn:UIButton!
    @IBOutlet weak var toAcntTxt:UITextField!
    @IBOutlet weak var toAcntBtn:UIButton!
    @IBOutlet weak var incExpCnstr:NSLayoutConstraint!
    @IBOutlet weak var trnsfrCnstr:NSLayoutConstraint!
    
    
    //Acnt Add Fields
    @IBOutlet weak var acntNmeTxt:UITextField!
    @IBOutlet weak var intlAmntTxt:UITextField!
    
    @IBOutlet weak var crncyTbl:UITableView!
    @IBOutlet var crncyTblView : UIView!
    var datePicker : UIDatePicker!
    @IBOutlet var topTitle : UILabel!
    @IBOutlet var slctTblTitle : UILabel!
    @IBOutlet var frmAcntLbl : UILabel!
    @IBOutlet var toAcntLbl : UILabel!
    @IBOutlet var addCrncyAcntView : UIView!
    @IBOutlet var addIncExpView,CategoryGridView : UIView!
    @IBOutlet var noteValidator : UIImageView!
    @IBOutlet var acntValidator : UIImageView!
    @IBOutlet weak var tagsCln:UICollectionView!
    var IncExpTypVal = ""
    var crncyIdVal = ""
    var acntIdVal = ""
    var frmAcntIdVal = ""
    var toAcntIdVal = ""
    var dateVal = ""
    
    //Tags
    var Slctd:[Int] = []
    var SlctdTagname:[String] = []
    var SlctdTagId:[String] = []
    var items = [TagViewItem]()
    var tagsListView: TagsListProtocol = TagsList()
    var dataSource: DefaultTagsListDataSource!
    let scroll = UIScrollView()
    let color = UIColor.purple
    var hgt = 0.0
    var randomStrings: [String] = [
        "Bakery", "Movies", "Mobile Bills", "Medicine", "Recharge", "Repair","House","Apparels", "School fees", "Electricity", "Loan emi", "Books", "Cosmetics","Charity","Fuel", "Insurance", "Servants", "e shopping"]
    
    func clkCtgryFill(ctgryNme:String, ctgryId:String,tagIcnUrl:String,tagIcnClr:UIColor)
        {
            
            self.ctgryLbl.text = ctgryNme
            self.ctgryIcnBgLbl.backgroundColor = tagIcnClr
            self.ctgryIcnBgLbl.layer.cornerRadius =  self.ctgryIcnBgLbl.frame.width/2
            self.ctgryIcnBgLbl.layer.masksToBounds = true
            self.ctgryIcnBgLbl.alpha = 0.2
            if let url = URL(string: tagIcnUrl) {
                let processor = OverlayImageProcessor(overlay: tagIcnClr, fraction: 0.1)
                
                // Load the image with Kingfisher and apply the tint
                //                           self.ctgryIcon.kf.setImage(
                //                                       with: url)
                self.ctgrySlcIcn.kf.setImage(with: url, options: [.processor(processor)])
            }
            self.ctgryIcnBgLbl.backgroundColor = tagIcnClr
            self.ctgryIcnBgLbl.alpha  = 0.2
            self.SlctdTagname.append(ctgryNme)
            self.SlctdTagId.append(ctgryId)
            self.closeCategory()
        }
    func valdteAcntcrncy(alrtStr:String) {
        DispatchQueue.main.async {
        
        self.stopAnimating()
        Toast(text: alrtStr).show()
        ToastView.appearance().backgroundColor = ColorManager.expenseColor()
        ToastView.appearance().textColor = .white
        }
        
//        let alert = UIAlertController(title: "Dollar Book", message: alrtStr, preferredStyle: UIAlertController.Style.alert)
//                // add an action (button)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                // show the alert
//                self.present(alert, animated: true, completion: nil)
    }
    func loadAcntCln() {
        self.stopAnimating()
        
//            self.tagsCln.isHidden = false
//            self.noTags.isHidden = true
        //self.acntClctnView.isHidden = false
            self.acntClctnView.reloadData()
        UIView.animate(withDuration: 0.5) { //1
            self.acntClctnView.frame = CGRect(x: 0, y: self.acntClctnView.frame.height, width: 0, height: 0) //2
            //self.acntClctnView.center = self.view.center //3
        }
    }
    func updtCrncy(TblTyp:String) {
        DispatchQueue.main.async {
        
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
        self.crncyTblView.isHidden = false
        }
    }
    func closeSetAcntView() {
        DispatchQueue.main.async {
            self.stopAnimating()
            //self.setControlsforAdding()
            
            self.addCrncyAcntView.isHidden = true
            self.addIncExpView.isHidden = true
            
            //self.addIncExpView.isHidden = false
            //self.addbutton.isHidden = false
            
            self.back()
        }
        
    }
    func BackAfterDataAdd() {
        DispatchQueue.main.async {
        
        self.stopAnimating()
        }
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let vc = storyboard.instantiateViewController(withIdentifier: "1")
//            vc.loadViewIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainTabBarController = storyboard.instantiateViewController(identifier: "1")
                    mainTabBarController.modalPresentationStyle = .fullScreen
                    
                    self.present(mainTabBarController, animated: true, completion: nil)
        })
        
    }
    func Tags()
    {
        DispatchQueue.main.async {
        
        print("sss")
        if(UserDefaults.standard.value(forKey: "accountExist") as! String == "0")
        {
        }
        else
        {
            //self.setTagsListData()
            //self.tagsListView.reloadCollectionData()
        }
        }
    }
    func acntsTblSelect(acnt: String, acntId: String) {
        DispatchQueue.main.async {
            
            //self.acntTxt.text = acnt
            self.acntIdVal = acntId
            self.acntValidator.isHidden = true
            self.crncyTblView.isHidden = true
            self.slctTblTitle.text = "Select Account"
            if(self.IncExpTypVal == "1" || self.IncExpTypVal == "2")
            {
                if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.acntIdVal != "")
                {
                    self.tickImg.image = UIImage(named: "tick")
                    self.tickBtn.tag = 1
                    if(self.IncExpTypVal == "1")
                    {
                       // self.tickImg.setImageColor(color: ColorManager.incomeColor())
                    }
                    else if(self.IncExpTypVal == "2")
                    {
                       // self.tickImg.setImageColor(color: ColorManager.expenseColor())
                    }
                    self.enableTickBtn()
                }
                else
                {
                    self.tickImg.image = UIImage(named: "tickGrey")
                    self.tickBtn.tag = 0
                   // self.tickBtn.isHidden = true
                }
            }
            else
            {
                if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.frmAcntTxt.text! != "" && self.toAcntTxt.text! != "")
                {
                    self.tickImg.image = UIImage(named: "tick")
                    self.tickBtn.tag = 1
                    //self.tickImg.setImageColor(color: ColorManager.transferColor())
                    self.enableTickBtn()
                }
                else
                {
                    self.tickImg.image = UIImage(named: "tickGrey")
                    self.tickBtn.tag = 0
                   // self.tickBtn.isHidden = true
                }
            }
            self.amountTxt.becomeFirstResponder()
        }
    }
    func showSimpleAlert() {
        let alert = UIAlertController(title: "Dollarbook", message: "Both cannot be same", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func trnsfrAcntSelect(acnt:String,acntId:String,typ:String)
    {
        DispatchQueue.main.async {
            
            if(typ == "from")
            {
                if(self.toAcntIdVal == acntId)
                {
//                    alertmanager.showBeautifulAlert(on: self, title: "Dollar", message: "To and From Account can't be same!")
                    alertmanager.showCustomAlert(title: "", message: "From and To Account can't be the same!", on: self)
                    //self.showSimpleAlert()
                }
                else
                {
                    self.frmAcntTxt.text = acnt
                    self.frmAcntTxt.backgroundColor = UIColor(red: 238/255, green: 232/255, blue: 255/255, alpha: 1.0)
                    self.frmAcntTxt.borderColor = ColorManager.incomeColor()
                    self.frmAcntTxt.textColor = ColorManager.incomeColor()
                    self.frmAcntTxt.cornerRadius = self.frmAcntTxt.frame.height/2
                    self.frmAcntIdVal = acntId
                    self.crncyTblView.isHidden = true
                    self.acntClctnView.isHidden = true
                }
                //self.slctTblTitle.text = "Select Account"
            }
            else if(typ == "to")
            {
                if(self.frmAcntIdVal == acntId)
                {
//                    alertmanager.showBeautifulAlert(on: self, title: "Dollar", message: "To and From Account can't be same!")
                    alertmanager.showCustomAlert(title: "", message: "From and To Account can't be the same!", on: self)
                    //self.showSimpleAlert()
                }
                else
                {
                    self.toAcntTxt.text = acnt
                    self.toAcntTxt.backgroundColor = UIColor(red: 238/255, green: 232/255, blue: 255/255, alpha: 1.0)
                    self.toAcntTxt.borderColor = ColorManager.incomeColor()
                    self.toAcntTxt.textColor = ColorManager.incomeColor()
                    self.toAcntTxt.cornerRadius = self.frmAcntTxt.frame.height/2
                    self.toAcntIdVal = acntId
                    self.crncyTblView.isHidden = true
                    self.acntClctnView.isHidden = true
                }
            }
            if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.frmAcntTxt.text! != "" && self.toAcntTxt.text! != "")
            {
                self.tickImg.image = UIImage(named: "tick")
                self.tickBtn.tag = 1
                //self.tickImg.setImageColor(color: ColorManager.transferColor())
                self.enableTickBtn()
            }
            else
            {
                self.tickImg.image = UIImage(named: "tickGrey")
                self.tickBtn.tag = 0
               // self.tickBtn.isHidden = true
            }
        }
    }
    func crncyTblSelect(crncy: String, crncyId: String,crncycode:String) {
        //textView.attributedText = htmlText.htmlToAttributedString
        DispatchQueue.main.async {
            
            self.crncyTxt.text = "\(crncy)"
            self.crncyIdTxt.text = crncyId
            self.crncyCodeTxt.text = crncycode
            self.crncyTblView.isHidden = true
        }
    }
    @IBAction func clkSubmit()
    {
        self.view.endEditing(true)
//        if(self.tickBtn.tag == 0)
//        {
//            Toast(text: "Fill all the fields to add ",delay: 0.0).show()
//            ToastView.appearance().backgroundColor = ColorManager.expenseColor()
//            ToastView.appearance().textColor = .white
//            print("Fill values")
//        }
        if(self.dateTxt.text! == "")
        {
            Toast(text: "Pick a date of transaction",delay: 0.0).show()
                        ToastView.appearance().backgroundColor = ColorManager.expenseColor()
                        ToastView.appearance().textColor = .white
        }
        else if(self.amountTxt.text! == "")
        {
            Toast(text: "Enter amount",delay: 0.0).show()
                        ToastView.appearance().backgroundColor = ColorManager.expenseColor()
                        ToastView.appearance().textColor = .white
            
            self.amountTxt.backgroundColor = ColorManager.expenseColor()
            self.amountTxt.cornerRadius = 15
            self.amountTxt.layer.masksToBounds = true
        }
        else if(self.noteTxt.text! == "")
        {
            Toast(text: "Enter a note for transaction",delay: 0.0).show()
                        ToastView.appearance().backgroundColor = ColorManager.expenseColor()
                        ToastView.appearance().textColor = .white
            self.noteValidator.isHidden = false
        }
//        else if(self.acntIdVal == "")
//        {
//            
//            self.noteValidator.isHidden = true
//            if(self.IncExpTypVal == "3") // Means it is a transfer
//            {
//                Toast(text: "Select from and to account",delay: 0.0).show()
//                ToastView.appearance().backgroundColor = ColorManager.expenseColor()
//                ToastView.appearance().textColor = .white
//            }
//            if(self.IncExpTypVal != "3") // Means is income or expense
//            {
//                Toast(text: "Select an account",delay: 0.0).show()
//                            ToastView.appearance().backgroundColor = ColorManager.expenseColor()
//                            ToastView.appearance().textColor = .white
//                self.acntValidator.isHidden = false
//            }
//        }
        else
        {
            if(self.IncExpTypVal == "1" || self.IncExpTypVal == "2")
            {
                 if(self.acntIdVal == "")
                {
                    
                    self.noteValidator.isHidden = true
                    
                    if(self.IncExpTypVal != "3") // Means is income or expense
                    {
                        Toast(text: "Select an account",delay: 0.0).show()
                                    ToastView.appearance().backgroundColor = ColorManager.expenseColor()
                                    ToastView.appearance().textColor = .white
                        self.acntValidator.isHidden = false
                    }
                }
                else
                {
                    self.addTrnscn()
                }
            }
            else
            {
                self.addTransfer()
            }
        }
    }
    @IBAction func addTrnscn()
    {
        self.startAnimating()
        var amount = self.amountTxt.text!
        var nte = self.noteTxt.text!
        self.view.endEditing(true)
        DispatchQueue.global().async {
            self.addTrnscViewMdlObj.addInc(amnt:amount  , descr: nte, acnt: self.acntIdVal, date: self.dateVal, tag: self.SlctdTagname.joined(separator: ", "),type:self.IncExpTypVal, usertags:self.SlctdTagId.joined(separator: ", "))
        }
        
    }
    @IBAction func addTransfer()
    {
        if(self.frmAcntIdVal == "" || self.toAcntIdVal == "")
        {
            stopAnimating()
            Toast(text: "Select from and to accounts !",delay: 0.0).show()
            ToastView.appearance().backgroundColor = ColorManager.expenseColor()
            ToastView.appearance().textColor = .white
        }
        else if(self.frmAcntIdVal == self.toAcntIdVal)
        {
            stopAnimating()
            Toast(text: "From account and to account cannot be same !",delay: 0.0).show()
            ToastView.appearance().backgroundColor = ColorManager.expenseColor()
            ToastView.appearance().textColor = .white
            
            
        }
        else
        {
            self.startAnimating()
            var amount = self.amountTxt.text!
            var nte = self.noteTxt.text!
            self.view.endEditing(true)
            DispatchQueue.global().async {
                self.addTrnscViewMdlObj.addTrnsfr(amnt:amount  , descr: nte,frmAcnt: self.frmAcntIdVal,toAcnt: self.toAcntIdVal, date: self.dateVal, tag: self.SlctdTagId.joined(separator: ", "),type:self.IncExpTypVal, usertags:"")
            }
            
        }
        
    }
    @IBAction func crncyAcntSubmit()
    {
        self.startAnimating()
        var acntNme = self.acntNmeTxt.text!
        var intlAmnt = self.intlAmntTxt.text!
        var crncyId = self.crncyIdTxt.text!
        var crncyCode = self.crncyCodeTxt.text!
        var crncyName = self.crncyTxt.text!
        self.view.endEditing(true)
        
        DispatchQueue.global().async {
            
            self.addTrnscViewMdlObj.validateAcntCrncy(acnt: acntNme,intlAmnt:intlAmnt,crncyIdVal:crncyId,crncyCode: crncyCode)
        
            //self.addTrnscViewMdlObj.addAcnt(acntNme: acntNme,acntIntAmnt:intlAmnt, crncyId: crncyId,crncy:crncyName,crncyCode:crncyCode)
        }
        
        
        
    }
    @objc func keyboardWillAppear() {
        self.scroll.isHidden = false
        //Do something here
    }
    @IBAction func closeAcntVIew()
    {
        self.crncyTblView.isHidden = true
    }
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
            let screenSize: CGRect = UIScreen.main.bounds

            let screenWidth = screenSize.width
            let screenHeight = screenSize.height
            //self.hgt = screenHeight - keyboardHeight-143
            self.hgt = screenHeight - keyboardHeight-90
                //self.setupPlaceForTagsList()
                self.setView(view: scroll, hidden: false)
            
//            if(self.amountTxt.text != "")
//            {
//                self.enableTickBtn()
//            }
//             if(self.noteTxt.text != "")
//            {
//                 self.enableTickBtn()
//            }
            if(self.IncExpTypVal == "1" || self.IncExpTypVal == "2")
            {
                if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.acntIdVal != "")
                {
                    self.tickImg.image = UIImage(named: "tick")
                    self.tickBtn.tag = 1
                    if(self.IncExpTypVal == "1")
                    {
                        //self.tickImg.setImageColor(color: ColorManager.incomeColor())
                    }
                    else if(self.IncExpTypVal == "2")
                    {
                        //self.tickImg.setImageColor(color: ColorManager.expenseColor())
                    }
                    self.enableTickBtn()
                }
                else
                {
                    self.tickImg.image = UIImage(named: "tickGrey")
                    self.tickBtn.tag = 0
                   // self.tickBtn.isHidden = true
                }
            }
            else
            {
                if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.frmAcntTxt.text! != "" && self.toAcntTxt.text! != "")
                {
                    self.tickImg.image = UIImage(named: "tick")
                    self.tickBtn.tag = 1
                   // self.tickImg.setImageColor(color: ColorManager.transferColor())
                    self.enableTickBtn()
                }
                else
                {
                    self.tickImg.image = UIImage(named: "tickGrey")
                    self.tickBtn.tag = 0
                    // self.tickBtn.isHidden = true
                }
            }
            
            }
             // Add code later...
        }
        
        @objc func keyboardWillHide(_ notification: NSNotification) {
            //scroll.isHidden = true
            if(self.IncExpTypVal == "1" || self.IncExpTypVal == "2")
            {
                if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.acntIdVal != "")
                {
                    self.tickImg.image = UIImage(named: "tick")
                    self.tickBtn.tag = 1
                    if(self.IncExpTypVal == "1")
                    {
                       // self.tickImg.setImageColor(color: ColorManager.incomeColor())
                    }
                    else if(self.IncExpTypVal == "2")
                    {
                       // self.tickImg.setImageColor(color: ColorManager.expenseColor())
                    }
                    self.enableTickBtn()
                }
                else
                {
                    self.tickImg.image = UIImage(named: "tickGrey")
                    self.tickBtn.tag = 0
                   // self.tickBtn.isHidden = true
                }
            }
            else
            {
                if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.frmAcntTxt.text! != "" && self.toAcntTxt.text! != "")
                {
                    self.tickImg.image = UIImage(named: "tick")
                    self.tickBtn.tag = 1
                   // self.tickImg.setImageColor(color: ColorManager.transferColor())
                    self.enableTickBtn()
                }
                else
                {
                    self.tickImg.image = UIImage(named: "tickGrey")
                    self.tickBtn.tag = 0
                   // self.tickBtn.isHidden = true
                }
            }
            self.setView(view: scroll, hidden: true)
             // Add code later...
        }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if(self.IncExpTypVal == "1" || self.IncExpTypVal == "2")
        {
            self.ctgryLbl.isHidden = false
            self.ctgrySlcIcn.isHidden = false
            self.ctgryIcnBgLbl.isHidden = false
            self.ctgryArrw.isHidden = false
            self.ctgryBtn.isHidden = false
            self.ctgryLineLbl.isHidden = false
            self.notesToAmntCnstrt.constant = 92
        }
        else
        {
            self.ctgryLbl.isHidden = true
            self.ctgrySlcIcn.isHidden = true
            self.ctgryIcnBgLbl.isHidden = true
            self.ctgryArrw.isHidden = true
            self.ctgryBtn.isHidden = true
            self.ctgryLineLbl.isHidden = true
            self.notesToAmntCnstrt.constant = 25
            
            
        }
        self.ctgryIcnBgLbl.layer.cornerRadius =  self.ctgryIcnBgLbl.frame.width/2
        self.ctgryIcnBgLbl.layer.masksToBounds = true
        self.ctgryIcnBgLbl.alpha = 0.2
        self.ctgryBgBlckLbl.isHidden = true
        self.ctgryVieBtmCnstrt.constant = -565
        self.amountTxt.delegate = self
        self.noteValidator.isHidden = true
        self.acntValidator.isHidden = true
        gradient.frame = self.addIncExpView.bounds
        self.addIncExpView.layer.insertSublayer(gradient, at: 0)
        
        self.acntClctnView.isHidden = false
        self.acntClctnView.tag = 1
        self.tagsCln.tag = 2
        self.addTrnscViewMdlObj.getAcnts(typ: "trnscn")
        self.addTrnscViewMdlObj.addTrnscnViewDlgt = self
        self.acntClctnView.dataSource = addTrnscViewMdlObj
        self.acntClctnView.delegate = addTrnscViewMdlObj
        self.tagsCln.dataSource = addTrnscViewMdlObj
        self.tagsCln.delegate = addTrnscViewMdlObj
        self.acntClctnView.allowsMultipleSelection = false
        let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
        let crcyCode = crncy.htmlToString
        self.amountTxt.placeholder = "\(crcyCode)0"
        self.amountTxt.addTarget(self, action: #selector(addTranscnViewController.textFieldDidChange(_:)), for: .editingChanged)
        self.noteTxt.addTarget(self, action: #selector(addTranscnViewController.textFieldDidChange(_:)), for: .editingChanged)
        
        self.crncyTblView.isHidden = true
        if(self.IncExpTypVal == "1")
        {
            self.amountTxt.textColor = ColorManager.incomeColor()
            self.topTitle.text = "Add Income"
        }
        else if(self.IncExpTypVal == "2")
        {
            self.topTitle.text = "Add Expense"
            self.amountTxt.textColor = ColorManager.expenseColor()
        }
        else
        {
            self.topTitle.text = "Add Transfer"
            self.amountTxt.textColor = ColorManager.transferColor()
        }
        NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(self.keyboardWillShow),
                    name: UIResponder.keyboardWillShowNotification,
                    object: nil)

                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(self.keyboardWillHide),
                    name: UIResponder.keyboardWillHideNotification,
                    object: nil)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//            self.setTagsListData()
//            self.tagsListView.reloadCollectionData()
        })
        self.addTrnscViewMdlObj.addTrnscnViewDlgt = self
        if(UserDefaults.standard.value(forKey: "accountExist") as! String == "0")
        {
            
            self.addCrncyAcntView.isHidden = false
            self.addIncExpView.isHidden = true
            let iconContainer2 = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
            let mailView2 = UIImageView(frame: CGRect(x: -10, y: 0, width: 18, height: 18))
            mailView2.image = UIImage(named: "ddlArrow")
            mailView2.contentMode = .scaleAspectFit
            iconContainer2.addSubview(mailView2)
            self.crncyTxt.rightViewMode = .always
            self.crncyTxt.rightView = iconContainer2
            
            
        }
        else
        {
            self.amntBackBtn.isHidden = true
            
            self.amountTxt.addTarget(self, action: #selector(yourHandler(textField:)), for: .editingChanged)
            self.noteTxt.addTarget(self, action: #selector(yourHandler(textField:)), for: .editingChanged)
            self.noteTxt.leftViewMode = UITextField.ViewMode.always
            
            let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
            let mailView = UIImageView(frame: CGRect(x: 4, y: 0, width: 18, height: 18))
            mailView.image = UIImage(named: "notes")
            mailView.contentMode = .scaleAspectFit
            iconContainer.addSubview(mailView)
            self.noteTxt.leftViewMode = .always
//            self.noteTxt.leftView = iconContainer
//            
//            let iconContainer1 = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
//            let mailView1 = UIImageView(frame: CGRect(x: 4, y: 0, width: 18, height: 18))
//            mailView1.image = UIImage(named: "ddlArrow")
//            mailView1.contentMode = .scaleAspectFit
//            iconContainer1.addSubview(mailView1)
           // self.acntTxt.rightViewMode = .always
           // self.acntTxt.rightView = iconContainer1
            
            let iconContainer2 = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
            let mailView2 = UIImageView(frame: CGRect(x: -10, y: 0, width: 18, height: 18))
            mailView2.image = UIImage(named: "ddlArrow")
            mailView2.contentMode = .scaleAspectFit
            iconContainer2.addSubview(mailView2)

          //  self.frmAcntTxt.rightViewMode = .always
            //self.frmAcntTxt.rightView = iconContainer2
            
            let iconContainer3 = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
            let mailView3 = UIImageView(frame: CGRect(x: -10, y: 0, width: 18, height: 18))
            mailView3.image = UIImage(named: "ddlArrow")
            mailView3.contentMode = .scaleAspectFit
            iconContainer3.addSubview(mailView3)
           // self.toAcntTxt.rightViewMode = .always
           // self.toAcntTxt.rightView = iconContainer3
            setupTagsList()
            self.addTrnscViewMdlObj.addTrnscnViewDlgt = self
            DispatchQueue.global().async {
            
            //self.addTrnscViewMdlObj.getDefltTags()
            self.addTrnscViewMdlObj.getTags()
            }
            let todaysDate = Date()
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateStyle = .medium
            dateFormatter2.timeStyle = .none
            dateFormatter2.dateFormat = "EE, MMM d, yyyy"
            self.dateTxt.text = dateFormatter2.string(from: todaysDate)
            dateFormatter2.dateFormat = "yyyy-MM-dd hh:mm:ss"
            self.dateVal = dateFormatter2.string(from: todaysDate)
            
            
            //self.tickBtn.isHidden = true
            self.tickImg.image = UIImage(named: "tickGrey")
            self.addCrncyAcntView.isHidden = true
            self.addIncExpView.isHidden = false
            self.amountTxt.becomeFirstResponder()
            if(self.IncExpTypVal == "1" || self.IncExpTypVal == "2")
            {
                
                //self.acntTxt.isHidden = false
                self.frmAcntTxt.isHidden = true
                self.toAcntTxt.isHidden = true
                
                self.toAcntBtn.isHidden = true
                self.frmAcntBtn.isHidden = true
                
                self.frmAcntLbl.isHidden = true
                self.toAcntLbl.isHidden = true
                
                self.incExpCnstr.constant = 0
                self.trnsfrCnstr.constant = 20
                //self.acntBtn.isHidden = false
            }
            else
            {
               // self.acntTxt.isHidden = true
                self.frmAcntTxt.isHidden = false
                self.toAcntTxt.isHidden = false
                
                self.toAcntBtn.isHidden = false
                self.frmAcntBtn.isHidden = false
                
                self.frmAcntLbl.isHidden = false
                self.toAcntLbl.isHidden = false
                
                self.incExpCnstr.constant = 34
                self.trnsfrCnstr.constant = 132
                self.acntClctnView.isHidden = true
                //self.acntBtn.isHidden = true
            }
        }
        
        
        
        //self.noteTxt.clearButtonMode = .always
        
//        self.acntTxt.leftViewMode = UITextField.ViewMode.always
//        let imageView1 = UIImageView(frame: CGRect(x: 3, y: 0, width: 10, height: 10))
//        let image1 = UIImage(named: "ddlArrow")
//        imageView1.image = image1
//        self.acntTxt.leftView = imageView1
        // Do any additional setup after loading the view.
    }
    func setControlsForTrnscn()
    {
        
    }
    func enableTickBtn()
    {
        self.tickBtn.isHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if(UserDefaults.standard.value(forKey: "accountExist") as! String == "0")
        {
            coachMarker = GLWalkThrough()
            coachMarker.dataSource = self
            coachMarker.delegate = self
            coachMarker.show()
        }
        else
        {
            setupPlaceForTagsList()
        }
    }
    private func setTagsListData() {
        
        if(self.IncExpTypVal == "1")
        {
            items = addTrnscnViewModel.incmTagArry.compactMap({ TagViewItem($0) })
        }
        else  if(self.IncExpTypVal == "2")
        {
            items = addTrnscnViewModel.expnsTagArry.compactMap({ TagViewItem($0) })
        }
        for index in 0...items.count {
            if(self.Slctd.count>0)
            {
                if(self.Slctd.contains(index))
                {
                    items[index].backgroundColor = .darkGray
                }
            }
//            if index % 2 == 0 {
//                items[index].sideImage = getItemImage(index)
//                items[index].backgroundColor = getItemBackgroundColor(index)
//                items[index].backgroundColor = .purple
//
//            }
        }
       // items.insert(createCustomMinecraftItem(), at: items.count / 2)
        
        tagsListView.tagsListDataSource = self
        tagsListView.tagsListDelegate = self
        

        
        
    }
    private func setupPlaceForTagsList() {
        
        view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: self.hgt),
            scroll.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scroll.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.12)
            
        ])
        scroll.isScrollEnabled = true
        scroll.alwaysBounceVertical = true
        scroll.backgroundColor = .clear
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        scroll.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 30),
            stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: -30),
            stack.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 0)
        ])
        
        
    }

    private func setupTagsList() {
        scroll.addSubview(tagsListView)
        
        tagsListView.translatesAutoresizingMaskIntoConstraints = false
        tagsListView.backgroundColor = .white
        tagsListView.layer.borderColor = UIColor.clear.cgColor
        tagsListView.layer.borderWidth = 2
        
        
        NSLayoutConstraint.activate([
            tagsListView.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            tagsListView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 0),
            tagsListView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: 30),
            tagsListView.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 0),
            tagsListView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -30)
        ])
        
        tagsListView.itemsConfiguration.sideImageEverytimeDisplaying = false
        tagsListView.itemsConfiguration.xButtonEverytimeDisplaying = false
        tagsListView.contentOrientation = .horizontal
        tagsListView.itemsConfiguration.backgroundColor = .lightGray
        tagsListView.itemsConfiguration.itemCornerRadius = 5
        tagsListView.minimumInteritemSpacing = 5.0
        
        tagsListView.itemsConfiguration.maxWidth = view.frame.width - 70
        tagsListView.heightForVerticalContentOrientation = 200
    }
    @objc final private func yourHandler(textField: UITextField) {
//        if(textField.text!.count == 10)
//        {
//            textField.inputView = UIView()
//        }
//        else
//        {
//            textField.isEnabled = true
//        }
        if(textField.text!.count > 0)
        {
            self.amntBackBtn.isHidden = false
        }
        else
        {
            self.amntBackBtn.isHidden = true
        }
        if(self.IncExpTypVal == "1" || self.IncExpTypVal == "2")
        {
            if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.acntIdVal != "")
            {
                self.tickImg.image = UIImage(named: "tick")
                self.tickBtn.tag = 1
                if(self.IncExpTypVal == "1")
                {
                   // self.tickImg.setImageColor(color: ColorManager.incomeColor())
                }
                else if(self.IncExpTypVal == "2")
                {
                  //  self.tickImg.setImageColor(color: ColorManager.expenseColor())
                }
                self.enableTickBtn()
            }
            else
            {
                self.tickImg.image = UIImage(named: "tickGrey")
                self.tickBtn.tag = 0
                //self.tickBtn.isHidden = true
            }
        }
        else
        {
            if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.frmAcntTxt.text! != "" && self.toAcntTxt.text! != "")
            {
                self.tickImg.image = UIImage(named: "tick")
                self.tickBtn.tag = 1
                //self.tickImg.setImageColor(color: ColorManager.transferColor())
                self.enableTickBtn()
            }
            else
            {
                self.tickImg.image = UIImage(named: "tickGrey")
                self.tickBtn.tag = 0
                //self.tickBtn.isHidden = true
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if(textField.text! == "" )
//        {
//            self.tickImg.image = UIImage(named: "tickGrey")
//        }
//        else
//        {
//            self.tickImg.image = UIImage(named: "tick")
//        }
        if(textField == self.amountTxt)
        {
            let maxLength = 10
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        }
        else
        {
            return true
        }
        
            
    }
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        //self.datePicker.backgroundColor = self.themeColor
        self.datePicker.datePickerMode = UIDatePicker.Mode.date
        self.datePicker.maximumDate = Date()
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
    @objc func textFieldDidChange(_ textField: UITextField) {
        if(textField == self.amountTxt)
        {
            let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
            let crcyCode = crncy.htmlToString
            self.amountTxt.backgroundColor = UIColor.clear
//            if let text = textField.text {
//                if(text.count == 1)
//                {
//                    if((self.amountTxt.text!.contains("$")))
//                    {
//                        //self.amountTxt.placeholder = "\(crcyCode)\0"
//                    }
//                    else
//                    {
//                        self.amountTxt.text = "\(crcyCode)\(text)"
//                    }
//                }
//            }
//            else
//            {
//                self.amountTxt.placeholder = "\(crcyCode)\0"
//            }
//            if let text = textField.text, !text.isEmpty {
//                self.amountTxt.backgroundColor = UIColor.clear
//                print("Text entered: \(text)")
//            }
//            else
//            {
//                self.amountTxt.backgroundColor = UIColor.clear
//            }
        }
        if(textField == self.noteTxt)
        {
            self.noteValidator.isHidden = true
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
            if let text = textField.text, !text.isEmpty {
                self.amountTxt.backgroundColor = UIColor.clear
                
                print("Text entered: \(text)")
            } else {
                self.noteValidator.isHidden = true
                self.amountTxt.backgroundColor = UIColor.clear
                print("Text field is empty")
            }
        }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == self.amountTxt)
        {
            if let text = textField.text, !text.isEmpty {
                self.amountTxt.backgroundColor = UIColor.clear
                
                print("Text entered: \(text)")
            } else {
                self.amountTxt.backgroundColor = UIColor.clear
                print("Text field is empty")
            }
        }
        if(textField == self.dateTxt)
        {
            self.pickUpDate(self.dateTxt)
//            let screenSize: CGRect = UIScreen.main.bounds
//            let screenHeight = screenSize.height
//
//            self.hgt = screenHeight - 416
//                self.setupPlaceForTagsList()
//            self.tagsListView.layoutIfNeeded()
//                self.setView(view: scroll, hidden: false)
        }
        else if(textField == self.acntTxt)
        {
            self.clkAccount()
        }
        else if(textField == self.amountTxt || textField == self.noteTxt)
        {
            
            if(self.IncExpTypVal == "1" || self.IncExpTypVal == "2")
            {
                if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.acntIdVal != "")
                {
                    self.tickImg.image = UIImage(named: "tick")
                    self.tickBtn.tag = 1
                    if(self.IncExpTypVal == "1")
                    {
                        //self.tickImg.setImageColor(color: ColorManager.incomeColor())
                    }
                    else if(self.IncExpTypVal == "2")
                    {
                       // self.tickImg.setImageColor(color: ColorManager.expenseColor())
                    }
                    self.enableTickBtn()
                }
                else
                {
                    self.tickImg.image = UIImage(named: "tickGrey")
                    self.tickBtn.tag = 0
                    //self.tickBtn.isHidden = true
                }
            }
            else
            {
                if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.frmAcntTxt.text! != "" && self.toAcntTxt.text! != "")
                {
                    self.tickImg.image = UIImage(named: "tick")
                    self.tickBtn.tag = 1
                    //self.tickImg.setImageColor(color: ColorManager.transferColor())
                    self.enableTickBtn()
                }
                else
                {
                    self.tickImg.image = UIImage(named: "tickGrey")
                    self.tickBtn.tag = 0
                    //self.tickBtn.isHidden = true
                }
            }
        }
    }
    
    
    
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        dateFormatter1.dateFormat = "EE, MMM d, yyyy"
        self.dateTxt.text = dateFormatter1.string(from: datePicker.date)
        self.dateTxt.resignFirstResponder()
        
      
        dateFormatter1.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        self.dateVal = dateFormatter1.string(from: datePicker.date)
        
        
        if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.acntIdVal != "")
       {
            self.tickImg.image = UIImage(named: "tick")
            self.tickBtn.tag = 1
            if(self.IncExpTypVal == "1")
            {
               // self.tickImg.setImageColor(color: ColorManager.incomeColor())
            }
            else if(self.IncExpTypVal == "2")
            {
               // self.tickImg.setImageColor(color: ColorManager.expenseColor())
            }
            self.enableTickBtn()
       }
        else
        {
            self.tickImg.image = UIImage(named: "tickGrey")
            self.tickBtn.tag = 0
            //self.tickImg.setImageColor(color: ColorManager.transferColor())
           // self.tickBtn.isHidden = true
        }
        
    }
    @objc func cancelClick() {
        self.dateTxt.text = ""
        self.dateTxt.resignFirstResponder()
    }
    @IBAction func amntBackClck()
    {
        var updtStr = self.amountTxt.text?.dropLast()
        self.amountTxt.text = "\(updtStr!)"
        if(updtStr! == "")
        {
            self.tickImg.image = UIImage(named: "tickGrey")
            //self.tickBtn.isHidden = true
            self.amntBackBtn.isHidden = true
        }
    }
    @IBAction func clkAccount()
    {
        self.startAnimating()
        self.view.endEditing(true)
        //self.crncyTblView.isHidden = false
        self.addTrnscViewMdlObj.getAcnts(typ: "trnscn")
        self.addTrnscViewMdlObj.addTrnscnViewDlgt = self
        self.crncyTbl.dataSource = addTrnscViewMdlObj
        self.crncyTbl.delegate = addTrnscViewMdlObj
        self.acntClctnView.dataSource = addTrnscViewMdlObj
        self.acntClctnView.delegate = addTrnscViewMdlObj
        
    }
    @IBAction func clkFrmAcnt()
    {
        self.view.endEditing(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
            self.acntClctnView.isHidden = false
        })
       
        self.clkTrnsfr(typ: "from")
    }
    @IBAction func clkToAcnt()
    {
        self.view.endEditing(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
            self.acntClctnView.isHidden = false
        })
        
        self.clkTrnsfr(typ: "to")
    }
    @IBAction func clkTrnsfr(typ:String)
    {
        self.startAnimating()
        self.view.endEditing(true)
        //self.crncyTblView.isHidden = false
        if(typ == "from")
        {
            self.addTrnscViewMdlObj.getAcnts(typ: "from")
        }
        else if(typ == "to")
        {
            self.addTrnscViewMdlObj.getAcnts(typ: "to")
        }
        self.addTrnscViewMdlObj.addTrnscnViewDlgt = self
        self.crncyTbl.dataSource = addTrnscViewMdlObj
        self.crncyTbl.delegate = addTrnscViewMdlObj
        
    }
    @IBAction func clkCrncy()
    {
        self.startAnimating()
        self.view.endEditing(true)
        //self.crncyTblView.isHidden = false
        self.addTrnscViewMdlObj.getCurrency()
        self.addTrnscViewMdlObj.addTrnscnViewDlgt = self
        self.crncyTbl.dataSource = addTrnscViewMdlObj
        self.crncyTbl.delegate = addTrnscViewMdlObj
        
    }
    
    @IBAction func clickCategory()
    {
        
//        UIView.animate(withDuration: 0.5, animations: {
//            // Change the top constraint to bring the view into the visible area
//            self.CategoryGridView.transform = CGAffineTransform(translationX: 0, y: 0-self.CategoryGridView.frame.height)
//            //self.ctgryVieBtmCnstrt.constant = 0
//        })
        self.view.endEditing(true)
        
        // Curve only the top corners
        self.CategoryGridView.layer.cornerRadius = 30 // Adjust the radius as needed
        self.CategoryGridView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top-left and top-right corners
        self.CategoryGridView.layer.masksToBounds = true
        self.ctgryVieBtmCnstrt.constant = -60
        self.tagsCln.reloadData()
        UIView.animate(withDuration: 0.7, animations: {
            self.ctgryBgBlckLbl.isHidden = false
                    self.view.layoutIfNeeded()
                }, completion: { _ in
                    print("Animation complete")
                    
                })
    }
    @IBAction func closeCategory()
    {
//        UIView.animate(withDuration: 0.5, animations: {
//            // Change the top constraint to bring the view into the visible area
//            self.CategoryGridView.transform = CGAffineTransform(translationX: 0, y: 0+self.CategoryGridView.frame.height+60)
//            //self.ctgryVieBtmCnstrt.constant = -350
//        })
        self.ctgryVieBtmCnstrt.constant = -585
        UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { _ in
                    print("Animation complete")
                    self.ctgryBgBlckLbl.isHidden = true
                })
    }
    @IBAction func back()
    {
        self.dismiss(animated: false, completion: nil)
    }
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
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
extension addTranscnViewController: TagsListDataSource {
    
    func tagsListItemsCount(_ TagsList: TagsListProtocol) -> Int {
        return items.count
    }
    
    func tagsListViewItem(_ TagsList: TagsListProtocol, index: Int) -> TagViewItem {
        let item = items[index]
        return item
    }
    func removeTagsListItem(_ index: Int) {
        items.remove(at: index)
    }
}
extension addTranscnViewController: TagsListDelegate {
    func tagsListCellTouched(_ TagsList: TagsListProtocol, index: Int) {
        if(self.Slctd.contains(index))
        {
            
            if let indexx = self.Slctd.firstIndex(of: index) {
                self.Slctd.remove(at: indexx)
                if(self.IncExpTypVal == "1")
                {
                    if(addTrnscnViewModel.incmTagTypeArry[index] == "addedTag")
                    {
                        self.SlctdTagId.remove(at: indexx)
                    }
                    else
                    {
                        self.SlctdTagname.remove(at: indexx)
                    }
                }
                else
                {
                    if(addTrnscnViewModel.expnsTagTypeArry[index] == "addedTag")
                    {
                        self.SlctdTagId.remove(at: indexx)
                    }
                    else
                    {
                        self.SlctdTagname.remove(at: indexx)
                    }
                }
            }
        }
        else
        {
            self.Slctd.append(index)
            if(self.IncExpTypVal == "1")
            {
                if(addTrnscnViewModel.incmTagTypeArry[index] == "addedTag")
                {
                    self.SlctdTagId.append(addTrnscnViewModel.incmTagIdArry[index])
                }
                else
                {
                    self.SlctdTagname.append(addTrnscnViewModel.incmTagArry[index])
                    
                }
            }
            else
            {
                if(addTrnscnViewModel.expnsTagTypeArry[index] == "addedTag")
                {
                    self.SlctdTagId.append(addTrnscnViewModel.expnsTagIdArry[index])
                }
                else
                {
                    self.SlctdTagname.append(addTrnscnViewModel.expnsTagArry[index])
                }
            }
            
        }
        //tagsListView.itemsConfiguration.backgroundColor = .red
        self.setTagsListData()
        tagsListView.reloadCollectionData()
        print("\nCell with index: \(index) was touched")
    }

    func tagsListCellXButtonTouched(_ TagsList: TagsListProtocol, index: Int) {
        print("\nxButton from cell with tag index: \(index) was touched")
    }
}
extension addTranscnViewController: GLWalkThroughDelegate {
    func didSelectNextAtIndex(index: Int) {
        if index == 3 {
            coachMarker.dismiss()
//            let alert = UIAlertController(title: "You are now ready to add", message: nil, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func didSelectSkip(index: Int) {
        coachMarker.dismiss()
    }
    
    
}
extension addTranscnViewController: GLWalkThroughDataSource {
    func getTabbarFrame(index:Int) -> CGRect? {
        if let bar = self.tabBarController?.tabBar.subviews {
            var idx = 0
            var frame:CGRect!
            for view in bar {
                if view.isKind(of: NSClassFromString("UITabBarButton")!) {
                    print(view.description)
                    if idx == index {
                        frame =  view.frame
                    }
                    idx += 1
                }
            }
            return frame
        }
        return nil
    }
    
    func numberOfItems() -> Int {
        return 7
    }
    
    func configForItemAtIndex(index: Int) -> GLWalkThroughConfig {
        let tabbarPadding:CGFloat = Helper.shared.hasTopNotch ? 88 : 50
        let overlaySize:CGFloat = Helper.shared.hasTopNotch ? 60 : 50
        let leftPadding:CGFloat = Helper.shared.hasTopNotch ? 10 : 5
        switch index {
        case 0:
            var config = GLWalkThroughConfig()
            config.title = "Set Account"
            config.subtitle = "You need to set an account before adding income, expense or transfers. \n\nIt is actually very easy"
            config.frameOverWindow = CGRect(x: self.acntIcn.frame.origin.x-20, y: 70, width: overlaySize, height: overlaySize)
            config.position = .topLeft
            return config
//                    case 1:
//
//                        var config = GLWalkThroughConfig()
//                        config.title = "Select Currency"
//                        config.subtitle = "Select a currency of your choice, this can be changed later also."
//                        config.frameOverWindow = CGRect(x: self.crncyIcn.frame.origin.x-15, y: self.crncyIcn.frame.origin.y+38, width: overlaySize, height: overlaySize)
//                        config.position = .topLeft
//                        return config
                    case 1:
            var config = GLWalkThroughConfig()
            config.title = "Account Name"
            config.subtitle = "Enter a name for your bank account."
            config.frameOverWindow = CGRect(x: self.acntNmeIcn.frame.origin.x-15, y: self.acntNmeIcn.frame.origin.y+38, width: overlaySize, height: overlaySize)
            config.position = .topLeft

                        return config
                    case 2:
            var config = GLWalkThroughConfig()
            config.title = "Initial Amount"
            config.subtitle = "Add initial amount in the account."
            config.frameOverWindow = CGRect(x: self.acntAmntIcn.frame.origin.x-15, y: self.acntAmntIcn.frame.origin.y+38, width: overlaySize, height: overlaySize)
            config.position = .topLeft
                        return config
//                    case 4:
//                        guard let frame = getTabbarFrame(index: 2) else {
//                            return GLWalkThroughConfig()
//                        }
//                        var config = GLWalkThroughConfig()
//                        config.title = "General Queries"
//                        config.subtitle = "Ask your question in a General Forum"
//                        config.frameOverWindow = CGRect(x: frame.origin.x + leftPadding, y: view.frame.size.height - tabbarPadding, width: overlaySize, height: overlaySize)
//                        config.position = .bottomCenter
//                        return config
//
//
//                    case 5:
//                        guard let frame = getTabbarFrame(index: 3) else {
//                            return GLWalkThroughConfig()
//                        }
//                        var config = GLWalkThroughConfig()
//                        config.title = "My Profile"
//                        config.subtitle = "Your Account details, Wallets, Settings"
//                        config.frameOverWindow = CGRect(x: frame.origin.x + leftPadding, y: view.frame.size.height - tabbarPadding, width: overlaySize, height: overlaySize)
//                        config.position = .bottomRight
//                        return config
//                    case 6:
//                        guard let frame = getTabbarFrame(index: 4) else {
//                            return GLWalkThroughConfig()
//                        }
//                        var config = GLWalkThroughConfig()
//                        config.title = "ChatBot"
//                        config.subtitle = "Ask a Service, Query, Plan to Bot"
//                        config.nextBtnTitle = "Ask a Query"
//
//                        config.frameOverWindow = CGRect(x: frame.origin.x + leftPadding, y: view.frame.size.height - tabbarPadding, width: overlaySize, height: overlaySize)
//                        config.position = .bottomRight
//                        return config
//                    case 7:
//
//                        var config = GLWalkThroughConfig()
//                        config.title = "ChatBot"
//                        config.subtitle = "Ask a Service, Query, Plan to Bot"
//                        config.nextBtnTitle = "Ask a Query"
//
//            //            config.frameOverWindow = CGRect
//                        config.position = .bottomCenter
//                        return config
        default:
            return GLWalkThroughConfig()
        }
    }
    struct Helper {
        static var shared = Helper()
        
        var hasTopNotch: Bool {
            if #available(iOS 11.0, tvOS 11.0, *) {
                return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
            }
            return false
        }
    }
}
