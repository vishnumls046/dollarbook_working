//
//  IncomeViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 01/09/22.
//

import UIKit
import MSBBarChart
import NVActivityIndicatorView
protocol IncomeUIupdt
{
    func trnscnTblUpt()
    func barGrphUpt(valArry:[Int],mnthArry:[String])
    func editRedrct()
    func deleteAlert()
    func alerts(alrtStr:String)
    func noTrnscnUpt()
    func recentTblUpdt(trnsCnt:String)
}
class IncomeViewController: UIViewController,UITableViewDelegate,UIScrollViewDelegate,IncomeUIupdt,NVActivityIndicatorViewable {
    func barGrphUpt(valArry:[Int],mnthArry:[String]) {
        self.barChart.setOptions([.yAxisTitle("25K"), .yAxisNumberOfInterval(0)])
        self.barChart.assignmentOfColor =  [0.0..<50: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), 0.0..<30: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), 0.28..<0.42: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), 0.42..<0.56: #colorLiteral(red: 0.8352945447, green: 0.7764695287, blue: 0.9999973178, alpha: 1), 0.56..<0.70: #colorLiteral(red: 0.8352945447, green: 0.7764695287, blue: 0.9999973178, alpha: 1), 0.70..<1.0: #colorLiteral(red: 0.8352945447, green: 0.7764695287, blue: 0.9999973178, alpha: 1)]
        self.barChart.setDataEntries(values: valArry)
        //self.barChart.setXAxisUnitTitles(["繊維","IT","鉄鋼","繊維","リテール","不動産","人材派遣","銀行"])
        //self.barChart.setXAxisUnitTitles(["Jan","Feb","Mar","Apr","May","Jun","July","銀行"])
        self.barChart.setXAxisUnitTitles(mnthArry)
        
        self.barChart.start()
    }
    
    @IBOutlet weak var barChart: MSBBarChartView!
    @IBOutlet weak var noTrnscn:UILabel!
    @IBOutlet weak var ddlBtn:UIButton!
    @IBOutlet weak var filterBtn:UIButton!
    @IBOutlet weak var recentsTblView:UITableView!
    @IBOutlet weak var crvView:UIView!
    var incomeVwMdl = IncomeViewModel()
    var incExpNameArry = NSMutableArray(array: ["Salary", "Interest", "Bakery","Shopping","Medicine", "Divident","Electricity bill","Interest"])
    var incExpArry = NSMutableArray(array: ["1", "1", "1","1","1", "1","1","1"])
    var incExpTimeArry = NSMutableArray(array: ["2 Hours ago ", "5 Hours ago", "A day ago","30/Aug/2022","30/Aug/2022", "29/Aug/2022","29/Aug/2022","28/Aug/2022"])
    var incExpAmntArry = NSMutableArray(array: ["1000", "3000", "500","456","700", "200","1200","1850"])
    func trnscnTblUpt() {
        self.noTrnscn.isHidden = true
        self.recentsTblView.reloadData()
        self.stopAnimating()
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
                self.incomeVwMdl.Dlt()
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
            self.incomeVwMdl.getTransactions()
            self.incomeVwMdl.getMnthsBarGraphData()
            
        }))
                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        
        self.noTrnscn.isHidden = true
        super.viewDidLoad()
        self.ddlBtn.cornerRadius = 9
        self.ddlBtn.borderColor = UIColor(red: 186/255, green: 178/255, blue: 210/255, alpha: 1.0)
        self.ddlBtn.borderWidth = 1
        self.filterBtn.cornerRadius = 9
        self.filterBtn.borderColor = UIColor(red: 186/255, green: 178/255, blue: 210/255, alpha: 1.0)
        self.filterBtn.borderWidth = 1
        
        incomeVwMdl.incmDlgt = self
        
        self.recentsTblView.dataSource = incomeVwMdl
        self.recentsTblView.delegate = incomeVwMdl
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.startAnimating()
        DispatchQueue.global().async {
            self.incomeVwMdl.getMnthsBarGraphData()
            self.incomeVwMdl.getTransactions()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        
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
