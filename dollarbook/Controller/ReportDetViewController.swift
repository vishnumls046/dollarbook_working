//
//  ReportDetViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 25/07/23.
//

import UIKit
import NVActivityIndicatorView
import SOTabBar
protocol reportsDetUIUpdt
{
    func reprtStatUpdt(val:dashStatModel)
    func recentTblUpdt(trnsCnt:String)
    func editRedrct()
    func deleteAlert()
    func alerts(alrtStr:String)
}
class ReportDetViewController: UIViewController,NVActivityIndicatorViewable, reportsDetUIUpdt {
    @IBOutlet weak var totIncLbl:UILabel!
    @IBOutlet weak var totExpLbl:UILabel!
    @IBOutlet weak var recentsTblView:UITableView!
    @IBOutlet weak var noTrnscnLbl:UILabel!
    @IBOutlet weak var crvView:UIView!
    @IBOutlet weak var incmBubble:UILabel!
    @IBOutlet weak var expnseBubble:UILabel!
    var reprtDetViewModel =  ReportDetViewModel()
    var tags = ""
    var dateFilter = ""
    var frmDate = ""
    var toDate = ""
    var acntId = ""
    
//    override func loadView() {
//        super.loadView()
//        
//        SOTabBarSetting.tabBarTintColor = #colorLiteral(red: 0.568627451, green: 0.4352941176, blue: 0.937254902, alpha: 1)
//        SOTabBarSetting.tabBarHeight = 64.0
//        
//        //SOTabBarSetting.tabBarSizeSelectedImage = 50
//        //SOTabBarSetting.tabBarTintColor = UIColor(red: 242/255, green: 238/255, blue: 255/255, alpha: 1.0)
//        //SOTabBarSetting
//        //SOTabBarSetting.tabBarTintColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
//        //SOTabBarSetting.tabBarBackground = UIColor.white
//        SOTabBarSetting.tabBarCircleSize = CGSize(width: 60, height: 60)
//        //SOTabBarSetting.tabBarShadowColor = UIColor(red: 242/255, green: 238/255, blue: 255/255, alpha: 1.0).cgColor
//        SOTabBarSetting.tabBarShadowColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0).cgColor
//        let homeStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tab1")
//        let chatStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tab2")
//        let sleepStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tab3")
//        let musicStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tab4")
//        let meStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tab5")
//        
//        homeStoryboard.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Tab1_Small"), selectedImage: UIImage(named: "Tab1_Large"))
//        chatStoryboard.tabBarItem = UITabBarItem(title: "Income", image: UIImage(named: "Tab2_Small"), selectedImage: UIImage(named: "Tab2_Large"))
//        sleepStoryboard.tabBarItem = UITabBarItem(title: "Add", image: UIImage(named: "Tab3_Small"), selectedImage: UIImage(named: "Tab3_Large"))
//        musicStoryboard.tabBarItem = UITabBarItem(title: "Expense", image: UIImage(named: "Tab4_Small"), selectedImage: UIImage(named: "Tab4_Large"))
//        meStoryboard.tabBarItem = UITabBarItem(title: "Report", image: UIImage(named: "Tab5_Small"), selectedImage: UIImage(named: "Tab5_Large"))
//        
//        self.viewControllers = [homeStoryboard, chatStoryboard,sleepStoryboard,musicStoryboard,meStoryboard]
//    }
    override func viewDidLoad() {
        
        self.incmBubble.cornerRadius = self.incmBubble.frame.height/2
        self.expnseBubble.cornerRadius = self.expnseBubble.frame.height/2
        self.crvView.isHidden = false
        self.crvView.dropShadow(color: UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.5), opacity: 0.5, offSet: CGSize(width: -1, height: 1), radius: 17, scale: true)
        reprtDetViewModel.reprtDetDlgt = self
        recentsTblView.dataSource = reprtDetViewModel
        recentsTblView.delegate = reprtDetViewModel
        super.viewDidLoad()
        let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
        let crcyCode = crncy.htmlToString
        self.totIncLbl.text = "\(crcyCode) \(ReportViewModel.incTot)"
        self.totExpLbl.text = "\(crcyCode) \(ReportViewModel.expTot)" 
//        self.reprtDetViewModel.getDashStat(fromDate: ReportViewModel.frmDate, toDate: ReportViewModel.toDate,dateFilter:ReportViewModel.dateFilter,tag_id:ReportViewModel.tags,account_id:ReportViewModel.acntId)
        self.reprtDetViewModel.getTransactions(fromDate: ReportViewModel.frmDate, toDate: ReportViewModel.toDate,dateFilter:ReportViewModel.dateFilter, tags: ReportViewModel.tags,acntId:ReportViewModel.acntId, pageCnt: 0)
        
        
//        SOTabBarSetting.tabBarTintColor = #colorLiteral(red: 0.568627451, green: 0.4352941176, blue: 0.937254902, alpha: 1)
//        SOTabBarSetting.tabBarHeight = 64.0
//        
//        //SOTabBarSetting.tabBarSizeSelectedImage = 50
//        //SOTabBarSetting.tabBarTintColor = UIColor(red: 242/255, green: 238/255, blue: 255/255, alpha: 1.0)
//        //SOTabBarSetting
//        //SOTabBarSetting.tabBarTintColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
//        //SOTabBarSetting.tabBarBackground = UIColor.white
//        SOTabBarSetting.tabBarCircleSize = CGSize(width: 60, height: 60)
//        //SOTabBarSetting.tabBarShadowColor = UIColor(red: 242/255, green: 238/255, blue: 255/255, alpha: 1.0).cgColor
//        SOTabBarSetting.tabBarShadowColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0).cgColor
//        let homeStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tab1")
//        let chatStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tab2")
//        let sleepStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tab3")
//        let musicStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tab4")
//        let meStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tab5")
//        
//        homeStoryboard.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Tab1_Small"), selectedImage: UIImage(named: "Tab1_Large"))
//        chatStoryboard.tabBarItem = UITabBarItem(title: "Income", image: UIImage(named: "Tab2_Small"), selectedImage: UIImage(named: "Tab2_Large"))
//        sleepStoryboard.tabBarItem = UITabBarItem(title: "Add", image: UIImage(named: "Tab3_Small"), selectedImage: UIImage(named: "Tab3_Large"))
//        musicStoryboard.tabBarItem = UITabBarItem(title: "Expense", image: UIImage(named: "Tab4_Small"), selectedImage: UIImage(named: "Tab4_Large"))
//        meStoryboard.tabBarItem = UITabBarItem(title: "Report", image: UIImage(named: "Tab5_Small"), selectedImage: UIImage(named: "Tab5_Large"))
//        
//        self.viewControllers = [homeStoryboard, chatStoryboard,sleepStoryboard,musicStoryboard,meStoryboard]
        // Do any additional setup after loading the view.
    }
    func editRedrct()
    {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let vc = storyboard.instantiateViewController(withIdentifier: "trnscnDet")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    func deleteAlert()
    {
        var refreshAlert = UIAlertController(title: "DollarBook", message: "Do you want to delete transaction ?", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.startAnimating()
            DispatchQueue.global().async {
                self.reprtDetViewModel.Dlt()
            }
            
          }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
          print("Handle Cancel Logic here")
          }))

        self.present(refreshAlert, animated: true, completion: nil)
    }
    func alerts(alrtStr:String)
    {
        
        self.stopAnimating()
        let alert = UIAlertController(title: "Dollar Book", message: alrtStr, preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) in
            
            DispatchQueue.global().async {
                self.reprtDetViewModel.getTransactions(fromDate: ReportViewModel.frmDate, toDate: ReportViewModel.toDate,dateFilter:ReportViewModel.dateFilter, tags: ReportViewModel.tags,acntId:ReportViewModel.acntId, pageCnt: 0)
//                self.reprtDetViewModel.getTransactions(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter, tags: self.tags, acntId: self.acntId, pageCnt: 0)
//                self.reprtDetViewModel.getDashStat(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter,tag_id:self.tags,account_id:self.acntId)
            }
        }))
                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    func reprtStatUpdt(val: dashStatModel) {
        let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
        let crcyCode = crncy.htmlToString
        //self.totBalance.text = "\(crcyCode) \(val.current_balance!)"
        let incmFloat: Float = (val.total_income! as NSString).floatValue
        let incm = String(format: "%.f", incmFloat)
        self.totIncLbl.text = "\(crcyCode) \(incm)"
        let expFloat: Float = (val.total_expense! as NSString).floatValue
        let expns = String(format: "%.f", expFloat)
        self.totExpLbl.text = "\(crcyCode) \(expns)"
        
    }
    func recentTblUpdt(trnsCnt:String) {
        self.stopAnimating()
        if(trnsCnt == "0")
        {
            self.recentsTblView.isHidden = true
            self.noTrnscnLbl.isHidden = false
            self.noTrnscnLbl.text = "No Transactions"
        }
        else
        {
            self.recentsTblView.isHidden = false
            self.noTrnscnLbl.isHidden = true
            self.recentsTblView.reloadData()
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
