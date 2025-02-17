//
//  IncomeViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 01/09/22.
//

import UIKit
import MSBBarChart
import Fastis
import NVActivityIndicatorView
import Toaster
import PieCharts
import TagListView
protocol reportsUIUpdt
{
    func reprtStatUpdt(val:dashStatModel)
    func chartUpdt(incmArry:[IncomeTags],expArry:[ExpenseTags])
    func graphValUpdt(IncVals:Double,ExpVals:Double )
    func recentTblUpdt(trnsCnt:String)
    func loadTagsCln(incmTagAry:[String],expnsTagAry:[String],incmTagIdAry:[String],expnsTagIdAry:[String])
    func slctTagId(val:[String])
    func updtAcntTbl()
    func editRedrct()
    func deleteAlert()
    func alerts(alrtStr:String)
    func closeSpin()
    func slctTbl()
}
class ReportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate, UIGestureRecognizerDelegate,reportsUIUpdt,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,NVActivityIndicatorViewable,PieChartDelegate, TagListViewDelegate {
    
    func chartUpdt(incmArry:[IncomeTags],expArry:[ExpenseTags])
    {
        
        if(incmOrExp == "1")
        {
            if(incmArry.count>0)
            {
                self.chartView.isHidden = false
                self.noChartCnstrnt.constant = 249
                chartView.clear()
                self.models = []
                for index in incmArry.indices {
                    //print("\(index): \(incmArry[index])")
                    self.models.append(PieSliceModel(value: Double(incmArry[index].income_percentage!), color: UIColor(hex: incmArry[index].iconColor!)))
                }
                chartView.layers = [createPlainTextLayer()]
                chartView.models = self.models
            }
            else
            {
                self.chartView.isHidden = true
                self.noChartCnstrnt.constant = 15
            }
            
                

        }
        else
        {
            if(expArry.count>0)
            {
                self.chartView.isHidden = false
                self.noChartCnstrnt.constant = 249
                chartView.clear()
                self.models = []
                for index in expArry.indices {
                    
                    self.models.append(PieSliceModel(value: Double(expArry[index].expense_percentage!), color: UIColor(hex: expArry[index].iconColor!)))
                }
                chartView.layers = [createPlainTextLayer()]
                chartView.models = self.models
            }
            else
            {
                self.chartView.isHidden = true
                self.noChartCnstrnt.constant = 15
            }
        }

    }
    func slctTbl()
    {
        self.performSegue(withIdentifier: "repDet", sender: self)
    }
    func closeSpin()
    {
        self.recentsTblView.isHidden = true
        self.stopAnimating()
    }
    func loadTagsCln(incmTagAry:[String],expnsTagAry:[String],incmTagIdAry:[String],expnsTagIdAry:[String]) {
        
        self.incmTagAryVal = incmTagAry
        self.expnsTagAryVal = expnsTagAry
        
        self.incmTagIdAryVal = incmTagIdAry
        self.expnsTagIdAryVal = expnsTagIdAry
        
        //self.tagsClnView.reloadData()
        self.stopAnimating()
    }
    func slctTagId(val:[String]) {
        var slct:[String] = []
        slct.append(contentsOf: val)
    }
    func updtAcntTbl()
    {
        self.acntsTblView.reloadData()
        self.acntView.isHidden = false
        self.stopAnimating()
    }
    func reprtStatUpdt(val: dashStatModel) {
        let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
        let crcyCode = crncy.htmlToString
        //self.totBalance.text = "\(crcyCode) \(val.current_balance!)"
        let incmFloat: Float = (val.total_income! as NSString).floatValue
        let incm = String(format: "%.f", incmFloat)
        
        let expFloat: Float = (val.total_expense! as NSString).floatValue
        let expns = String(format: "%.f", expFloat)
        if(self.incmOrExp == "1")
        {
            self.incmExpnLgndLbl.text = "Income"
            self.incmExpnLgndLbl.textColor = ColorManager.incomeColor()
            self.totIncLbl.text = "\(crcyCode)\(incm)"
            self.totIncLbl.textColor = ColorManager.incomeColor()
            self.crvView.borderWidth = 1
            self.crvView.borderColor = ColorManager.incomeColor()
        }
        else if(self.incmOrExp == "2")
        {
            self.incmExpnLgndLbl.text = "Expense"
            self.totIncLbl.text = "\(crcyCode)\(expns)"
            self.incmExpnLgndLbl.textColor = ColorManager.expenseColor()
            self.totIncLbl.textColor = ColorManager.expenseColor()
            self.crvView.borderWidth = 1
            self.crvView.borderColor = ColorManager.expenseColor()
        }

        
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
    func editRedrct()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "trnscnDet")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    func graphValUpdt(IncVals: Double, ExpVals: Double) {
        print(IncVals)
        if (IncVals < 4 && ExpVals < 4)
        {
            let chart = Circular(percentages: [IncVals,ExpVals], colors: [UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0),UIColor.white],aimationType: .animationFanAll,showPercentageStyle: .inward)
            let frm: CGRect = self.grphlLoadView.frame
            //chart.frame = CGRect(x: 35, y: 50, width: 250, height: 250)
            chart.frame = CGRect(x: frm.width*17/100, y: frm.origin.y, width: frm.width/1.5, height: frm.height)
            self.grphlLoadView.addSubview(chart)
        }
        else if(IncVals < 4)
        {
            let chart = Circular(percentages: [IncVals,ExpVals], colors: [UIColor.clear,UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)],aimationType: .animationFanAll,showPercentageStyle: .inward)
            let frm: CGRect = self.grphlLoadView.frame
            //chart.frame = CGRect(x: 35, y: 50, width: 250, height: 250)
            chart.frame = CGRect(x: frm.width*17/100, y: frm.origin.y, width: frm.width/1.5, height: frm.height)
            self.grphlLoadView.addSubview(chart)
        }
        else if(ExpVals < 4)
        {
            let chart = Circular(percentages: [IncVals,ExpVals], colors: [UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0),UIColor.clear],aimationType: .animationFanAll,showPercentageStyle: .inward)
            let frm: CGRect = self.grphlLoadView.frame
            //chart.frame = CGRect(x: 35, y: 50, width: 250, height: 250)
            chart.frame = CGRect(x: frm.width*17/100, y: frm.origin.y, width: frm.width/1.5, height: frm.height)
            self.grphlLoadView.addSubview(chart)
        }
        else
        {
            let chart = Circular(percentages: [IncVals,ExpVals], colors: [UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0),UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)],aimationType: .animationFanAll,showPercentageStyle: .inward)
            let frm: CGRect = self.grphlLoadView.frame
            //chart.frame = CGRect(x: 35, y: 50, width: 250, height: 250)
            chart.frame = CGRect(x: frm.width*17/100, y: frm.origin.y, width: frm.width/1.5, height: frm.height)
            self.grphlLoadView.addSubview(chart)
        }
        
    }
    fileprivate static let alpha: CGFloat = 0.7
    fileprivate static let alpha1: CGFloat = 0.4
    let colors = [
        UIColor.systemIndigo.withAlphaComponent(alpha),
        UIColor.systemGreen.withAlphaComponent(alpha),
        UIColor.purple.withAlphaComponent(alpha),
        UIColor.systemTeal.withAlphaComponent(alpha),
        UIColor.red.withAlphaComponent(alpha),
        UIColor.systemYellow.withAlphaComponent(alpha),
        UIColor.orange.withAlphaComponent(alpha),
        UIColor.brown.withAlphaComponent(alpha),
        UIColor.systemRed.withAlphaComponent(alpha),
        UIColor.systemBlue.withAlphaComponent(alpha),
        UIColor.systemPink.withAlphaComponent(alpha),
        UIColor.magenta.withAlphaComponent(alpha),
        UIColor.systemOrange.withAlphaComponent(alpha),
        UIColor.systemPurple.withAlphaComponent(alpha),
        UIColor.lightGray.withAlphaComponent(alpha),
        UIColor.cyan.withAlphaComponent(alpha),
        UIColor.systemIndigo.withAlphaComponent(alpha1),
        UIColor.systemGreen.withAlphaComponent(alpha1),
        UIColor.purple.withAlphaComponent(alpha1),
        UIColor.systemTeal.withAlphaComponent(alpha1),
        UIColor.red.withAlphaComponent(alpha1),
        UIColor.magenta.withAlphaComponent(alpha1),
        UIColor.orange.withAlphaComponent(alpha1),
        UIColor.brown.withAlphaComponent(alpha1),
        UIColor.systemYellow.withAlphaComponent(alpha1),
        UIColor.systemRed.withAlphaComponent(alpha1),
        UIColor.systemBlue.withAlphaComponent(alpha1),
        UIColor.systemPink.withAlphaComponent(alpha1),
        UIColor.systemOrange.withAlphaComponent(alpha1),
        UIColor.systemPurple.withAlphaComponent(alpha1),
        UIColor.lightGray.withAlphaComponent(alpha1),
        UIColor.cyan.withAlphaComponent(alpha1)
        
    ]
    var dateRnge = FastisRange(from: Date(), to: Date())
    var reprtViewModel =  ReportViewModel()
    var dashViewModel = DashboardViewModel()
    var addTrnscViewMdlObj = addTrnscnViewModel()
    @IBOutlet weak var mainScroll:UIScrollView!
    @IBOutlet weak var topLablBg:UILabel!
    @IBOutlet weak var acntView:UIView!
    @IBOutlet weak var tagSwitch: UISwitch!
    @IBOutlet weak var barChart: MSBBarChartView!
    @IBOutlet weak var tagsView:UIView!
    @IBOutlet weak var filterFrame:UIView!
    @IBOutlet weak var clndrFrame:UIView!
    @IBOutlet weak var filterBtn:UIButton!
    @IBOutlet weak var addfilterBtn:UIButton!
    @IBOutlet weak var recentsTblView:UITableView!
    @IBOutlet weak var tagsClnView:UICollectionView!
    @IBOutlet weak var acntsTblView:UITableView!
    @IBOutlet weak var grphlLoadView,CategoryGridView:UIView!
    @IBOutlet weak var crvView:UIView!
    @IBOutlet weak var noTrnscnLbl:UILabel!
    @IBOutlet weak var totBalance,showingMnthLbl:UILabel!
    @IBOutlet weak var totIncLbl,incmExpnLgndLbl:UILabel!
    @IBOutlet weak var totExpLbl,ctgryBgBlckLbl:UILabel!
    @IBOutlet weak var dateRangeLbl:UILabel!
    @IBOutlet weak var incmCntnrLine:UILabel!
    @IBOutlet weak var expCntnrLine:UILabel!
    @IBOutlet weak var incmBtn:UIButton!
    @IBOutlet weak var expBtn,thismnthBtn,lastmnthBtn,rangeBtn:UIButton!
    @IBOutlet weak var slctdTagLbl:UILabel!
    @IBOutlet weak var chartView: PieChart!
    @IBOutlet weak var tagsList: TagListView!
    @IBOutlet weak var acntsList: TagListView!
    @IBOutlet weak var noChartCnstrnt,ctgryVieBtmCnstrt: NSLayoutConstraint!
    //@IBOutlet weak var topLablBg:UILabel!
    var models:[PieSliceModel] = []
    var incmTagAryVal:[String] = []
    var expnsTagAryVal:[String] = []
    var incmTagIdAryVal:[String] = []
    var expnsTagIdAryVal:[String] = []
    
    var slctdTagIds:[String] = []
    var acntIdAry:[String] = []
    var acntNmeAry:[String] = []
    var tagfull = false
    var i = 0
    var dateBtnSelStylVal = 0
    var tags = ""
    var dateFilter = ""
    var frmDate = ""
    var toDate = ""
    var acntId = ""
    var acntName = "All Accounts"
    var switchVal = "income"
    var incmOrExp = "1"
    var incExpNameArry = NSMutableArray(array: ["Salary", "Interest", "Bakery","Shopping","Medicine", "Divident","Electricity bill","Interest"])
    var incExpArry = NSMutableArray(array: ["1", "2", "1","1","1", "2","2","1"])
    var incExpTimeArry = NSMutableArray(array: ["2 Hours ago ", "5 Hours ago", "A day ago","30/Aug/2022","30/Aug/2022", "29/Aug/2022","29/Aug/2022","28/Aug/2022"])
    var incExpAmntArry = NSMutableArray(array: ["1000", "3000", "500","456","700", "200","1200","1850"])
    func deleteAlert()
    {
        var refreshAlert = UIAlertController(title: "DollarBook", message: "Do you want to delete transaction ?", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.startAnimating()
            DispatchQueue.global().async {
                self.reprtViewModel.Dlt()
            }
            
          }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
          print("Handle Cancel Logic here")
          }))

        self.present(refreshAlert, animated: true, completion: nil)
    }
    func onSelected(slice: PieSlice, selected: Bool) {
        print("Selected: \(selected), slice: \(slice)")
    }
    func alerts(alrtStr:String)
    {
        
        self.stopAnimating()
        let alert = UIAlertController(title: "Dollar Book", message: alrtStr, preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) in
            DispatchQueue.global().async {
                
//                self.reprtViewModel.getTransactions(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter, tags: self.tags, acntId: self.acntId, pageCnt: 0)
                self.reprtViewModel.getDashStat(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter,tag_id:self.tags,account_id:self.acntId)
            }
        }))
                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        DispatchQueue.global().async {
            self.reprtViewModel.getAcnts()
        }
        
        self.ctgryBgBlckLbl.isHidden = true
        self.ctgryVieBtmCnstrt.constant = -610
        self.chartView.delegate = self
        self.dateRangeLbl.textColor = ColorManager.incomeColor()
    
        self.dateFilter == "daterange"
        let currentDate = Date()
       var dateComponent = DateComponents()
        //dateComponent.month = monthsToAdd
       let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
       let dateFormatter1 = DateFormatter()
       dateFormatter1.dateFormat = "d MMM yy"
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: currentDate)
        let startOfMonth = Calendar.current.date(from: comp)!
        print(dateFormatter1.string(from: startOfMonth))
        self.dateRangeLbl.text = "\(dateFormatter1.string(from: startOfMonth)) - \(dateFormatter1.string(from: currentDate))"
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.frmDate = dateFormatter2.string(from: startOfMonth)
        self.toDate = dateFormatter2.string(from: currentDate)
        
        
        self.topLablBg.backgroundColor = UIColor.init(named: "ModeColor")
        super.viewDidLoad()
        //self.dateRangeLbl.text = "Select Date"
        self.tags = ""
        //self.dateFilter = ""
        //self.frmDate = ""
        //self.toDate = ""
        self.acntId = ""
        
        self.acntName = "All Accounts"
        self.acntView.isHidden = true
        self.tagsClnView.allowsMultipleSelection = true
