//
//  IncomeViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 01/09/22.
//

import UIKit
import MSBBarChart
import NVActivityIndicatorView
protocol ExpenseUIupdt
{
    func trnscnTblUpt()
    func barGrphUpt(valArry:[Int],mnthArry:[String])
    func editRedrct()
    func deleteAlert()
    func alerts(alrtStr:String)
    func noTrnscnUpt()
    func recentTblUpdt(trnsCnt:String)
}
class ExpenseViewController: UIViewController,UIScrollViewDelegate,ExpenseUIupdt,NVActivityIndicatorViewable {
    func trnscnTblUpt() {
        self.noTrnscn.isHidden = true
        self.recentsTblView.reloadData()
        self.stopAnimating()
    }
    func barGrphUpt(valArry:[Int],mnthArry:[String])
    {
        self.barChart.setOptions([.yAxisTitle("25K"), .yAxisNumberOfInterval(0)])
        self.barChart.assignmentOfColor =  [0.0..<50: #colorLiteral(red: 1, green: 0.5411642194, blue: 0.5411812663, alpha: 1), 0.0..<30: #colorLiteral(red: 1, green: 0.5411642194, blue: 0.5411812663, alpha: 1), 0.28..<0.42: #colorLiteral(red: 0.9960857034, green: 0.5372427106, blue: 0.5372596979, alpha: 1), 0.42..<0.56: #colorLiteral(red: 1, green: 0.7686228752, blue: 0.7686293125, alpha: 1), 0.56..<0.70: #colorLiteral(red: 1, green: 0.7686228752, blue: 0.7686293125, alpha: 1), 0.70..<1.0: #colorLiteral(red: 1, green: 0.7686228752, blue: 0.7686293125, alpha: 1)]
        self.barChart.setDataEntries(values: valArry)
        //self.barChart.setXAxisUnitTitles(["繊維","IT","鉄鋼","繊維","リテール","不動産","人材派遣","銀行"])
        //self.barChart.setXAxisUnitTitles(["Jan","Feb","Mar","Apr","May","Jun","July","銀行"])
        self.barChart.setXAxisUnitTitles(mnthArry)
        self.barChart.start()
    }
    var expenseVwMdl = ExpenseViewModel()
    @IBOutlet weak var noTrnscn:UILabel!
    @IBOutlet weak var barChart: MSBBarChartView!
    @IBOutlet weak var ddlBtn:UIButton!
    @IBOutlet weak var filterBtn:UIButton!
    @IBOutlet weak var recentsTblView:UITableView!
//    var incExpNameArry = NSMutableArray(array: ["Salary", "Interest", "Bakery","Shopping","Medicine", "Divident","Electricity bill","Interest"])
//    var incExpArry = NSMutableArray(array: ["2", "2", "2","2","2", "2","2","2"])
//    var incExpTimeArry = NSMutableArray(array: ["2 Hours ago ", "5 Hours ago", "A day ago","30/Aug/2022","30/Aug/2022", "29/Aug/2022","29/Aug/2022","28/Aug/2022"])
//    var incExpAmntArry = NSMutableArray(array: ["1000", "3000", "500","456","700", "200","1200","1850"])
    func editRedrct()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "trnscnDet")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    func recentTblUpdt(trnsCnt:String) {
        DispatchQueue.main.async {
            self.stopAnimating()
            if(trnsCnt == "0")
            {
                self.recentsTblView.isHidden = true
                self.noTrnscn.isHidden = false
                self.noTrnscn.text = "No Transactions found"
            }
            else
            {
                self.recentsTblView.isHidden = false
                self.noTrnscn.isHidden = true
                self.recentsTblView.reloadData()
            }
        }
    }
    func noTrnscnUpt() {
        self.stopAnimating()
        self.noTrnscn.isHidden = false
    }
    func deleteAlert()
    {
        var refreshAlert = UIAlertController(title: "DollarBook", message: "Do you want to delete transaction ?", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.startAnimating()
            DispatchQueue.global().async {
                self.expenseVwMdl.Dlt()
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
            self.expenseVwMdl.getTransactions()
            self.expenseVwMdl.getMnthsBarGraphData()
            
        }))
                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.noTrnscn.isHidden = true
        self.ddlBtn.cornerRadius = 9
        self.ddlBtn.borderColor = UIColor(red: 186/255, green: 178/255, blue: 210/255, alpha: 1.0)
        self.ddlBtn.borderWidth = 1
        self.filterBtn.cornerRadius = 9
        self.filterBtn.borderColor = UIColor(red: 186/255, green: 178/255, blue: 210/255, alpha: 1.0)
        self.filterBtn.borderWidth = 1
        expenseVwMdl.expnsDlgt = self
        
