//
//  updateProfileViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 16/12/22.
//

import UIKit
import TransitionButton
import NVActivityIndicatorView
import Toaster
protocol profileProt
{
    func updtCrncy(TblTyp:String)
    func crncyTblSelect(crncy:String,crncyId:String,crncycode:String)
    func regAlert(title:String,AlrtStr:String)
    func updtRedirect()
    func fillValues(val:[User])
    func keybrdHide()
    func userNotExist()
    func userExist()
}
class updateProfileViewController: UIViewController,profileProt,NVActivityIndicatorViewable,UISearchBarDelegate, UIScrollViewDelegate {
    @IBOutlet weak var crncyTbl:UITableView!
    @IBOutlet weak var crncyView:UICollectionView!
    @IBOutlet weak var crcnyDdlBgCurv:UILabel!
    @IBOutlet var crncyTblView : UIView!
    @IBOutlet var slctTblTitle : UILabel!
    @IBOutlet weak var nameTxt:UITextField!
    @IBOutlet weak var emailTxt:UITextField!
    //@IBOutlet weak var pwdTxt:UITextField!
    //@IBOutlet weak var cnfrmPwd:UITextField!
    @IBOutlet weak var crncyTxt:UITextField!
    @IBOutlet weak var srchBar:UISearchBar!
    @IBOutlet weak var updateButton: TransitionButton!
    var crncyVal = ""
    let updtprofVwmdl = updateProfileViewModel()
    
    var splashMdl = SplashViewModel()
    func userNotExist()
    {
        self.performSegue(withIdentifier: "userProflogout", sender: self)
    }
    func userExist()
    {
        self.updtprofVwmdl.getUserProfile()
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.crncyTblView.isHidden = true
        self.updtprofVwmdl.profileDlgt = self
        self.splashMdl.updtProfProt = self
        
//        self.nameTxt.text = UserDefaults.standard.value(forKey: "full_name")! as! String
//        self.emailTxt.text = UserDefaults.standard.value(forKey: "email_id")! as! String
        //self.crncyTxt.text = UserDefaults.standard.value(forKey: "crncyName")! as! String
        //self.crncyVal = UserDefaults.standard.value(forKey: "crncyId")! as! String
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.startAnimating()
        
        DispatchQueue.global().async {
            self.splashMdl.userCheck(from: "updateProfile")
            
        }
    }
    func keybrdHide()
    {
        self.view.endEditing(true)
    }
    func fillValues(val:[User])
    {
        self.nameTxt.text = val[0].fullName!
        self.emailTxt.text = val[0].emailId!
        self.crncyTxt.text = val[0].currencyName!
        self.crncyVal = val[0].currencyId!
        //UserDefaults.standard.set(val[0].currencyCode, forKey: "crncyCode")
        self.stopAnimating()
    }
    func updtRedirect()
    {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
//            self.back()
//            
//        })
        Toast(text: "Profile Updated !",delay: 0.0).show()
        ToastView.appearance().backgroundColor = ColorManager.expenseColor()
        ToastView.appearance().textColor = .white
        self.back()
        //self.regAlert(title: "Dollarbook", AlrtStr: "Profile updated")
        
    }
    func regAlert(title:String,AlrtStr:String) {
//        self.bgScroll.setContentOffset(CGPointMake(0, max(self.bgScroll.contentSize.height - self.bgScroll.bounds.size.height+50, 0) ), animated: true)
        let alert = UIAlertController(title: title, message: AlrtStr, preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                    self.back()
                    }))

                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    @IBAction func back()
    {
        self.dismiss(animated: false, completion: nil)
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
    func crncyTblSelect(crncy: String, crncyId: String,crncycode:String) {
        //textView.attributedText = htmlText.htmlToAttributedString
        self.view.endEditing(true)
        self.crncyVal = crncyId
        self.crncyTxt.text = crncy
        //self.crcnyDdlBgCurv.text = (crncycode.htmlToString)
        self.crncyTblView.isHidden = true
        
    }
    @IBAction func clkCrncy()
    {
        self.srchBar.text = ""
        //self.settngsViewMdl.getCurrency()
        self.crncyTblView.isHidden = false
        self.startAnimating()
        DispatchQueue.global().async {
            self.updtprofVwmdl.getCurrency(key: "")
        }
        
        self.updtprofVwmdl.profileDlgt = self
        self.crncyTbl.dataSource = updtprofVwmdl
        self.crncyTbl.delegate = updtprofVwmdl
    }
    @IBAction func closeCrncy()
    {
        self.crncyTblView.isHidden = true
    }
   
    
    @IBAction func buttonAction(_ button: TransitionButton) {
        self.updateButton.startAnimation() // 2: Then start the animation when the user tap the button
            let qualityOfServiceClass = DispatchQoS.QoSClass.background
            let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
            backgroundQueue.async(execute: {
                
                sleep(3) // 3: Do your networking task or background work here.
                
                DispatchQueue.main.async(execute: { () -> Void in
                    self.updtprofVwmdl.validateUpdate(email: self.emailTxt.text!, name: self.nameTxt.text!, crncyId: self.crncyVal)
                    
                    // 4: Stop the animation, here you have three options for the `animationStyle` property:
                    // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                    // .shake: when you want to reflect to the user that the task did not complete successfly
                    // .normal
                    self.updateButton.stopAnimation(animationStyle: .shake, completion: {
                        self.updateButton.layer.cornerRadius = self.updateButton.frame.height/2
                        self.updateButton.layer.masksToBounds = true
                        //let secondVC = UIViewController()
                        //self.present(secondVC, animated: true, completion: nil)
                    })
                })
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
extension updateProfileViewController {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)        {
        print(searchText)
        self.updtprofVwmdl.getCurrency(key:searchText)
      //code
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("search cancel clicked")
        
     //code
    }
}