//        self.tagsClnView.isUserInteractionEnabled = true
        self.clndrFrame.isHidden = true
        self.filterFrame.isHidden = true
        self.filterBtn.cornerRadius = 9
        self.filterBtn.borderColor = UIColor(red: 186/255, green: 178/255, blue: 210/255, alpha: 1.0)
        self.filterBtn.borderWidth = 1
        
        reprtViewModel.reprtDlgt = self
        recentsTblView.dataSource = reprtViewModel
        recentsTblView.delegate = reprtViewModel
        tagsClnView.dataSource = reprtViewModel
        tagsClnView.delegate = reprtViewModel
        acntsTblView.dataSource = self
        acntsTblView.delegate = self
        
        
        self.tagSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil)
    {
//        if(self.keybrdSts == 1)
//        {
//            self.dismissKeyboard()
//            self.keybrdSts = 0
//        }
         if(self.acntsTblView.isHidden == false)
        {
            self.closeAcntView()
        }
        if(self.filterFrame.isHidden == false)
       {
            self.filterFrame.isHidden = true
            
       }
    }
    @IBAction func clickFilterView()
    {
        switch self.dateBtnSelStylVal
        {
        case 0:
            self.thismnthBtn.backgroundColor = UIColor.white
            self.thismnthBtn.setTitleColor(UIColor.black, for: .normal)
            self.lastmnthBtn.backgroundColor = UIColor.white
            self.lastmnthBtn.setTitleColor(UIColor.black, for: .normal)
            self.rangeBtn.backgroundColor = UIColor.white
            self.rangeBtn.setTitleColor(UIColor.black, for: .normal)
        case 1:
            self.thismnthBtn.backgroundColor = UIColor.black
            self.thismnthBtn.setTitleColor(UIColor.white, for: .normal)
            self.lastmnthBtn.backgroundColor = UIColor.white
            self.lastmnthBtn.setTitleColor(UIColor.black, for: .normal)
            self.rangeBtn.backgroundColor = UIColor.white
            self.rangeBtn.setTitleColor(UIColor.black, for: .normal)
        case 2:
            self.lastmnthBtn.backgroundColor = UIColor.black
            self.lastmnthBtn.setTitleColor(UIColor.white, for: .normal)
            self.thismnthBtn.backgroundColor = UIColor.white
            self.thismnthBtn.setTitleColor(UIColor.black, for: .normal)
            self.rangeBtn.backgroundColor = UIColor.white
            self.rangeBtn.setTitleColor(UIColor.black, for: .normal)
        case 3:
            self.rangeBtn.backgroundColor = UIColor.black
            self.rangeBtn.setTitleColor(UIColor.white, for: .normal)
            self.thismnthBtn.backgroundColor = UIColor.white
            self.thismnthBtn.setTitleColor(UIColor.black, for: .normal)
            self.lastmnthBtn.backgroundColor = UIColor.white
            self.lastmnthBtn.setTitleColor(UIColor.black, for: .normal)
        default:
            self.thismnthBtn.backgroundColor = UIColor.white
            self.thismnthBtn.setTitleColor(UIColor.black, for: .normal)
            self.lastmnthBtn.backgroundColor = UIColor.white
            self.lastmnthBtn.setTitleColor(UIColor.black, for: .normal)
            self.rangeBtn.backgroundColor = UIColor.white
            self.rangeBtn.setTitleColor(UIColor.black, for: .normal)
        }
        self.tagsList.textFont = .systemFont(ofSize: 14)
        self.acntsList.textFont = .systemFont(ofSize: 14)
        
//        var size = 0
//        if(ReportViewModel.acntsMdlArry.count > 6)
//        {
//            size = 6
//        }
//        else
//        {
//            size = self.incmTagAryVal.count
//        }
        self.acntsList.removeAllTags()
        for i in 0..<ReportViewModel.acntsMdlArry.count
        {
            
                var vals = ReportViewModel.acntsMdlArry[i]
            if(self.acntId == vals.account_id)
            {
                let acntVw = self.acntsList.addTag(vals.account_name!)
                acntVw.isSelected = true
            }
            else
            {
                self.acntsList.addTag(vals.account_name!)
            }
            
        }
        
        //fill tags
        self.tagsList.removeAllTags()

        
        if(self.incmOrExp == "1")
        {
//            var size = 0
//            if(self.incmTagAryVal.count > 6)
//            {
//                size = 6
//            }
//            else
//            {
//                size = self.incmTagAryVal.count
//            }
            self.tagsList.removeAllTags()
            for i in 0..<self.incmTagAryVal.count
            {
                if(self.slctdTagIds.contains(self.incmTagIdAryVal[i]))
                {
                   let tagVw = self.tagsList.addTag(self.incmTagAryVal[i])
                    tagVw.isSelected = true
                }
                else
                {
                    self.tagsList.addTag(self.incmTagAryVal[i])
                }
            }
        }
        else
        {
//            var size = 0
//            if(self.expnsTagAryVal.count > 6)
//            {
//                size = 6
//            }
//            else
//            {
//                size = self.expnsTagAryVal.count
//            }
            self.tagsList.removeAllTags()
            for i in 0..<self.expnsTagAryVal.count
            {
                if(self.slctdTagIds.contains(self.expnsTagIdAryVal[i]))
                {
                   let tagVw = self.tagsList.addTag(self.expnsTagAryVal[i])
                    tagVw.isSelected = true
                }
                else
                {
                    self.tagsList.addTag(self.expnsTagAryVal[i])
                }
            }
           
        }
        self.view.endEditing(true)
        // Curve only the top corners
        self.CategoryGridView.layer.cornerRadius = 30 // Adjust the radius as needed
        self.CategoryGridView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top-left and top-right corners
        self.CategoryGridView.layer.masksToBounds = true
        self.ctgryVieBtmCnstrt.constant = 0
        //self.tagsClnView.reloadData()
        UIView.animate(withDuration: 0.7, animations: {
            self.ctgryBgBlckLbl.isHidden = false
                    self.view.layoutIfNeeded()
                }, completion: { _ in
                    print("Animation complete")
                    
                })
    }
    @IBAction func fulltags()
    {
        if(self.incmOrExp == "1")
        {
            var size = 0
            if(self.tagfull)
            {
                if(self.incmTagAryVal.count > 6)
                {
                    size = 6
                }
                else
                {
                    size = self.incmTagAryVal.count
                }
                self.tagsList.removeAllTags()
                for i in 0..<size
                {
                    self.tagsList.addTag(self.incmTagAryVal[i])
                }
                self.tagfull = false
            }
            else
            {
                self.tagsList.removeAllTags()
                for i in 0..<self.incmTagAryVal.count
                {
                    self.tagsList.addTag(self.incmTagAryVal[i])
                }
                self.tagfull = true
            }
        }
        else
        {
            
//            var size = 0
//            if(self.tagfull)
//            {
//                if(self.expnsTagAryVal.count > 6)
//                {
//                    size = 6
//                }
//                else
//                {
//                    size = self.expnsTagAryVal.count
//                }
//                self.tagsList.removeAllTags()
//                for i in 0..<self.expnsTagAryVal.count
//                {
//                    self.tagsList.addTag(self.expnsTagAryVal[i])
//                }
//                self.tagfull = false
//            }
//            else
//            {
//                self.tagsList.removeAllTags()
//                for i in 0..<self.expnsTagAryVal.count
//                {
//                    self.tagsList.addTag(self.expnsTagAryVal[i])
//                }
//                self.tagfull = true
//            }
        }
    }
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
        if(sender.tag == 1)      // Click is from  tags list
        {
            if(self.incmOrExp == "1")
            {
                
                //print("Tag pressed: \(title), \(sender)")
                tagView.isSelected = !tagView.isSelected
                if let index = self.incmTagAryVal.firstIndex(of: title) {
                    var slctdTagId  = self.incmTagIdAryVal[index]
                    toggleValue(in: &self.slctdTagIds, value: slctdTagId)
                    
                    self.tags = self.slctdTagIds.joined(separator: ",")
                    print(self.tags)
                    
                } else {
                    print("Value not found in the array")
                }
                print(self.slctdTagIds)
            }
            else
            {
                
                tagView.isSelected = !tagView.isSelected
                if let index = self.expnsTagAryVal.firstIndex(of: title) {
                    var slctdTagId  = self.expnsTagIdAryVal[index]
                    toggleValue(in: &self.slctdTagIds, value: slctdTagId)
                    
                    self.tags = self.slctdTagIds.joined(separator: ",")
                    print(self.tags)
                    
                } else {
                    print("Value not found in the array")
                }
                print(self.slctdTagIds)
            }
            self.reprtViewModel.getReports(fromDate:self.frmDate , toDate:self.toDate ,dateFilter:self.dateFilter, tags: self.tags,acntId:self.acntId, type: self.incmOrExp)
            self.reprtViewModel.getDashStat(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter,tag_id:self.tags,account_id:self.acntId)
        }
        
        
        else if(sender.tag == 2) // Click is from  Acnts list
        {
            sender.tagViews.forEach {$0.isSelected = false}
            tagView.isSelected = !tagView.isSelected
            
            for acntDet in ReportViewModel.acntsMdlArry as Array {
                
                self.acntNmeAry.append(acntDet.account_name!)
                self.acntIdAry.append(acntDet.account_id!)
           }
            if let index = self.acntNmeAry.firstIndex(of: title) {
                self.acntId  = self.acntIdAry[index]

                
            } else {
                print("Value not found in the array")
            }
            self.reprtViewModel.getReports(fromDate:self.frmDate , toDate:self.toDate ,dateFilter:self.dateFilter, tags: self.tags,acntId:self.acntId, type: self.incmOrExp)
            self.reprtViewModel.getDashStat(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter,tag_id:self.tags,account_id:self.acntId)
        }
    }
    func toggleValue<T: Equatable>(in array: inout [T], value: T) {
        if let index = array.firstIndex(of: value) {
            array.remove(at: index)
            print("\(value) was removed. Updated array: \(array)")
        } else {
            array.append(value)
            print("\(value) was added. Updated array: \(array)")
        }
    }
    
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
    @objc func switchChanged(mySwitch: UISwitch) {
        let value = mySwitch.isOn
        if(value == false)
        {
            self.switchVal = "income"
            ReportViewModel.seltagName = []
        }
        else
        {
            ReportViewModel.seltagName = []
            self.switchVal = "expense"
        }
        DispatchQueue.global().async {
            
            self.reprtViewModel.getTags(tags: self.switchVal)
            //self.reprtViewModel.getDfltTags(tags: self.switchVal)
        }
        // Do something
    }
    @IBAction func clkIncome()
    {
        self.slctdTagIds = []
        self.incmOrExp = "1"
        self.startAnimating()
        self.incmBtn.backgroundColor = ColorManager.incomeColor()
        self.expBtn.backgroundColor = UIColor.lightGray
//        self.incmCntnrLine.isHidden = false
//        self.expCntnrLine.isHidden = true
        self.incmBtn.layer.zPosition = 1
        self.expBtn.layer.zPosition = 0
        //self.recentsTblView.backgroundColor = ColorManager.incomeColorBg()
        DispatchQueue.global().async {
        
        self.reprtViewModel.getReports(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter, tags: self.tags,acntId:self.acntId, type: "1")
            self.reprtViewModel.getDashStat(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter, tag_id: self.tags,account_id:self.acntId)
        }
    }
    @IBAction func clkExpense()
    {
        self.slctdTagIds = []
        self.incmOrExp = "2"
        self.startAnimating()
        self.incmBtn.backgroundColor = UIColor.lightGray
        self.expBtn.backgroundColor = ColorManager.expenseColor()
//        self.incmCntnrLine.isHidden = true
//        self.expCntnrLine.isHidden = false
        self.incmBtn.layer.zPosition = 0
        self.expBtn.layer.zPosition = 1
        //self.recentsTblView.backgroundColor = ColorManager.expenseColorBg()
        DispatchQueue.global().async {
        
        self.reprtViewModel.getReports(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter, tags: self.tags,acntId:self.acntId, type: "2")
            self.reprtViewModel.getDashStat(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter, tag_id: self.tags,account_id:self.acntId)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        //self.crvView.layer.masksToBounds = true
        //self.crvView.layer.cornerRadius = self.crvView.frame.width/2
        self.crvView.borderWidth = 1
        self.crvView.borderColor = ColorManager.incomeColor()
        self.crvView.isHidden = false
        self.crvView.dropShadow(color: UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.5), opacity: 0.5, offSet: CGSize(width: -1, height: 1), radius: 17, scale: true)
        let chart = Circular(percentages: [50,40], colors: [UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0),UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)],aimationType: .animationFanAll,showPercentageStyle: .inward)
        self.addfilterBtn.layer.cornerRadius = self.addfilterBtn.frame.height/2
        self.addfilterBtn.layer.masksToBounds = true
