//
//  editTrnscnViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 12/01/23.
//

import UIKit
import TagsList
import NVActivityIndicatorView
import Toaster
import Kingfisher
protocol editTrnsnViewUpdt
{
    //func updtTags(tags:[String])
    func updtCrncy(TblTyp:String)
    func crncyTblSelect(crncy:String,crncyId:String,crncycode:String)
    func acntsTblSelect(acnt:String,acntId:String)
    func trnsfrAcntSelect(acnt:String,acntId:String,typ:String)
    func Tags()
    func BackAfterDataAdd()
    func closeSetAcntView()
    func fills()
    func loadAcntCln()
    func clkCtgryFill(ctgryNme:String, ctgryId:String,tagIcnUrl:String,tagIcnClr:UIColor)
    //func valdteAcntcrncy(alrtStr:String)
    
    
    //func IncExpTypeValSet(typ:String)
    //var IncExpTypVal: String {get set}
 
}
class editTrnscnViewController: UIViewController,UITextFieldDelegate,NVActivityIndicatorViewable,editTrnsnViewUpdt,UIScrollViewDelegate {
    //var addTrnscViewMdlObj = addTrnscnViewModel()
    var editTrnscViewMdlObj = editTransactnViewModel()
    
    @IBOutlet weak var acntClctnView:UICollectionView!
    @IBOutlet weak var tagsCln:UICollectionView!
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
    @IBOutlet weak var frmAcntTxt:UITextField!
    @IBOutlet weak var frmAcntBtn:UIButton!
    @IBOutlet weak var toAcntTxt:UITextField!
    @IBOutlet weak var toAcntBtn:UIButton!
    @IBOutlet weak var toAcntArwImg:UIImageView!
    @IBOutlet var frmAcntLbl : UILabel!
    @IBOutlet var toAcntLbl : UILabel!
    @IBOutlet weak var notesToAmntCnstrt:NSLayoutConstraint!
    @IBOutlet weak var ctgryVieBtmCnstrt: NSLayoutConstraint!
    @IBOutlet weak var incExpCnstr:NSLayoutConstraint!
    @IBOutlet weak var trnsfrCnstr:NSLayoutConstraint!
    @IBOutlet var topTitle : UILabel!
    @IBOutlet weak var ctgryLbl:UILabel!
    @IBOutlet weak var ctgryIcnBgLbl:UILabel!
    @IBOutlet weak var ctgrySlcIcn:UIImageView!
    @IBOutlet weak var ctgryArrw:UIImageView!
    @IBOutlet weak var ctgryBtn:UIButton!
    @IBOutlet weak var ctgryLineLbl:UILabel!
    @IBOutlet weak var ctgryBgBlckLbl:UILabel!
    //Acnt Add Fields
    @IBOutlet weak var acntNmeTxt:UITextField!
    @IBOutlet weak var intlAmntTxt:UITextField!
    
