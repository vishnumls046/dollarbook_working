//
//  splashloadViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 26/08/22.
//

import UIKit
import Foundation
import NVActivityIndicatorView
protocol settngsProt
{
    func logoutRedrct()
    func updtCrncy(TblTyp:String)
    func crncyTblSelect(crncy:String,crncyId:String,crncycode:String)
    func acntsTblSelect(acnt:String,acntId:String)
    func userNotExist()
    
}
class settingsViewController: UIViewController,NVActivityIndicatorViewable,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,settngsProt {
    func logoutRedrct() {
        self.performSegue(withIdentifier: "logout", sender: self)
    }
    func userNotExist()
    {
        self.logoutRedrct()
    }
    
    @IBOutlet weak var crcnyCode:UILabel!
    @IBOutlet weak var crncyTxt:UITextField!
    @IBOutlet weak var acntFillTxt:UITextField!
    @IBOutlet var crncyTblView : UIView!
    var acntIdVal = ""
    @IBOutlet weak var crncyTbl:UITableView!
    @IBOutlet var slctTblTitle : UILabel!
    @IBOutlet weak var prpLbl:UILabel!
    @IBOutlet weak var load:NVActivityIndicatorView!
    @IBOutlet weak var logo:UIImageView!
    @IBOutlet weak var arrow:UIImageView!
    @IBOutlet weak var crncyView:UICollectionView!
    @IBOutlet weak var tagView:UICollectionView!
    @IBOutlet weak var crvView:UIView!
    @IBOutlet weak var crvView1:UIView!
    @IBOutlet weak var tagCntr:UIView!
    @IBOutlet weak var crcnyDdlBgCurv:UILabel!
    @IBOutlet weak var tutView:UIView!
    @IBOutlet weak var tutScroll:UIScrollView!
    @IBOutlet weak var skip:UIButton!
    @IBOutlet weak var pageControl:UIPageControl!
    var crncyArry = NSMutableArray(array: ["€", "₹", "$","£","﷼","₽","¥"])
    var crncyNmeArry = NSMutableArray(array: ["Euro", "INR", "USD","GBP","SAR","RUB","JPY"])
    var tagNameArry = NSMutableArray(array: ["Cafe", "Grocery", "Taxi","Loan","Fees", "Taxi","Loan","Cosmetics","Bills","Medicines","Bakery","Fuel"])
    var settngsViewMdl = settingsViewModel()
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    var splashMdl = SplashViewModel()
    override func viewDidLoad() {
        self.splashMdl.settingsProt = self
        self.splashMdl.userCheck(from: "settings")
        self.configurePageControl()
        super.viewDidLoad()
        self.tutView.isHidden = true
        self.crncyTblView.isHidden = true
        self.tagCntr.isHidden = true
        self.settngsViewMdl.settngsDlgt = self
//        if (UserDefaults.standard.value(forKey: "crncyName") == nil)
//        {
//
//        }
//        else {
//            self.crncyTxt.text = UserDefaults.standard.value(forKey: "crncyName") as! String
//
//        }
//        if (UserDefaults.standard.value(forKey: "crncyCode") == nil)
//        {
//            print("nil")
//        }
//        else {
//            let crncyCode = UserDefaults.standard.value(forKey: "crncyCode")  as! String
//            self.crcnyDdlBgCurv.text = crncyCode.htmlToString
//
//
//        }
        
        
        
        // Do any additional setup after loading the view.
    }
    func configurePageControl() {
         self.pageControl.numberOfPages = 5
         self.pageControl.currentPage = 0
         self.pageControl.tintColor = ColorManager.incomeColor()
         self.pageControl.pageIndicatorTintColor = ColorManager.incomeColor()
         self.pageControl.currentPageIndicatorTintColor = ColorManager.expenseColor()
         //self.view.addSubview(pageControl)
     }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