//        var frm: CGRect = self.grphlLoadView.frame
//        chart.frame = CGRect(x: frm.origin.x+50, y: frm.origin.y+20, width: frm.width/1.5, height: frm.height)
//        self.grphlLoadView.addSubview(chart)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.dateBtnSelStylVal = 0
        self.slctdTagIds = []
        self.acntIdAry = []
        self.acntNmeAry = []
        self.tags = ""
        self.acntId = ""
        if(self.tags != "")
        {
            self.filterBtn.backgroundColor = ColorManager.incomeColorTblIcn()
        }
        else
        {
            self.filterBtn.backgroundColor = UIColor.clear
        }
        self.tagsView.isHidden = true
        self.filterFrame.isHidden = true
        self.acntView.isHidden = true
        self.startAnimating()
        self.showingMnthLbl.text = "Showing this month's"
        self.dateFilter = "daterange"
        if(self.incmOrExp == "1")
        {
            self.clkIncome()
//                self.reprtViewModel.getReports(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter, tags: self.tags,acntId:self.acntId, type: "1")
        }
        else
        {
            self.clkExpense()
//                self.reprtViewModel.getReports(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter, tags: self.tags,acntId:self.acntId, type: "2")
        }
        DispatchQueue.global().async {
            self.reprtViewModel.getDashStat(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter,tag_id:self.tags,account_id:self.acntId)
            
//            self.reprtViewModel.getTransactions(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter, tags: self.tags,acntId:self.acntId, pageCnt: 0)
            self.reprtViewModel.getTags(tags:self.switchVal)
        }
        
    }
    @IBAction func applytagFilter()
    {
        if(ReportViewModel.test.joined(separator:",") != "")
        {
            self.filterBtn.backgroundColor = ColorManager.incomeColorTblIcn()
            
            let arrWithoutDuplicates = ReportViewModel.seltagName.reduce([]) {     (a: [String], b: String) -> [String] in     if a.contains(b) {         return a     } else {         return a + [b]     } }
            self.slctdTagLbl.text = arrWithoutDuplicates.joined(separator:",")
        }
        else
        {
            self.slctdTagLbl.text = ""
            self.filterBtn.backgroundColor = UIColor.white
        }
        ReportViewModel.seltagName = []
        print(ReportViewModel.test)
        self.startAnimating()
        self.tags = ReportViewModel.test.joined(separator:",")
        if(self.switchVal == "income")
        {
            self.clkIncome()
        }
        else if(self.switchVal == "expense")
        {
            self.clkExpense()
        }
        DispatchQueue.global().async {
            self.reprtViewModel.getReports(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter, tags: self.tags,acntId:self.acntId, type: self.incmOrExp)
            
            
            self.reprtViewModel.getDashStat(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter, tag_id: self.tags,account_id:self.acntId)
            
        }
        
        self.filterFrame.isHidden = true
        //ReportViewModel.test = []
        
    }
    @IBAction func clkAcnt()
    {
        self.startAnimating()
        addTrnscViewMdlObj.getAcnts(typ: "trnscn")
        self.incmBtn.layer.zPosition = 0
        self.expBtn.layer.zPosition = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            if(UserDefaults.standard.value(forKey: "accountExist") as! String == "0")
            {
                self.stopAnimating()
                Toast(text: "No Accounts added !").show()
                ToastView.appearance().backgroundColor = ColorManager.expenseColor()
                ToastView.appearance().textColor = .white
            }
            else
            {
                self.startAnimating()
                DispatchQueue.global().async {
                    
                    self.reprtViewModel.getAcnts()
                }
                
            }
        })
    }
    @IBAction func closeAcntView()
    {
        self.acntView.isHidden = true
    }
    @IBAction func clickFilter()
    {
        
        
        self.chooseDate()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        var controller: UIViewController = storyboard.instantiateViewController(withIdentifier: "clndrView") as UIViewController
//        //add as a childviewcontroller
//        addChild(controller)
//
//         // Add the child's View as a subview
//         self.clndrFrame.addSubview(controller.view)
//         controller.view.frame = self.clndrFrame.bounds
//         controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//         // tell the childviewcontroller it's contained in it's parent
//        controller.didMove(toParent: self)
        //self.clndrViewFrm.addSubview(controller.view)
    }
    func btnSlcnStyle(_ button:UIButton)
    {
        button.backgroundColor = UIColor.black
        button.setTitleColor(UIColor.white, for: .normal)
    }
    func btnDeSlcnStyle(sender:UIButton)
    {
        sender.backgroundColor = UIColor.white
        sender.setTitleColor(UIColor.black, for: .normal)
    }
    @IBAction func thisMonth()
    {
        self.showingMnthLbl.text = "Showing this month's"
        self.dateBtnSelStylVal = 1
        self.thismnthBtn.backgroundColor = UIColor.black
        self.thismnthBtn.setTitleColor(UIColor.white, for: .normal)
        self.lastmnthBtn.backgroundColor = UIColor.white
        self.lastmnthBtn.setTitleColor(UIColor.black, for: .normal)
        self.rangeBtn.backgroundColor = UIColor.white
        self.rangeBtn.setTitleColor(UIColor.black, for: .normal)
       // self.btnSlcnStyle(self.thismnthBtn)
        DispatchQueue.global().async {
            self.reprtViewModel.pagecount = 0
            let now = Date()
            let thismonth = Calendar.current.date(byAdding: .month, value: 1, to: now)!
            let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: now)
            let startOfMonth = Calendar.current.date(from: comp)!
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateStyle = .medium
            dateFormatter2.timeStyle = .none
            dateFormatter2.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            self.frmDate = dateFormatter2.string(from: startOfMonth)
            self.toDate = dateFormatter2.string(from: now)
            self.reprtViewModel.getReports(fromDate:self.frmDate , toDate:self.toDate ,dateFilter:self.dateFilter, tags: self.tags,acntId:self.acntId, type: self.incmOrExp)
            self.reprtViewModel.getDashStat(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter,tag_id:self.tags,account_id:self.acntId)
            
        }
        
    }
    @IBAction func lastMonth()
    {
        self.showingMnthLbl.text = "Showing last month's"
        self.dateBtnSelStylVal = 2
        self.lastmnthBtn.backgroundColor = UIColor.black
        self.lastmnthBtn.setTitleColor(UIColor.white, for: .normal)
        self.thismnthBtn.backgroundColor = UIColor.white
        self.thismnthBtn.setTitleColor(UIColor.black, for: .normal)
        self.rangeBtn.backgroundColor = UIColor.white
        self.rangeBtn.setTitleColor(UIColor.black, for: .normal)
        DispatchQueue.global().async {
            self.reprtViewModel.pagecount = 0
            let now = Date()
            let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: now)
            let startOfMonth = Calendar.current.date(from: comp)!
            let firstday = Calendar.current.date(byAdding: .month, value: -1, to: startOfMonth)!
            let lastDay = Calendar.current.date(byAdding: .day, value: -1, to: startOfMonth)!
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateStyle = .medium
            dateFormatter2.timeStyle = .none
            dateFormatter2.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            self.frmDate = dateFormatter2.string(from: firstday)
            self.toDate = dateFormatter2.string(from: lastDay)
            self.reprtViewModel.getReports(fromDate:self.frmDate , toDate:self.toDate ,dateFilter:self.dateFilter, tags: self.tags,acntId:self.acntId, type: self.incmOrExp)
            self.reprtViewModel.getDashStat(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter,tag_id:self.tags,account_id:self.acntId)
            
        }
        
    }
    func chooseDate() {
        self.dateBtnSelStylVal = 3
        self.rangeBtn.backgroundColor = UIColor.black
        self.rangeBtn.setTitleColor(UIColor.white, for: .normal)
        self.thismnthBtn.backgroundColor = UIColor.white
        self.thismnthBtn.setTitleColor(UIColor.black, for: .normal)
        self.lastmnthBtn.backgroundColor = UIColor.white
        self.lastmnthBtn.setTitleColor(UIColor.black, for: .normal)
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
        
        //let todaysDate = Date()
        
        //fastisController.initialValue = FastisRange(from:self.frmDate, to: self.toDate)
    fastisController.initialValue = self.dateRnge
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
        
        //fastisController.shortcuts = [customShortcut1,customShortcut2,customShortcut3]
    fastisController.doneHandler = { resultRange in
       // print(resultRange)
        if(resultRange != nil)
        {
            
            self.dateRangeLbl.textColor = ColorManager.incomeColor()
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateStyle = .medium
            dateFormatter2.timeStyle = .none
            dateFormatter2.dateFormat = "d MMM yy"
            //self.dateTxt.text = dateFormatter2.string(from: todaysDate)
            if(dateFormatter2.string(from: resultRange!.fromDate) != dateFormatter2.string(from: resultRange!.toDate))
            {
                self.dateRangeLbl.text = "\(dateFormatter2.string(from: resultRange!.fromDate)) - \(dateFormatter2.string(from: resultRange!.toDate))"
            }
            else
            {
                self.dateRangeLbl.text = dateFormatter2.string(from: resultRange!.fromDate)
            }
            self.dateRnge = resultRange!
            self.startAnimating()
            self.dateFilter = "daterange"
            self.frmDate = "\(resultRange!.fromDate)"
            self.toDate = "\(resultRange!.toDate)"
            DispatchQueue.global().async {
                self.reprtViewModel.getReports(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter, tags: self.tags,acntId:self.acntId, type: self.incmOrExp)
                self.reprtViewModel.getDashStat(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter,tag_id:self.tags,account_id:self.acntId)
//                self.reprtViewModel.getTransactions(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter, tags: self.tags,acntId:self.acntId, pageCnt: 0)
            }
            let dateFormatter3 = DateFormatter()
            dateFormatter3.dateStyle = .medium
            dateFormatter3.timeStyle = .none
            dateFormatter3.dateFormat = "d MMM yy"
            self.showingMnthLbl.text = "Showing \(dateFormatter3.string(from: resultRange!.fromDate)) - \(dateFormatter3.string(from: resultRange!.toDate))"
        }
        else
        {
            self.dateFilter = ""
            self.frmDate = ""
            self.toDate = ""
            
            self.dateRangeLbl.textColor = UIColor.gray
            self.dateRangeLbl.text = "Select Date"
           // fastisController.initialValue = nil
            self.dateRnge = FastisRange(from: Date(), to: Date())
            DispatchQueue.global().async {
                self.reprtViewModel.getDashStat(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter,tag_id:self.tags,account_id:self.acntId)
//                self.reprtViewModel.getTransactions(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter, tags: self.tags,acntId:self.acntId, pageCnt: 00)
            }
        }
    }
    fastisController.present(above: self)
        }
    @IBAction func clickTag()
    {
        if(incmOrExp == "1")
        {
            self.switchVal = "income"
            self.tagSwitch.isOn = false
        }
        else if(incmOrExp == "2")
        {
            self.tagSwitch.isOn = true
            self.switchVal = "expense"
        }
        self.incmBtn.layer.zPosition = 0
        self.expBtn.layer.zPosition = 0
        self.tagsView.isHidden = false
        self.filterFrame.isHidden = false
        self.clndrFrame.isHidden = false
        self.startAnimating()
        DispatchQueue.global().async {
            self.reprtViewModel.getTags(tags: self.switchVal)
            //self.reprtViewModel.getDfltTags(tags: self.switchVal)
            
        }
        
    }
    @IBAction func closeFilterview()
    {
//        UIView.animate(withDuration: 0.5, animations: {
//            // Change the top constraint to bring the view into the visible area
//            self.CategoryGridView.transform = CGAffineTransform(translationX: 0, y: 0+self.CategoryGridView.frame.height+60)
//            //self.ctgryVieBtmCnstrt.constant = -350
//        })
        self.ctgryVieBtmCnstrt.constant = -610
        UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { _ in
                    print("Animation complete")
                    self.ctgryBgBlckLbl.isHidden = true
                })
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view!.isDescendant(of: self.acntsTblView) == true || touch.view!.isDescendant(of: self.recentsTblView) == true || touch.view!.isDescendant(of: self.tagsClnView) == true || touch.view!.isDescendant(of: self.chartView) == true{

            return false
         }
    
        else
        {
            return true
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.recentsTblView)
        {
            return self.incExpArry.count
        }
        else
        {
            return ReportViewModel.acntsMdlArry.count+1
        }
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "listRecent", for: indexPath) as! recentTblViewCell
           if(tableView == self.recentsTblView)
           {
               
               cell.crvdLbl.cornerRadius = 11
               //var ordList = orderLst()
               
               let str = self.incExpNameArry[indexPath.row] as! String
               cell.title.text = str
               cell.time.text = self.incExpTimeArry[indexPath.row] as! String
               if(self.incExpArry[indexPath.row] as! String == "1")
               {
                   cell.Icn.image = UIImage(named: "IncmTbl_Icn")
                   cell.crvdLbl.backgroundColor = UIColor(red: 242/255, green: 238/255, blue: 255/255, alpha: 1.0)
                   cell.amount.textColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
                   cell.amount.text = "+$\(self.incExpAmntArry[indexPath.row] as! String)"
               }
               else
               {
                   
                   cell.Icn.image = UIImage(named: "expTbl_Icn")
                   cell.crvdLbl.backgroundColor = UIColor(red: 254/255, green: 232/255, blue: 232/255, alpha: 1.0)
                   cell.amount.textColor = UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
                   cell.amount.text = "-$\(self.incExpAmntArry[indexPath.row] as! String)"
               }
           }
           else
           {
               if(indexPath.row == 0)
               {
                   cell.title.text = "All accounts"
                   //cell.time.text = "\(crcyCode) \(self.acntMdlArry[indexPath.row].current_balance!)"
                   var tagname = "A"
                   cell.shortNme.text = "\(tagname.uppercased())"
                   if(self.acntId == "")
                   {
                       cell.accessoryType = .checkmark
                   }
                   else
                   {
                       cell.accessoryType = .none
                   }
               }
               else
               {
                   let str = ReportViewModel.acntsMdlArry[indexPath.row-1]
                   cell.title.text = str.account_name
                   var tagname = str.account_name!.prefix(1)
                   cell.shortNme.text = "\(tagname.uppercased())"
                   if(str.account_id == self.acntId)
                   {
                       cell.accessoryType = .checkmark
                   }
                   else
                   {
                       cell.accessoryType = .none
                   }
               }
           }
        //cell.title.text = str
        //cell.time.text = str
        //cell.amount.text = str
        
        return cell
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if(indexPath.row == 0)
        {
            self.startAnimating()
            
            self.acntId = ""
            self.acntName = "All accounts"
            DispatchQueue.global().async {
                self.reprtViewModel.pagecount = 0
                
                self.reprtViewModel.getReports(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter, tags: self.tags,acntId:self.acntId, type: self.incmOrExp)
                self.reprtViewModel.getDashStat(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter,tag_id:self.tags,account_id:self.acntId)
                
            }
            self.closeAcntView()
        }
        else
        {
            self.startAnimating()
            let str = ReportViewModel.acntsMdlArry[indexPath.row-1]
            self.acntId = str.account_id!
            self.acntName = str.account_name!
            DispatchQueue.global().async {
                self.reprtViewModel.getReports(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter, tags: self.tags,acntId:self.acntId, type: self.incmOrExp)
                self.reprtViewModel.getDashStat(fromDate: self.frmDate, toDate: self.toDate,dateFilter:self.dateFilter,tag_id:self.tags,account_id:self.acntId)
                
                
            }
            
            self.closeAcntView()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300/3, height: 300/3)
    }
    
    fileprivate func createPlainTextLayer() -> PiePlainTextLayer {
        
        let textLayerSettings = PiePlainTextLayerSettings()
        textLayerSettings.viewRadius = 55
        textLayerSettings.hideOnOverflow = true
        textLayerSettings.label.font = UIFont.systemFont(ofSize: 8)
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        textLayerSettings.label.textGenerator = {slice in
            return formatter.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
        }
        
        let textLayer = PiePlainTextLayer()
        textLayer.settings = textLayerSettings
        return textLayer
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
//extension ReportViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.tagsClnView.frame.width-20/3, height: self.tagsClnView.frame.width-20/3)
//    }
//}