    @IBOutlet weak var crncyTbl:UITableView!
    @IBOutlet var crncyTblView : UIView!
    var datePicker : UIDatePicker!
    @IBOutlet var slctTblTitle : UILabel!
    @IBOutlet var addCrncyAcntView : UIView!
    @IBOutlet var addIncExpView,CategoryGridView : UIView!
    
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
    var slctdTagIcnId = ""
    var slctdTagIcnUrl = ""
    var slctdTagIcnClr = ""
    var slctdTagNme = ""
    var scltdIcnClr = ""
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
    var slctdItems:[String] = []
    var slctdItemsId:[String] = []
    var tagsListView: TagsListProtocol = TagsList()
    var dataSource: DefaultTagsListDataSource!
    let scroll = UIScrollView()
    let color = UIColor.purple
    var hgt = 0.0
    var randomStrings: [String] = [
        "Bakery", "Movies", "Mobile Bills", "Medicine", "Recharge", "Repair","House","Apparels", "School fees", "Electricity", "Loan emi", "Books", "Cosmetics","Charity","Fuel", "Insurance", "Servants", "e shopping"]
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
        self.crncyTblView.isHidden = false
    }
    func loadAcntCln() {
        self.stopAnimating()
        
//            self.tagsCln.isHidden = false
//            self.noTags.isHidden = true
            self.acntClctnView.reloadData()
       
    }
    func fills()
    {
        self.fillValues()
    }
    func closeSetAcntView() {
        self.stopAnimating()
        //self.setControlsforAdding()

        //self.addCrncyAcntView.isHidden = true
        self.addIncExpView.isHidden = false
        
        //self.addIncExpView.isHidden = false
        //self.addbutton.isHidden = false
        Toast(text: "Account added !", duration: Delay.long)
        
        //self.back()
    }
    func BackAfterDataAdd() {
        self.stopAnimating()
        //Toast(text: "Added !", duration: Delay.long)
//        if(DashboardViewModel.trnscTyp == "1")
//        {
//            Toast(text: "Income Added !").show()
//        }
//        else if(DashboardViewModel.trnscTyp == "2")
//        {
//            Toast(text: "Expense Added !").show()
//        }
//        else
//        {
//            Toast(text: "Transfer Added !").show()
//        }
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
        print("sss")
        if(UserDefaults.standard.value(forKey: "accountExist") as! String == "0")
        {
        }
        else
        {
            slctdItems = editTransactnViewModel.tagsNameArry.compactMap({ String($0) })
            slctdItemsId = editTransactnViewModel.tagsIdArry.compactMap({ String($0) })
            //self.setTagsListData()
           // self.tagsListView.reloadCollectionData()
        }
    }
    func acntsTblSelect(acnt: String, acntId: String) {
        
        //self.acntTxt.text = acnt
        self.acntIdVal = acntId
        self.crncyTblView.isHidden = true
        self.slctTblTitle.text = "Select Account"
        if(DashboardViewModel.trnscTyp == "1" || DashboardViewModel.trnscTyp == "2")
        {
            if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.acntIdVal != "")
            {
                self.tickImg.image = UIImage(named: "tick")
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
                self.tickBtn.isHidden = true
            }
        }
        else
        {
            if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.frmAcntTxt.text! != "" && self.toAcntTxt.text! != "")
            {
                self.tickImg.image = UIImage(named: "tick")
                //self.tickImg.setImageColor(color: ColorManager.transferColor())
                self.enableTickBtn()
            }
            else
            {
                self.tickImg.image = UIImage(named: "tickGrey")
                self.tickBtn.isHidden = true
            }
        }
        self.amountTxt.becomeFirstResponder()
    }
    func trnsfrAcntSelect(acnt:String,acntId:String,typ:String)
    {
        if(typ == "from")
        {
            self.frmAcntTxt.text = acnt
            self.frmAcntTxt.backgroundColor = UIColor(red: 238/255, green: 232/255, blue: 255/255, alpha: 1.0)
            self.frmAcntTxt.borderColor = ColorManager.incomeColor()
            self.frmAcntTxt.textColor = ColorManager.incomeColor()
            self.frmAcntTxt.cornerRadius = self.frmAcntTxt.frame.height/2
            
            self.frmAcntIdVal = acntId
            self.crncyTblView.isHidden = true
            self.acntClctnView.isHidden = true
            //self.slctTblTitle.text = "Select Account"
        }
        else if(typ == "to")
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
        if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.frmAcntTxt.text! != "" && self.toAcntTxt.text! != "")
        {
            self.tickImg.image = UIImage(named: "tick")
            //self.tickImg.setImageColor(color: ColorManager.transferColor())
            self.enableTickBtn()
        }
        else
        {
            self.tickImg.image = UIImage(named: "tickGrey")
            self.tickBtn.isHidden = true
        }
    }
    func crncyTblSelect(crncy: String, crncyId: String,crncycode:String) {
        //textView.attributedText = htmlText.htmlToAttributedString
        
        //self.crncyTxt.text = "\(crncy)"
        self.crncyIdTxt.text = crncyId
        self.crncyCodeTxt.text = crncycode
        self.crncyTblView.isHidden = true
        
    }
    @IBAction func clkSubmit()
    {
        if(DashboardViewModel.trnscTyp == "1" || DashboardViewModel.trnscTyp == "2")
        {
            self.editTrnscn()
        }
        else
        {
            self.editTransfer()
        }
    }
    @IBAction func editTrnscn()
    {
        self.startAnimating()
        var amount = self.amountTxt.text!
        var nte = self.noteTxt.text!
        self.view.endEditing(true)
        DispatchQueue.global().async {
            if(DashboardViewModel.trnscTyp == "1" || DashboardViewModel.trnscTyp == "2")
            {
                
              
                
                //For keyboard populated tags
                let arrWithoutDuplicates = self.SlctdTagId.reduce([]) {     (a: [String], b: String) -> [String] in     if a.contains(b) {         return a     } else {         return a + [b]     } } //print(arrWithoutDuplicates)
                
                let arrWithoutDuplicates1 = self.SlctdTagname.reduce([]) {     (a: [String], b: String) -> [String] in     if a.contains(b) {         return a     } else {         return a + [b]     } } //print(arrWithoutDuplicates)
                
                self.editTrnscViewMdlObj.editInc(amnt:amount  , descr: nte, acnt: self.acntIdVal, date: self.dateVal, tag: self.SlctdTagId.joined(separator: ", "),type:DashboardViewModel.trnscTyp, usertags:"")
            }
            
        }
        
    }
    @IBAction func editTransfer()
    {
        if(self.frmAcntIdVal == self.toAcntIdVal)
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
                self.editTrnscViewMdlObj.editTrnsfr(amnt:amount  , descr: nte,frmAcnt: self.frmAcntIdVal,toAcnt: self.toAcntIdVal, date: self.dateVal, tag: self.SlctdTagId.joined(separator: ", "),type:DashboardViewModel.trnscTyp, usertags:"")
            }
            
        }
        
    }