            let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControl.currentPage = Int(pageNumber)
        if(pageNumber == 4.0)
            {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.skipTut()
            })
            }
        }

    override func viewWillAppear(_ animated: Bool) {
        
//        self.logo.alpha = 0
//        //self.prpLbl.alpha = 0
//        self.logo.fadeIn()
//        Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.alarmAlertActivate), userInfo: nil, repeats: true)
        
        //self.prpLbl.fadeIn()
    }
    @IBAction func showTut()
    {
        self.pageControl.currentPage = 0
        for i in stride(from: 0, to: 5, by: 1) {
            var imgview:UIImageView  = UIImageView()
            imgview.frame = CGRectMake(CGFloat(i)*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)
            imgview.image = UIImage(named: "tut\(i).png")
            //imgview.contentMode = .scaleAspectFill
            self.tutScroll.addSubview(imgview)
            let contentRect: CGRect = self.tutScroll.subviews.reduce(into: .zero) { rect, view in
                rect = rect.union(imgview.frame)
            }
            self.tutScroll.contentSize = contentRect.size
            self.tutView.isHidden = false
        }
    }
    @IBAction func skipTut()
    {
        self.tutView.isHidden = true
    }
    func updtCrncy(TblTyp:String) {
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
        
        self.crncyTxt.text = crncy
        self.crcnyDdlBgCurv.text = (crncycode.htmlToString)
        self.crncyTblView.isHidden = true
        
    }
    func acntsTblSelect(acnt: String, acntId: String) {
        self.acntFillTxt.text = acnt
        self.acntIdVal = acntId
        self.crncyTblView.isHidden = true
        self.slctTblTitle.text = "Select Account"
    }
    
    @IBAction func clkCrncy()
    {
        //self.settngsViewMdl.getCurrency()
        self.crncyTblView.isHidden = false
        self.settngsViewMdl.getCurrency()
        self.settngsViewMdl.settngsDlgt = self
        self.crncyTbl.dataSource = settngsViewMdl
        self.crncyTbl.delegate = settngsViewMdl
    }
    @IBAction func clkAcnt()
    {
        //self.settngsViewMdl.getCurrency()
        self.crncyTblView.isHidden = false
        self.settngsViewMdl.getAcnts()
        self.settngsViewMdl.settngsDlgt = self
        self.crncyTbl.dataSource = settngsViewMdl
        self.crncyTbl.delegate = settngsViewMdl
    }
    @IBAction func clkLogout()
    {
        let alert = UIAlertController(title: "Dollar Book", message: "Do you want to Logout ?", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) in
            self.logout()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
        
    }
    func logout()
    {
        self.settngsViewMdl.logout()
    }
    @IBAction func clkDeltUserAcnt()
    {
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
        let attributedString = NSAttributedString(string: "Dollar Book \n Are you sure you want to delete your whole account ? You will loose all the added transactions and data.", attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), //your font here
                NSAttributedString.Key.foregroundColor : UIColor.white
            ])

            //let alert = UIAlertController(title: "", message: "",  preferredStyle: .alert)
            //Accessing alert view backgroundColor :
            alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.black
            alert.setValue(attributedString, forKey: "attributedTitle")
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = ColorManager.expenseColor()
        
            // Accessing buttons tintcolor :
            alert.view.tintColor = UIColor.white
                // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) in
            self.delAcntConf()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func delAcntConf()
    {
        let alert = UIAlertController(title: "Dollarbook", message: "Do you really want to delete your account ? This action cannot be reverted !!!", preferredStyle: UIAlertController.Style.alert)
        
        
            // Accessing buttons tintcolor :
           // alert.view.tintColor = UIColor.white
                // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) in
            self.dltAcnt()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
        
    }
    func dltAcnt()
    {
        self.settngsViewMdl.deleteUserAcnt()
    }
    @IBAction func openTagCntr()
    {
        self.tagCntr.isHidden = false
    }
    @IBAction func closeTagCntr()
    {
        self.tagCntr.isHidden = true
    }
    @IBAction func back()
    {
        self.dismiss(animated: false, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {

//        self.crvView.dropShadow(color: UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.3), opacity: 0.3, offSet: CGSize(width: -1, height: 1), radius: 17, scale: true)
//        self.crvView1.dropShadow(color: UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.5), opacity: 0.5, offSet: CGSize(width: -1, height: 1), radius: 17, scale: true)
//        self.crcnyDdlBgCurv.layer.cornerRadius = self.crcnyDdlBgCurv.frame.height/2
//        self.crcnyDdlBgCurv.layer.masksToBounds = true
    }
//    @objc func alarmAlertActivate(){
//            UIView.animate(withDuration: 0.7) {
//                self.arrow.alpha = self.arrow.alpha == 1.0 ? 0.8 : 1.0
//            }
//        }
//    func goToSlctCrncy()
//    {
//        self.performSegue(withIdentifier: "slctcrncy", sender: self)
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.crncyView)
        {
        return crncyArry.count
        }
        else
        {
            return tagNameArry.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == self.crncyView)
        {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crncyCell", for: indexPath) as! CustomImageCell
        let mydata = crncyArry[indexPath.item]
        cell.title.text = mydata as? String
        cell.crncy.text = crncyNmeArry[indexPath.item] as? String
//        cell.bgLbl.layer.cornerRadius = cell.bgLbl.frame.width/2
//        cell.bgLbl.layer.masksToBounds = true
        cell.bgLbl.layer.borderColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0).cgColor
        cell.bgLbl.layer.borderWidth = 1.0
//        if mydata["type"] as! String == "1"{
//           cell.pic.image = mydata["data"] as! UIImage
//        }
//        else{
//            cell.pic.image = #imageLiteral(resourceName: "PlayCollect")
//        }
        //cell.deleteBttn.tag = indexPath.item
        //cell.deleteBttn.addTarget(self, action: #selector(self.handleDelete), for: .touchUpInside)
        return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crncyCell", for: indexPath) as! tagsViewCell
            let mydata = tagNameArry[indexPath.item]
            //cell.bgLbl.cornerRadius = 8
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            cell.tagshort.cornerRadius = cell.tagshort.frame.height/2
            cell.tagName.text = mydata as? String
            return cell
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
public extension UIView {

/**
 Fade in a view with a duration
 
 - parameter duration: custom animation duration
 */


}