        self.recentsTblView.dataSource = expenseVwMdl
        self.recentsTblView.delegate = expenseVwMdl
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.hidesBottomBarWhenPushed = false
        self.startAnimating()
        DispatchQueue.global().async {
            self.expenseVwMdl.getTransactions()
            self.expenseVwMdl.getMnthsBarGraphData()
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
//        self.barChart.setOptions([.yAxisTitle("$25K"), .yAxisNumberOfInterval(10)])
//        self.barChart.assignmentOfColor =  [0.0..<50: #colorLiteral(red: 1, green: 0.5411642194, blue: 0.5411812663, alpha: 1), 0.0..<30: #colorLiteral(red: 1, green: 0.5411642194, blue: 0.5411812663, alpha: 1), 0.28..<0.42: #colorLiteral(red: 0.9960857034, green: 0.5372427106, blue: 0.5372596979, alpha: 1), 0.42..<0.56: #colorLiteral(red: 1, green: 0.7686228752, blue: 0.7686293125, alpha: 1), 0.56..<0.70: #colorLiteral(red: 1, green: 0.7686228752, blue: 0.7686293125, alpha: 1), 0.70..<1.0: #colorLiteral(red: 1, green: 0.7686228752, blue: 0.7686293125, alpha: 1)]
//        self.barChart.setDataEntries(values: [50,30,60,20,60,72,40,96,60,20,60,30])
//        //self.barChart.setXAxisUnitTitles(["繊維","IT","鉄鋼","繊維","リテール","不動産","人材派遣","銀行"])
//        //self.barChart.setXAxisUnitTitles(["Jan","Feb","Mar","Apr","May","Jun","July","銀行"])
//        self.barChart.setXAxisUnitTitles(["Jan","Feb","Mar","Apr","May","Jun","July","Aug","Sep","Oct","Nov","Dec"])
//        self.barChart.start()
    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.incExpArry.count
//       }
//       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//           let cell = tableView.dequeueReusableCell(withIdentifier: "listRecent", for: indexPath) as! recentTblViewCell
//           cell.crvdLbl.cornerRadius = 11
//        //var ordList = orderLst()
//
//           let str = self.incExpNameArry[indexPath.row] as! String
//           cell.title.text = str
//           cell.time.text = self.incExpTimeArry[indexPath.row] as! String
//           if(self.incExpArry[indexPath.row] as! String == "1")
//           {
//               cell.Icn.image = UIImage(named: "IncmTbl_Icn")
//               cell.crvdLbl.backgroundColor = UIColor(red: 242/255, green: 238/255, blue: 255/255, alpha: 1.0)
//               cell.amount.textColor = UIColor(red: 145/255, green: 11/255, blue: 239/255, alpha: 1.0)
//               cell.amount.text = "+$\(self.incExpAmntArry[indexPath.row] as! String)"
//           }
//           else
//           {
//               cell.Icn.image = UIImage(named: "expTbl_Icn")
//               cell.crvdLbl.backgroundColor = UIColor(red: 254/255, green: 232/255, blue: 232/255, alpha: 1.0)
//               cell.amount.textColor = UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
//               cell.amount.text = "-$\(self.incExpAmntArry[indexPath.row] as! String)"
//           }
           
        //cell.title.text = str
        //cell.time.text = str
        //cell.amount.text = str
        
        //return cell
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//}