//    @IBAction func crncyAcntSubmit()
//    {
//        self.startAnimating()
//        var acntNme = self.acntNmeTxt.text!
//        var intlAmnt = self.intlAmntTxt.text!
//        var crncyId = self.crncyIdTxt.text!
//        var crncyCode = self.crncyCodeTxt.text!
//        //var crncyName = self.crncyTxt.text!
//        self.view.endEditing(true)
//        DispatchQueue.global().async {
//        self.editTrnscViewMdlObj.addAcnt(acntNme: acntNme,acntIntAmnt:intlAmnt, crncyId: crncyId,crncy:crncyName,crncyCode:crncyCode)
//        }
//
//
//
//    }
    @objc func keyboardWillAppear() {
        self.scroll.isHidden = false
        //Do something here
    }
//    @IBAction func closeAcntVIew()
//    {
//        self.crncyTblView.isHidden = true
//    }
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
            if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.acntIdVal != "")
           {
                self.tickImg.image = UIImage(named: "tick")
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
                self.tickBtn.isHidden = true
            }
            
            }
             // Add code later...
        }
        
        @objc func keyboardWillHide(_ notification: NSNotification) {
            //scroll.isHidden = true
            if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.acntIdVal != "")
           {
                self.tickImg.image = UIImage(named: "tick")
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
                self.tickBtn.isHidden = true
            }
            self.setView(view: scroll, hidden: true)
             // Add code later...
        }
    override func viewDidLoad() {
        self.acntClctnView.tag = 1
        self.tagsCln.tag = 2
        self.ctgryVieBtmCnstrt.constant = -565
        gradient.frame = self.addIncExpView.bounds
        self.addIncExpView.layer.insertSublayer(gradient, at: 0)
        self.frmAcntTxt.backgroundColor = UIColor(red: 238/255, green: 232/255, blue: 255/255, alpha: 1.0)
        self.frmAcntTxt.borderColor = ColorManager.incomeColor()
        self.frmAcntTxt.textColor = ColorManager.incomeColor()
        self.frmAcntTxt.cornerRadius = self.frmAcntTxt.frame.height/2
        self.toAcntTxt.backgroundColor = UIColor(red: 238/255, green: 232/255, blue: 255/255, alpha: 1.0)
        self.toAcntTxt.borderColor = ColorManager.incomeColor()
        self.toAcntTxt.textColor = ColorManager.incomeColor()
        self.toAcntTxt.cornerRadius = self.frmAcntTxt.frame.height/2
        //self.editTrnscViewMdlObj.addTrnscnViewDlgt = self
       
        self.editTrnscViewMdlObj.editTrnscnViewDlgt = self
        self.acntClctnView.dataSource = editTrnscViewMdlObj
        self.acntClctnView.delegate = editTrnscViewMdlObj
        self.acntClctnView.allowsMultipleSelection = false
        
        self.tagsCln.dataSource = editTrnscViewMdlObj
        self.tagsCln.delegate = editTrnscViewMdlObj
        self.ctgryBgBlckLbl.isHidden = true
        if(DashboardViewModel.trnscTyp == "1") || (DashboardViewModel.trnscTyp == "2")
        {
            //setupTagsList()
        }
            //self.addTrnscViewMdlObj.getDefltTags()
        DispatchQueue.global().async {
            self.editTrnscViewMdlObj.getTags()
        }
        if(DashboardViewModel.trnscTyp == "1") || (DashboardViewModel.trnscTyp == "2")
        {
            self.ctgryLbl.isHidden = false
            self.ctgrySlcIcn.isHidden = false
            self.ctgryIcnBgLbl.isHidden = false
            self.ctgryArrw.isHidden = false
            //self.ctgryBtn.isHidden = false
            self.ctgryLineLbl.isHidden = false
            self.trnsfrCnstr.constant = 132
            self.notesToAmntCnstrt.constant = 92
        }
        else
        {
            self.ctgryLbl.isHidden = true
            self.ctgryIcnBgLbl.isHidden = true
            self.ctgrySlcIcn.isHidden = true
            self.ctgryArrw.isHidden = true
            //self.ctgryBtn.isHidden = true
            self.ctgryLineLbl.isHidden = true
            self.trnsfrCnstr.constant = 34
            self.notesToAmntCnstrt.constant = 25
            
        }
        
        let todaysDate = Date()
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateStyle = .medium
        dateFormatter2.timeStyle = .none
        dateFormatter2.dateFormat = "EE, MMM d, yyyy"
        self.dateTxt.text = dateFormatter2.string(from: todaysDate)
        dateFormatter2.dateFormat = "yyyy-MM-dd hh:mm:ss"
        self.dateVal = dateFormatter2.string(from: todaysDate)
        
        
        self.tickBtn.isHidden = true
        self.tickImg.image = UIImage(named: "tickGrey")
       // self.crncyTblView.isHidden = true
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
        if(DashboardViewModel.trnscTyp == "1")
        {
            self.topTitle.text = "Edit Income"
            self.amountTxt.textColor = ColorManager.incomeColor()
        }
        else if(DashboardViewModel.trnscTyp == "2")
        {
            self.topTitle.text = "Edit Expense"
            self.amountTxt.textColor = ColorManager.expenseColor()
        }
        else
        {
            self.topTitle.text = "Edit Transfer"
            self.amountTxt.textColor = ColorManager.transferColor()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//            self.setTagsListData()
//            self.tagsListView.reloadCollectionData()
        })
        
        
            //self.addCrncyAcntView.isHidden = true
            self.addIncExpView.isHidden = false
            self.amountTxt.becomeFirstResponder()
            if(DashboardViewModel.trnscTyp == "1" || DashboardViewModel.trnscTyp == "2")
            {
                //self.acntTxt.isHidden = false
                self.frmAcntTxt.isHidden = true
                self.toAcntTxt.isHidden = true
                //self.toAcntArwImg.isHidden = true
                self.toAcntBtn.isHidden = true
                self.frmAcntBtn.isHidden = true
               // self.acntBtn.isHidden = false
                self.frmAcntLbl.isHidden = true
                self.toAcntLbl.isHidden = true
                //self.incExpCnstr.constant = 0
                self.trnsfrCnstr.constant = 20
            }
            else
            {
                //self.acntTxt.isHidden = true
                self.frmAcntTxt.isHidden = false
                self.toAcntTxt.isHidden = false
                //self.toAcntArwImg.isHidden = false
                self.toAcntBtn.isHidden = false
                self.frmAcntBtn.isHidden = false
                //self.acntBtn.isHidden = true
                self.acntClctnView.isHidden = true
                self.frmAcntLbl.isHidden = false
                self.toAcntLbl.isHidden = false
                //self.incExpCnstr.constant = 34
                self.trnsfrCnstr.constant = 132
            }
        
        super.viewDidLoad()
        
        //self.amntBackBtn.isHidden = true
        
        self.amountTxt.addTarget(self, action: #selector(yourHandler(textField:)), for: .editingChanged)
        self.noteTxt.addTarget(self, action: #selector(yourHandler(textField:)), for: .editingChanged)
        self.noteTxt.leftViewMode = UITextField.ViewMode.always
        
//        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
//        let mailView = UIImageView(frame: CGRect(x: 4, y: 0, width: 18, height: 18))
//        mailView.image = UIImage(named: "notes")
//        mailView.contentMode = .scaleAspectFit
//        iconContainer.addSubview(mailView)
//        self.noteTxt.leftViewMode = .always
//        self.noteTxt.leftView = iconContainer
        
//        let iconContainer1 = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
//        let mailView1 = UIImageView(frame: CGRect(x: 4, y: 0, width: 18, height: 18))
//        mailView1.image = UIImage(named: "ddlArrow")
//        mailView1.contentMode = .scaleAspectFit
//        iconContainer1.addSubview(mailView1)
//        self.acntTxt.rightViewMode = .always
//        self.acntTxt.rightView = iconContainer1
        
//        let iconContainer2 = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
//        let mailView2 = UIImageView(frame: CGRect(x: -10, y: 0, width: 18, height: 18))
//        mailView2.image = UIImage(named: "ddlArrow")
//        mailView2.contentMode = .scaleAspectFit
//        iconContainer2.addSubview(mailView2)
        //self.crncyTxt.rightViewMode = .always
        //self.crncyTxt.rightView = iconContainer2
//        self.frmAcntTxt.rightViewMode = .always
//        self.frmAcntTxt.rightView = iconContainer2
//
//        let iconContainer3 = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
//        let mailView3 = UIImageView(frame: CGRect(x: -10, y: 0, width: 18, height: 18))
//        mailView3.image = UIImage(named: "ddlArrow")
//        mailView3.contentMode = .scaleAspectFit
//        iconContainer3.addSubview(mailView3)
//        self.toAcntTxt.rightViewMode = .always
//        self.toAcntTxt.rightView = iconContainer3
        
        //self.noteTxt.clearButtonMode = .always
        
//        self.acntTxt.leftViewMode = UITextField.ViewMode.always
//        let imageView1 = UIImageView(frame: CGRect(x: 3, y: 0, width: 10, height: 10))
//        let image1 = UIImage(named: "ddlArrow")
//        imageView1.image = image1
//        self.acntTxt.leftView = imageView1
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.startAnimating()
        DispatchQueue.global().async {
            self.editTrnscViewMdlObj.getTransactionValues()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.editTrnscViewMdlObj.getAcnts(typ: "trnscn")
            //self.fillValues()
        })
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//            if(editTransactnViewModel.trans.accountId != nil)
//            {
//                if let indexx = editTransactnViewModel.acntsArry.firstIndex(of: editTransactnViewModel.trans.accountId!) {
//                    self.acntClctnView.scrollToItem(at:IndexPath(item: indexx, section: 0), at: .right, animated: false)
//                }
//            }
//
//        })
        
    }
    func fillValues()
    {
        self.slctdTagIcnId = editTransactnViewModel.tagSlctdId
        self.slctdTagIcnUrl = editTransactnViewModel.tagName
        if let hexClr = editTransactnViewModel.slcdIcnColor.toHex() {
            self.slctdTagIcnClr = hexClr
        }
        self.slctdTagNme = editTransactnViewModel.tagName
        
        
        
        
        self.SlctdTagId = editTransactnViewModel.tagsIdArry
        //self.SlctdTagname = editTransactnViewModel.tagsNameArry
        // Need to check SlctdTagId array indexes present in  incmTagIdArry and fill it to Slctd
        if(DashboardViewModel.trnscTyp == "1")
        {
            self.SlctdTagId.forEach { item in
                if let index = editTransactnViewModel.incmTagIdArry.firstIndex(of: item) {
                    //print("Index of \(targetString) is \(index)")
                    self.Slctd.append(index)
                } else {
                    //print("\(targetString) is not in the list")
                }
            }
        }
        else if(DashboardViewModel.trnscTyp == "2")
        {
            self.SlctdTagId.forEach { item in
                if let index = editTransactnViewModel.expnsTagIdArry.firstIndex(of: item) {
                    //print("Index of \(targetString) is \(index)")
                    self.Slctd.append(index)
                } else {
                    //print("\(targetString) is not in the list")
                }
            }
        }
        
        if(DashboardViewModel.trnscTyp == "1" || DashboardViewModel.trnscTyp == "2")
        {
            self.stopAnimating()
            self.amountTxt.text = editTransactnViewModel.trans.transactionAmount!
            self.noteTxt.text = editTransactnViewModel.trans.transactionText!
            //self.acntTxt.text = editTransactnViewModel.trans.accountName!
            //  *** Need to fill the value in collection view instead ************
            self.acntIdVal = editTransactnViewModel.trans.accountId!
            self.dateTxt.text = editTransactnViewModel.trans.clearedDate!
            self.IncExpTypVal = editTransactnViewModel.trans.transactionType!
            
            
                //print("Index of \(targetString) is \(index)")
            self.ctgryIcnBgLbl.backgroundColor = editTransactnViewModel.slcdIcnColor
            self.ctgryIcnBgLbl.alpha = 0.2
            self.ctgryIcnBgLbl.layer.cornerRadius = self.ctgryIcnBgLbl.frame.width/2
            self.ctgryIcnBgLbl.layer.masksToBounds = true
              //  self.colors = UIColor(hex: editTransactnViewModel.tagsClrArry[0])
            self.ctgryLbl.text = editTransactnViewModel.tagName
            
                //print("Index of \(targetString) is \(index)")
            if let url = URL(string: editTransactnViewModel.icnUrl) {
                let processor = OverlayImageProcessor(overlay: editTransactnViewModel.slcdIcnColor, fraction: 0.1)
                
                // Load the image with Kingfisher and apply the tint
                //                           self.ctgryIcon.kf.setImage(
                //                                       with: url)
                self.ctgrySlcIcn.kf.setImage(with: url, options: [.processor(processor)])
            }
           
            
            
            
            
            
            
            
            
            //self.setTagsListData()
           // tagsListView.reloadCollectionData()
        }
        else
        {
            self.stopAnimating()
            self.amountTxt.text = editTransactnViewModel.trans.transactionAmount!
            self.noteTxt.text = editTransactnViewModel.trans.transactionText!
            self.frmAcntTxt.text = editTransactnViewModel.trans.frmAccountName!
            self.frmAcntIdVal = editTransactnViewModel.trans.frmAccountId!
            self.toAcntTxt.text = editTransactnViewModel.trans.toAccountName!
            self.toAcntIdVal = editTransactnViewModel.trans.toAccountId!
            self.dateTxt.text = editTransactnViewModel.trans.clearedDate!
            self.IncExpTypVal = editTransactnViewModel.trans.transactionType!
        }
        if(DashboardViewModel.trnscTyp == "1" || DashboardViewModel.trnscTyp == "2")
        {
            if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.acntIdVal != "")
            {
                self.tickImg.image = UIImage(named: "tick")
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
                self.tickBtn.isHidden = true
            }
        }
        else
        {
            if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.frmAcntTxt.text! != "" && self.toAcntTxt.text! != "")
            {
                self.tickImg.image = UIImage(named: "tick")
                //self.tickImg.setImageColor(color: ColorManager.transferColor())
                self.enableTickBtn()
            }
            else
            {
                self.tickImg.image = UIImage(named: "tickGrey")
                self.tickBtn.isHidden = true
            }
        }
    }
    func setControlsForTrnscn()
    {
        
    }
    func enableTickBtn()
    {
        self.tickBtn.isHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        
       // setupPlaceForTagsList()
        
    }
    private func setTagsListData() {
        
        
        
        if(DashboardViewModel.trnscTyp == "1")
        {
            items = editTransactnViewModel.incmTagArry.compactMap({ TagViewItem($0) })
            
        }
        else
        {
            items = editTransactnViewModel.expnsTagArry.compactMap({ TagViewItem($0) })
            
            
        }
        //self.Slctd = []
//        for index in 0...items.count-1 {
//
//                var x = self.slctdItems.firstIndex(of:items[index].title!)
//            if(x != nil)
//                {
//                    self.Slctd.append(index)
//                    self.Slctd.unique()
//
//                    self.SlctdTagname.append(self.slctdItems[x!])
//                    self.SlctdTagId.append(self.slctdItemsId[x!])
//                    items[index].backgroundColor = .red
//                    //index has the position of first match
//                }
//            else
//            {
//                items[index].backgroundColor = .lightGray
//            }
//        }
        
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
//
//        for index in 0...items.count-1 {
//            if(self.Slctd.count>0)
//            {
//                if(self.Slctd.contains(index))
//                {
//                    items[index].backgroundColor = .darkGray
//                }
//
//
//            }
////            if index % 2 == 0 {
////                items[index].sideImage = getItemImage(index)
////                items[index].backgroundColor = getItemBackgroundColor(index)
////                items[index].backgroundColor = .purple
////
////            }
//        }
       // items.insert(createCustomMinecraftItem(), at: items.count / 2)
        
//        tagsListView.tagsListDataSource = self
//        tagsListView.tagsListDelegate = self
//        tagsListView.reloadCollectionData()

        
        
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
        if(DashboardViewModel.trnscTyp == "1" || DashboardViewModel.trnscTyp == "2")
        {
            if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.acntIdVal != "")
            {
                self.tickImg.image = UIImage(named: "tick")
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
                self.tickBtn.isHidden = true
            }
        }
        else
        {
            if(self.amountTxt.text! != "" && self.noteTxt.text! != "" && self.dateTxt.text! != "" && self.frmAcntTxt.text! != "" && self.toAcntTxt.text! != "")
            {
                self.tickImg.image = UIImage(named: "tick")
                //self.tickImg.setImageColor(color: ColorManager.transferColor())
                self.enableTickBtn()
            }
            else
            {
                self.tickImg.image = UIImage(named: "tickGrey")
                self.tickBtn.isHidden = true
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
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
//        else if(textField == self.acntTxt)
//        {
//            self.clkAccount()
//        }
    }
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
    @IBAction func clickCategory()
    {
        DispatchQueue.global().async {
            self.editTrnscViewMdlObj.getTags()
        }
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
            //self.tickImg.setImageColor(color: ColorManager.transferColor())
            self.tickBtn.isHidden = true
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
            self.tickBtn.isHidden = true
            self.amntBackBtn.isHidden = true
        }
    }
    @IBAction func clkAccount()
    {
        self.startAnimating()
        self.view.endEditing(true)
        //self.crncyTblView.isHidden = false
        self.editTrnscViewMdlObj.getAcnts(typ: "trnscn")
        self.editTrnscViewMdlObj.editTrnscnViewDlgt = self
        self.crncyTbl.dataSource = editTrnscViewMdlObj
        self.crncyTbl.delegate = editTrnscViewMdlObj
        
    }
    @IBAction func clkFrmAcnt()
    {
        self.view.endEditing(true)
        self.acntClctnView.isHidden = false
        self.clkTrnsfr(typ: "from")
    }
    @IBAction func clkToAcnt()
    {
        self.view.endEditing(true)
        self.acntClctnView.isHidden = false
        self.clkTrnsfr(typ: "to")
    }
    @IBAction func clkTrnsfr(typ:String)
    {
        self.startAnimating()
        self.view.endEditing(true)
        //self.crncyTblView.isHidden = false
        if(typ == "from")
        {
            self.editTrnscViewMdlObj.getAcnts(typ: "from")
        }
        else if(typ == "to")
        {
            self.editTrnscViewMdlObj.getAcnts(typ: "to")
        }
        self.editTrnscViewMdlObj.editTrnscnViewDlgt = self
        self.crncyTbl.dataSource = editTrnscViewMdlObj
        self.crncyTbl.delegate = editTrnscViewMdlObj
        
    }
    @IBAction func clkCrncy()
    {
        self.startAnimating()
        self.view.endEditing(true)
        //self.crncyTblView.isHidden = false
        self.editTrnscViewMdlObj.getCurrency()
        self.editTrnscViewMdlObj.editTrnscnViewDlgt = self
        self.crncyTbl.dataSource = editTrnscViewMdlObj
        self.crncyTbl.delegate = editTrnscViewMdlObj
        
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
extension editTrnscnViewController: TagsListDataSource {
    
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
extension editTrnscnViewController: TagsListDelegate {
    func tagsListCellTouched(_ TagsList: TagsListProtocol, index: Int) {
        if(self.Slctd.contains(index))
        {
            
            if let indexx = self.Slctd.firstIndex(of: index) {
                self.Slctd.remove(at: indexx)
                if(self.IncExpTypVal == "1")
                {
                    if(editTransactnViewModel.incmTagTypeArry[index] == "addedTag")
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
                    if(editTransactnViewModel.expnsTagTypeArry[index] == "addedTag")
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
                if(editTransactnViewModel.incmTagTypeArry[index] == "addedTag")
                {
                    self.SlctdTagId.append(editTransactnViewModel.incmTagIdArry[index])
                }
                else
                {
                    self.SlctdTagname.append(editTransactnViewModel.incmTagArry[index])
                    
                }
            }
            else
            {
                if(editTransactnViewModel.expnsTagTypeArry[index] == "addedTag")
                {
                    self.SlctdTagId.append(editTransactnViewModel.expnsTagIdArry[index])
                }
                else
                {
                    self.SlctdTagname.append(editTransactnViewModel.expnsTagArry[index])
                }
            }
            
        }
        //tagsListView.itemsConfiguration.backgroundColor = .red
        //self.setTagsListData()
        //tagsListView.reloadCollectionData()
        print("\nCell with index: \(index) was touched")
    }

    func tagsListCellXButtonTouched(_ TagsList: TagsListProtocol, index: Int) {
        print("\nxButton from cell with tag index: \(index) was touched")
    }
}
//extension editTrnscnViewController: TagsListDelegate {
//    func tagsListCellTouched(_ TagsList: TagsListProtocol, index: Int) {
//        if(self.Slctd.contains(index))
//        {
//
//            if let indexx = self.Slctd.firstIndex(of: index) {
//                self.Slctd.remove(at: indexx)
//                self.Slctd.unique()
//                if(self.IncExpTypVal == "1")
//                {
//                    if(editTransactnViewModel.incmTagTypeArry[index] == "addedTag")
//                    {
//                        self.SlctdTagId.remove(at: indexx)
//
//                    }
//                    else
//                    {
//                        self.SlctdTagname.remove(at: indexx)
//                    }
//                }
//                else
//                {
//                    if(editTransactnViewModel.expnsTagTypeArry[index] == "addedTag")
//                    {
//                        self.SlctdTagId.remove(at: indexx)
//                    }
//                    else
//                    {
//                        self.SlctdTagname.remove(at: indexx)
//                    }
//                    self.slctdItems.remove(at: indexx)
//                    self.slctdItemsId.remove(at: indexx)
//                }
//            }
//        }
//        else
//        {
//            self.Slctd.append(index)
//            self.Slctd.unique()
//            if(self.IncExpTypVal == "1")
//            {
//                if(editTransactnViewModel.incmTagTypeArry[index] == "addedTag")
//                {
//                    self.SlctdTagId.append(editTransactnViewModel.incmTagIdArry[index])
//                    self.slctdItemsId.append(editTransactnViewModel.incmTagIdArry[index])
//                    self.slctdItems.append(editTransactnViewModel.incmTagArry[index])
//
//                }
//                else
//                {
//                    self.SlctdTagname.append(editTransactnViewModel.incmTagArry[index])
//                    self.slctdItems.append(editTransactnViewModel.incmTagArry[index])
//                    self.slctdItemsId.append(editTransactnViewModel.incmTagIdArry[index])
//
//                }
//            }
//            else
//            {
//                if(editTransactnViewModel.expnsTagTypeArry[index] == "addedTag")
//                {
//                    self.SlctdTagId.append(editTransactnViewModel.expnsTagIdArry[index])
//                    self.slctdItemsId.append(editTransactnViewModel.expnsTagIdArry[index])
//                    self.slctdItems.append(editTransactnViewModel.expnsTagArry[index])
//                }
//                else
//                {
//                    self.SlctdTagname.append(editTransactnViewModel.expnsTagArry[index])
//                    self.slctdItemsId.append(editTransactnViewModel.expnsTagIdArry[index])
//                    self.slctdItems.append(editTransactnViewModel.expnsTagArry[index])
//                }
//            }
//
//        }
//        //tagsListView.itemsConfiguration.backgroundColor = .red
//        self.setTagsListData()
//        tagsListView.reloadCollectionData()
//        print("\nCell with index: \(index) was touched")
//    }
//
//    func tagsListCellXButtonTouched(_ TagsList: TagsListProtocol, index: Int) {
//        print("\nxButton from cell with tag index: \(index) was touched")
//    }
//}
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
