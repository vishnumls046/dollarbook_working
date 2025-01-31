//
//  AcntReportViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 17/12/22.
//

import UIKit
import Fastis
import NVActivityIndicatorView
protocol acntReportProt
{
    func recentTblUpdt(trnsCnt:String)
    func slctTbl()
    func editRedrct()
    func deleteAlert()
    func alerts(alrtStr:String)
}
class AcntReportViewController: UIViewController,acntReportProt,NVActivityIndicatorViewable {
    @IBOutlet weak var recentsTblView:UITableView!
    @IBOutlet weak var load:NVActivityIndicatorView!
    var acntReprtMdl =  acntReportViewModel()
    @IBOutlet weak var noTrnscnLbl:UILabel!
    @IBOutlet weak var topTitle:UILabel!
    @IBOutlet weak var dateRngeLbl:UILabel!
    var frmDte = ""
    var toDte = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noTrnscnLbl.isHidden = true
        self.topTitle.text = mngeAcntsViewModel.slctdAcntName
        self.acntReprtMdl.acntRprtDlgt = self
        self.recentsTblView.delegate = acntReprtMdl
        self.recentsTblView.dataSource = acntReprtMdl
        
        // Do any additional setup after loading the view.
    }
    func deleteAlert()
    {
        var refreshAlert = UIAlertController(title: "DollarBook", message: "Do you want to delete transaction ?", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.startAnimating()
            DispatchQueue.global().async {
                self.acntReprtMdl.Dlt()
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
        DispatchQueue.global().async {
        
        self.acntReprtMdl.getTransactions(fromDate: "", toDate: "", tags: "", acntId: mngeAcntsViewModel.slctdAcntId)
        }
//        let alert = UIAlertController(title: "Dollar Book", message: alrtStr, preferredStyle: UIAlertController.Style.alert)
//                // add an action (button)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) in
//
//
//
//
//        }))
//                // show the alert
//                self.present(alert, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.startAnimating()
        let monthsToAdd = -1
         let currentDate = Date()
        var dateComponent = DateComponents()
         dateComponent.month = monthsToAdd
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd"

        self.dateRngeLbl.text = "From \(dateFormatter1.string(from: futureDate!))  -  \(dateFormatter1.string(from: currentDate))"
       
        DispatchQueue.global().async {
            self.acntReprtMdl.getTransactions(fromDate: "", toDate: "", tags: "", acntId: mngeAcntsViewModel.slctdAcntId)
        }
    }
   
    func editRedrct()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "trnscnDet")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    func recentTblUpdt(trnsCnt:String) {
        self.stopAnimating()
        if(trnsCnt == "0")
        {
            self.stopAnimating()
            self.recentsTblView.isHidden = true
            self.noTrnscnLbl.isHidden = false
            self.noTrnscnLbl.text = "No Transactions in this account"
        }
        else
        {
            self.stopAnimating()
            //self.dateRngeLbl.text = "From \(self.frmDte) - \(self.toDte)"
            self.recentsTblView.isHidden = false
            self.noTrnscnLbl.isHidden = true
            self.recentsTblView.reloadData()
            
        }
    }
    func slctTbl()
    {
        self.performSegue(withIdentifier: "bnkrprt", sender: self)
    }
    @IBAction func chooseDate() {
    var customConfig = FastisConfig.default
customConfig.dayCell.dateLabelColor = UIColor(red: 141/255, green: 118/255, blue: 206/255, alpha: 1.0)
customConfig.controller.barButtonItemsColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
        customConfig.controller.barButtonItemsColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
    customConfig.monthHeader.labelColor = .black
        customConfig.shortcutItemView.selectedBackgroundColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
        
customConfig.dayCell.selectedBackgroundColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
customConfig.dayCell.onRangeBackgroundColor = UIColor(red: 229/255, green: 220/255, blue: 255/255, alpha: 1.0)
    let fastisController = FastisController(mode: .range, config: customConfig)
    fastisController.title = "Choose range"
    fastisController.maximumDate = Date()
    fastisController.allowToChooseNilDate = true
        
        var customShortcut1 = FastisShortcut(name: "This month") {
            let now = Date()
            let thismonth = Calendar.current.date(byAdding: .month, value: 1, to: now)!
            let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: now)
            let startOfMonth = Calendar.current.date(from: comp)!
            
         
            return FastisRange(from: startOfMonth, to: now)
            //return FastisRange(from: now, to: now)
        }
        
        var customShortcut2 = FastisShortcut(name: "Last month") {
            let now = Date()
            let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: now)
            let startOfMonth = Calendar.current.date(from: comp)!
            let firstday = Calendar.current.date(byAdding: .month, value: -1, to: startOfMonth)!
            let lastDay = Calendar.current.date(byAdding: .day, value: -1, to: startOfMonth)!
            
            return FastisRange(from: firstday, to: lastDay)
            //return FastisRange(from: now, to: now)
        }
        var customShortcut3 = FastisShortcut(name: "Last 3 months") {
            let now = Date()
            let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: now)
            let startOfMonth = Calendar.current.date(from: comp)!
            let firstday = Calendar.current.date(byAdding: .month, value: -3, to: startOfMonth)!
            let lastDay = Calendar.current.date(byAdding: .day, value: -1, to: startOfMonth)!
            
            return FastisRange(from: firstday, to: lastDay)
            //return FastisRange(from: now, to: now)
        }
        
        fastisController.shortcuts = [customShortcut1,customShortcut2,customShortcut3]
    
    fastisController.doneHandler = { resultRange in
       // print(resultRange)
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MMM-dd"
        self.dateRngeLbl.text = "From \(dateFormatter1.string(from: resultRange!.fromDate)) - \(dateFormatter1.string(from: resultRange!.toDate))"
        if(resultRange != nil)
        {
            self.startAnimating()
            DispatchQueue.global().async {
                self.acntReprtMdl.pagecount = 0
                //self.frmDte = "\(resultRange!.fromDate)"
                //self.toDte = "\(resultRange!.toDate)"
                self.acntReprtMdl.getTransactions(fromDate: "\(resultRange!.fromDate)", toDate: "\(resultRange!.toDate)", tags: "", acntId: mngeAcntsViewModel.slctdAcntId)
            }
            
            
        }
        else
        {
            
        }
    }
    fastisController.present(above: self)
        }
    @IBAction func back()
    {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func toSettings()
    {
        performSegue(withIdentifier: "unwindToSettings", sender: self)
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
class initialBalTblViewCell: UITableViewCell {
    @IBOutlet weak var initilBal_title: UILabel!
    @IBOutlet weak var initilBal_amnt: UILabel!
    @IBOutlet weak var initilBal_date: UILabel!
    @IBOutlet weak var crvdLbl1: UILabel!
    
}
