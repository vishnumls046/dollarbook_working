//
//  AcntManageViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 30/11/22.
//

import UIKit
import NVActivityIndicatorView

protocol acntMngeProt
{
    func updtAcntTbl(count:Int)
    func valdteAcnt(alrtStr:String)
    func closeAcntView()
    func editAcnt(acntNme:String,intlAmnt:String,acntId:String,acntType:String)
    func slctTbl()
    func deleteAlert(acntId:String)
}
class AcntManageViewController: UIViewController,acntMngeProt,NVActivityIndicatorViewable,UIGestureRecognizerDelegate,UITextFieldDelegate {
    static var slctdAcntId = ""
    @IBOutlet weak var acntTypView:UIView!
    @IBOutlet weak var addAcntView:UIView!
    @IBOutlet weak var addBtn:UIButton!
    @IBOutlet weak var AddAcntBtn:UIButton!
    @IBOutlet weak var EditAcntBtn:UIButton!
    @IBOutlet weak var acntTbl:UITableView!
    @IBOutlet weak var acntNmeTxt:UITextField!
    @IBOutlet weak var intlAmntTxt:UITextField!
    @IBOutlet weak var acntIdTxt:UITextField!
    @IBOutlet weak var addEditLbl:UILabel!
    @IBOutlet weak var noAcnts:UILabel!
    @IBOutlet weak var creditChkBxImg,filterImg:UIImageView!
    @IBOutlet weak var creditChkBxBtn,filterBtn:UIButton!
    @IBOutlet weak var acntTypBgLabel:UILabel!
    @IBOutlet weak var addAcntBgLabel:UILabel!
    @IBOutlet weak var credCrdPromtLbl:UILabel!
    @IBOutlet weak var credCrdCnstrnt:NSLayoutConstraint!
    var acntTypeVal = ""
    var creditChkVal = false
    var acntArry:[Accounts] = []
    var acntMngVwObj = mngeAcntsViewModel()
    func editAcnt(acntNme:String,intlAmnt:String,acntId:String,acntType:String)
    {
        self.addBtn.setBackgroundImage(UIImage(named: "minus"), for: .normal)
        self.addEditLbl.text = "Edit Account"
        self.addAcntView.isHidden = false
        self.acntNmeTxt.text = acntNme
        self.intlAmntTxt.text = intlAmnt
        self.acntIdTxt.text = acntId
        self.AddAcntBtn.isHidden = true
        self.EditAcntBtn.isHidden = false
        self.acntTypeVal = acntType
        if(self.acntTypeVal == "3")
        {
            self.creditChkVal = true
            self.creditChkBxImg.image = UIImage(named: "chkBx_checked")
        }
        else
        {
            self.creditChkVal = false
            self.creditChkBxImg.image = UIImage(named: "chkBx_unchecked")
        }
        
        //self.submitBtn.tag = Int(acntId)!
        self.EditAcntBtn.addTarget(self, action: #selector(editSbmt), for: .touchUpInside)
    }
    func deleteAlert(acntId:String)
    {
        var refreshAlert = UIAlertController(title: "DollarBook", message: "Do you want to delete transaction ?", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.startAnimating()
            DispatchQueue.global().async {
                self.acntMngVwObj.Dlt(delAcntId:acntId)
            }
            
          }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
          print("Handle Cancel Logic here")
          }))

        self.present(refreshAlert, animated: true, completion: nil)
    }
    func slctTbl()
    {
        self.performSegue(withIdentifier: "bnkrprt", sender: self)
    }
    @IBAction func editSbmt(sender: UIButton)
    {
        if(self.creditChkVal == true)
        {
            self.acntMngVwObj.validateEditAcnt(acnt: self.acntNmeTxt.text!,intlAmnt:self.intlAmntTxt.text!,acntId:self.acntIdTxt.text!,acntType:"3")
        }
        else
        {
            self.acntMngVwObj.validateEditAcnt(acnt: self.acntNmeTxt.text!,intlAmnt:self.intlAmntTxt.text!,acntId:self.acntIdTxt.text!,acntType:"1")
        }
    }
    func closeAcntView()
    {
        self.view.endEditing(true)
        self.acntMngVwObj.getAcnts(acntType: "")
        self.addBtn.setBackgroundImage(UIImage(named: "plus"), for: .normal)
        self.addAcntView.isHidden = true
    }
    @IBAction func chkCreditBox()
    {
        if(self.creditChkVal == false)
        {
            self.creditChkVal = true
            self.creditChkBxImg.image = UIImage(named: "chkBx_checked")
            self.credCrdCnstrnt.constant = 92
            self.credCrdPromtLbl.isHidden = false
            
        }
        else
        {
            self.creditChkVal = false
            self.creditChkBxImg.image = UIImage(named: "chkBx_unchecked")
            self.credCrdCnstrnt.constant = 32
            self.credCrdPromtLbl.isHidden = true
            
        }
    }
    func valdteAcnt(alrtStr:String) {
        let alert = UIAlertController(title: "Dollar Book", message: alrtStr, preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    func updtAcntTbl(count:Int)
    {
        self.stopAnimating()
        if(count > 0)
        {
            self.acntTbl.isHidden = false
            self.noAcnts.isHidden = true
//            self.filterBtn.isHidden = false
//            self.filterImg.isHidden = false
            self.acntTbl.reloadData()
            self.closeAcntTypView()
        }
        else
        {
            self.acntTbl.isHidden = true
            self.noAcnts.isHidden = false
//            self.filterBtn.isHidden = true
//            self.filterImg.isHidden = true
            self.closeAcntTypView()
        }
    }
    @IBAction func filterAcntTyp()
    {
        self.acntTypView.isHidden = false
    }
    func closeAcntTypView()
    {
       
            self.acntTypView.isHidden = true
            self.addAcntView.isHidden = true
       
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil)
    {
        self.closeAcntTypView()
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view!.isDescendant(of: self.acntTypBgLabel) == true || touch.view!.isDescendant(of: self.acntTbl) == true || touch.view!.isDescendant(of: self.addAcntBgLabel) == true {
            
            return false
         }
        else
        {
            return true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.credCrdCnstrnt.constant = 32
        self.credCrdPromtLbl.isHidden = true
        self.acntTypView.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
        self.noAcnts.isHidden = true
        self.addAcntView.isHidden = true
        self.addBtn.setBackgroundImage(UIImage(named: "plus"), for: .normal)
        
        
        self.acntMngVwObj.acntMngDlgt = self
        self.acntTbl.delegate = acntMngVwObj
        self.acntTbl.dataSource = acntMngVwObj
        
        self.acntTbl.reloadData()
        print(self.acntArry)
        //settngsVwMdlObj.settngsDlgt = self
        //self.crncyTbl.dataSource = settngsViewMdl
        //self.crncyTbl.delegate = settngsViewMdl
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.startAnimating()
        
        DispatchQueue.global().async {
            self.acntMngVwObj.getAcnts(acntType:"")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    @IBAction func clkAcntTypBtn(btn:UIButton)
    {
        self.startAnimating()
        if(btn.tag == 0)
        {
            self.acntMngVwObj.getAcnts(acntType:"")
        }
        else if(btn.tag == 1)
        {
            self.acntMngVwObj.getAcnts(acntType:"1")
        }
        else if(btn.tag == 2)
        {
            self.acntMngVwObj.getAcnts(acntType:"2")
        }
        else if(btn.tag == 3)
        {
            self.acntMngVwObj.getAcnts(acntType:"3")
        }
        
        
    }
    @IBAction func clkAddBtn()
    {
        self.view.endEditing(true)
        self.addEditLbl.text = "Add Account"
        self.acntNmeTxt.text = ""
        self.intlAmntTxt.text = ""
        self.AddAcntBtn.isHidden = false
        self.EditAcntBtn.isHidden = true
        if(self.addAcntView.isHidden == true)
        {
            self.addBtn.setBackgroundImage(UIImage(named: "minus"), for: .normal)
            self.addAcntView.isHidden = false
            
        }
        else
        {
            self.addBtn.setBackgroundImage(UIImage(named: "plus"), for: .normal)
            self.addAcntView.isHidden = true
        }
    }
    @IBAction func addAcntSubmit()
    {
        if(self.creditChkVal == true)
        {
            self.acntMngVwObj.validateAcnt(acnt: self.acntNmeTxt.text!,intlAmnt:self.intlAmntTxt.text!,acntType:"3")
        }
        else
        {
            self.acntMngVwObj.validateAcnt(acnt: self.acntNmeTxt.text!,intlAmnt:self.intlAmntTxt.text!,acntType:"1")
        }
        
        
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
extension AcntManageViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.acntArry.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listRecent", for: indexPath) as! recentTblViewCell
        cell.title.text = "\(self.acntArry[indexPath.row].account_name)"
        var tagname = self.acntArry[indexPath.row].account_name!.prefix(1)
        cell.shortNme.text = "\(tagname.uppercased())"
        let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
        let crcyCode = crncy.htmlToString
        cell.time.text = "\(crcyCode) \(self.acntArry[indexPath.row])"
        
        var theme = UserDefaults.standard.value(forKey: "theme")!
        if(theme as! String == "income")
        {
            cell.title.textColor =  UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
        }
        else
        {
            cell.title.textColor =   UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
        // self.settngsDlgt?.acntsTblSelect(acnt: self.crncyArry[indexPath.row], acntId: self.crncyIdArry[indexPath.row])
        
        
        
    }
}
