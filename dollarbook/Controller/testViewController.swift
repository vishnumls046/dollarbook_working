//
//  dashboardViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 30/08/22.
//

import UIKit
import NVActivityIndicatorView
import Toaster
//import RingPieChart
protocol dashUpdateUIProt:AnyObject
{
    func incExpTotUpdt(val:DashboardTotalModel)
    func dashStatUpdt(val:dashStatModel)
    func graphValUpdt(IncVals:Double,ExpVals:Double )
    func recentTblUpdt(trnsCnt:String)
    func tagsClnUpdt(tagsCnt:String)
    func updtAcntTbl()
    func editRedrct()
    func deleteAlert()
    func alerts(alrtStr:String)
}
protocol tagProt
{
    func updtDefTags(incTags:[String],expnsTags:[String])
}
class testViewController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate,dashUpdateUIProt,tagProt,NVActivityIndicatorViewable {
    func dashStatUpdt(val: dashStatModel) {
        DispatchQueue.main.async {
            let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
            let crcyCode = crncy.htmlToString
            
            
            self.totBalance.text = "\(crcyCode) \(val.current_balance!)"
            //self.totBalance.textColor = UIColor.init(named: "ModeColor")
            var inctot = "\(crcyCode) \(val.total_income!)"
            if let index = (inctot.range(of: ".")?.lowerBound)
            {
                self.totIncLbl.text = String(inctot.prefix(upTo: index))
              //let beforeEqualsToContainingSymbol = String(inctot.prefix(upTo: index))
            }
            else
            {
                self.totIncLbl.text = "\(crcyCode) \(val.total_income!)"
                print("Test")
            }
            var exptot = "\(crcyCode) \(val.total_expense!)"
            if let index = (exptot.range(of: ".")?.lowerBound)
            {
                self.totExpLbl.text = String(exptot.prefix(upTo: index))
              //let beforeEqualsToContainingSymbol = String(inctot.prefix(upTo: index))
            }
            else
            {
                self.totExpLbl.text = "\(crcyCode) \(val.total_expense!)"
                print("Test")
            }
            
            //self.totIncLbl.text = "\(crcyCode) \(val.total_income!)"
            //self.totExpLbl.text = "\(crcyCode) \(val.total_expense!)"
        }
    }
    func deleteAlert()
    {
        DispatchQueue.main.async {
            var refreshAlert = UIAlertController(title: "DollarBook", message: "Do you want to delete transaction ?", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                self.startAnimating()
                DispatchQueue.global().async {
                    self.dashViewModel.Dlt()
                }
                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            self.present(refreshAlert, animated: true, completion: nil)
        }
    }
    func alerts(alrtStr:String)
    {
        DispatchQueue.main.async {
            self.stopAnimating()
            let alert = UIAlertController(title: "Dollar Book", message: alrtStr, preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) in
                DispatchQueue.global().async {
                    
                    self.dashViewModel.getTransactions(acntId: "", pageCnt: 0,frmDate: "",toDate: "")
                    self.dashViewModel.getDashStat()
                    self.dashViewModel.getIncExpTotal()
                }
            }))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    func updtAcntTbl()
    {
        DispatchQueue.main.async {
            self.acntsTblView.reloadData()
            //self.acntView.isHidden = false
        }
    }
    
    
    func updtDefTags(incTags: [String],expnsTags:[String]) {
        UserDefaults.standard.set(incTags, forKey: "incDefltTags")
        UserDefaults.standard.set(expnsTags, forKey: "expDefltTags")
    }
    
    func tagsClnUpdt(tagsCnt:String) {
        DispatchQueue.main.async {
            if(tagsCnt == "0")
            {
                self.noTagsLbl.isHidden = false
                self.noTagsLbl.text = "No Tags Found"
            }
            else
            {
                self.noTagsLbl.isHidden = true
                self.tagsClnView.reloadData()
            }
        }
    }
    
    func recentTblUpdt(trnsCnt:String) {
        DispatchQueue.main.async {
            self.stopAnimating()
            if(trnsCnt == "0")
            {
                self.recentsTblView.isHidden = true
                self.noTrnscnLbl.isHidden = false
                self.noTrnscnLbl.text = "No Transactions found"
            }
            else
            {
                self.recentsTblView.isHidden = false
                self.noTrnscnLbl.isHidden = true
                self.recentsTblView.reloadData()
            }
        }
    }
    
    func graphValUpdt(IncVals: Double, ExpVals: Double) {
        print(IncVals)
        DispatchQueue.main.async {
            if(ExpVals < 4)
            {
                let chart = Circular(percentages: [IncVals,ExpVals], colors: [UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0),UIColor.clear],aimationType: .animationFanAll,showPercentageStyle: .inward)
                let frm: CGRect = self.grphlLoadView.frame
                //chart.frame = CGRect(x: 35, y: 50, width: 250, height: 250)
                chart.frame = CGRect(x: frm.origin.x, y: frm.origin.y, width: frm.width/1.15, height: frm.height)
                self.grphlLoadView.addSubview(chart)
            }
            else
            {
                let chart = Circular(percentages: [IncVals,ExpVals], colors: [UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0),UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)],aimationType: .animationFanAll,showPercentageStyle: .inward)
                let frm: CGRect = self.grphlLoadView.frame
                //chart.frame = CGRect(x: 35, y: 50, width: 250, height: 250)
                chart.frame = CGRect(x: frm.origin.x, y: frm.origin.y, width: frm.width/1.15, height: frm.height)
                self.grphlLoadView.addSubview(chart)
            }
        }
    }
    var updtPrfvwMdl = updateProfileViewModel()
    var addDataViewMdlObj = AddDataViewModel()
    @IBOutlet weak var acntView:UIView!
    @IBOutlet weak var totBalance:UILabel!
    @IBOutlet weak var noTagsLbl:UILabel!
    @IBOutlet weak var noTrnscnLbl:UILabel!
    @IBOutlet weak var userName:UILabel!
    @IBOutlet weak var totIncLbl:UILabel!
    @IBOutlet weak var totExpLbl:UILabel!
    @IBOutlet weak var incmeBg:UILabel!
    @IBOutlet weak var expnsBg:UILabel!
    @IBOutlet weak var incTileBg:UIView!
    @IBOutlet weak var expTileBg:UIView!
    @IBOutlet weak var grphView:UIView!
    @IBOutlet weak var ddlBtn:UIButton!
    @IBOutlet weak var filterBtn:UIButton!
    @IBOutlet weak var acntClkBtn:UIButton!
    @IBOutlet weak var grphlLoadView:UIView!
    @IBOutlet weak var incmBubble:UILabel!
    @IBOutlet weak var expnseBubble:UILabel!
    @IBOutlet weak var tagsClnView:UICollectionView!
    @IBOutlet weak var recentsTblView:UITableView!
    @IBOutlet weak var acntsTblView:UITableView!
    @IBOutlet weak var grphlLoadCrv:UILabel!
    @IBOutlet weak var acntDispLbl:UILabel!
    @IBOutlet weak var crntMonth:UILabel!
    
    var from = ""
    var to = ""
    var dashViewModel = DashboardViewModel()
    var editTrnsViewMdl = editTrnscnViewModel()
    var tagNameArry = NSMutableArray(array: ["Cafe", "Grocery", "Taxi","Loan","Fees", "Taxi","Loan","Fees"])
    
    var incExpNameArry = NSMutableArray(array: ["Salary", "Interest", "Bakery","Shopping","Medicine", "Divident","Electricity bill","Interest"])
    var incExpArry = NSMutableArray(array: ["1", "1", "2","2","2", "1","2","1"])
    var incExpTimeArry = NSMutableArray(array: ["2 Hours ago ", "5 Hours ago", "A day ago","30/Aug/2022","30/Aug/2022", "29/Aug/2022","29/Aug/2022","28/Aug/2022"])
    var incExpAmntArry = NSMutableArray(array: ["1000", "3000", "500","456","700", "200","1200","1850"])
    //var crncyNmeArry = NSMutableArray(array: ["Euro", "INR", "USD","GBP","RYL","SND","YEN"])
    func incExpTotUpdt(val:DashboardTotalModel) {
        //self.totIncLbl.text = "\(val.totalMonthlyIncome!)"
        //self.totExpLbl.text = "\(val.totalMonthlyExpense!)"
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
        if(self.acntView.isHidden == false)
       {
            self.acntView.isHidden = true
            
       }
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        DispatchQueue.global().async {
            self.updtPrfvwMdl.getUserProfile()
            self.dashViewModel.getDashStat()
            self.dashViewModel.getIncExpTotal()
            self.addDataViewMdlObj.getTags() // For filling income and expense tags in add Page
            self.dashViewModel.getTags()
            let currentDate = Date()
           var dateComponent = DateComponents()
            //dateComponent.month = monthsToAdd
           let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
           let dateFormatter1 = DateFormatter()
           dateFormatter1.dateFormat = "d MMM yy"
            let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: currentDate)
            let startOfMonth = Calendar.current.date(from: comp)!
            print(dateFormatter1.string(from: startOfMonth))
            
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "yyyy-MM-dd"
            self.from = "\(dateFormatter2.string(from: startOfMonth))"
            self.to = "\(dateFormatter2.string(from: currentDate))"
            self.dashViewModel.getTransactions(acntId: "", pageCnt: 0,frmDate: "",toDate: "")
        }
    }
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(testViewController.methodOfReceivedNotification(notification:)), name: Notification.Name("foreground"), object: nil)
        
        UserDefaults.standard.set("1", forKey: "used")
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
        self.acntView.isHidden = true
        
        self.acntDispLbl.text = "All accounts"
        updtPrfvwMdl.dashDlgt = self
        addDataViewMdlObj.appDlgt = self
        dashViewModel.dashDlgt = self
        recentsTblView.dataSource = dashViewModel
        recentsTblView.delegate = dashViewModel
        tagsClnView.dataSource = dashViewModel
        acntsTblView.dataSource = self
        acntsTblView.delegate = self
        self.acntClkBtn.cornerRadius = 9
        self.acntClkBtn.borderColor = UIColor(red: 186/255, green: 178/255, blue: 210/255, alpha: 1.0)
        self.acntClkBtn.borderWidth = 1
        
        super.viewDidLoad()
        let todaysDate = Date()
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateStyle = .medium
        dateFormatter2.timeStyle = .none
        dateFormatter2.dateFormat = "MMMM, yyyy"
        self.crntMonth.text = dateFormatter2.string(from: todaysDate)
        
        
        self.grphlLoadCrv.isHidden = true
        self.incmBubble.cornerRadius = self.incmBubble.frame.height/2
        self.expnseBubble.cornerRadius = self.expnseBubble.frame.height/2
        
        self.incTileBg.cornerRadius = 17
        self.incTileBg.borderColor = UIColor(red: 211/255, green: 221/255, blue: 230/255, alpha: 1.0)
        self.incTileBg.shadowRadius = 3
        self.incTileBg.borderWidth = 1
        self.expTileBg.cornerRadius = 17
        self.expTileBg.borderColor = UIColor(red: 211/255, green: 221/255, blue: 230/255, alpha: 1.0)
        self.expTileBg.borderWidth = 1
        self.incTileBg.dropShadow(color: UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.7), opacity: 0.4, offSet: CGSize(width: -1, height: 1), radius: 17, scale: true)
        self.expTileBg.dropShadow(color: UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.7), opacity: 0.4, offSet: CGSize(width: -1, height: 1), radius: 17, scale: true)
        
        self.tagsClnView.dropShadow(color: UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.1), opacity: 0.1, offSet: CGSize(width: -1, height: 1), radius: 17, scale: true)
        
        self.grphView.cornerRadius = 17
        self.grphView.borderColor = UIColor(red: 211/255, green: 221/255, blue: 230/255, alpha: 1.0)
        self.grphView.borderWidth = 1
        //self.grphView.dropShadow(color: UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 0.3), opacity: 0.3, offSet: CGSize(width: -1, height: 1), radius: 17, scale: true)
        
        self.ddlBtn.cornerRadius = 9
        self.ddlBtn.borderColor = UIColor(red: 186/255, green: 178/255, blue: 210/255, alpha: 1.0)
        self.ddlBtn.borderWidth = 1
        self.filterBtn.cornerRadius = 9
        self.filterBtn.borderColor = UIColor(red: 186/255, green: 178/255, blue: 210/255, alpha: 1.0)
        self.filterBtn.borderWidth = 1
        
        
        
         
        
//        let chart = Circular(percentages: [42,27,18,13], colors: [.blue,.purple,.orange,.red],aimationType: .animationFadeIn,showPercentageStyle: .inward)
//        chart.frame = CGRect(x: 50, y: 50, width: 250, height: 250)
//         self.view .addSubview(chart)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        self.incmeBg.cornerRadius = self.incmeBg.frame.height/2
        self.expnsBg.cornerRadius = self.incmeBg.frame.height/2
        self.grphlLoadCrv.layer.masksToBounds = true
        self.grphlLoadCrv.layer.cornerRadius = self.grphlLoadCrv.frame.width/2
        
        self.grphlLoadCrv.isHidden = false
        
        //self.grphlLoadCrv.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        
        
    }
    @IBAction func clkAcnt()
    {
        if(UserDefaults.standard.value(forKey: "accountExist") as! String == "0")
        {
            Toast(text: "No Accounts added !").show()
            ToastView.appearance().backgroundColor = ColorManager.expenseColor()
            ToastView.appearance().textColor = .white
        }
        else
        {
            self.acntView.isHidden = false
            DispatchQueue.global().async {
                
                self.dashViewModel.getAcnts()
            }
        }
    }
    @IBAction func closeAcntView()
    {
        self.acntView.isHidden = true
    }
    func editRedrct()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "trnscnDet")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40), type: NVActivityIndicatorType.audioEqualizer, color: ColorManager.incomeColor(), padding: nil)
        self.startAnimating()
        self.userName.text = UserDefaults.standard.value(forKey: "full_name") as? String
        DispatchQueue.global().async {
            self.updtPrfvwMdl.getUserProfile()
            self.dashViewModel.getDashStat()
            self.dashViewModel.getIncExpTotal()
            self.addDataViewMdlObj.getTags() // For filling income and expense tags in add Page
            self.dashViewModel.getTags()
            let currentDate = Date()
           var dateComponent = DateComponents()
            //dateComponent.month = monthsToAdd
           let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
           let dateFormatter1 = DateFormatter()
           dateFormatter1.dateFormat = "d MMM yy"
            let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: currentDate)
            let startOfMonth = Calendar.current.date(from: comp)!
            print(dateFormatter1.string(from: startOfMonth))
            
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "yyyy-MM-dd"
            self.from = "\(dateFormatter2.string(from: startOfMonth))"
            self.to = "\(dateFormatter2.string(from: currentDate))"
            self.dashViewModel.getTransactions(acntId: "", pageCnt: 0,frmDate: "",toDate: "")
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagNameArry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crncyCell", for: indexPath) as! tagsViewCell
        let mydata = tagNameArry[indexPath.item]
        //cell.bgLbl.cornerRadius = 8
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        cell.tagshort.cornerRadius = cell.tagshort.frame.height/2
        cell.tagName.text = mydata as? String
        
        //cell.title.text = mydata as? String
        //cell.tagshort.text = "A"
        //cell.bgLbl.cornerRadius = 8
//        cell.bgLbl.layer.cornerRadius = 27
//        cell.bgLbl.layer.masksToBounds = true
//        cell.bgLbl.layer.borderColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0).cgColor
//        cell.bgLbl.layer.borderWidth = 1.0
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
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view!.isDescendant(of: self.recentsTblView) == true || touch.view!.isDescendant(of: self.acntsTblView) == true {
            
            return false
         }
        else
        {
            return true
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

extension testViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DashboardViewModel.acntMdlArry.count+1
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
           let cell = tableView.dequeueReusableCell(withIdentifier: "listRecent", for: indexPath) as! recentTblViewCell
           //cell.crvdLbl.cornerRadius = 11
        //var ordList = orderLst()
           if(indexPath.row == 0)
           {
               cell.title.text = "All accounts"
               //cell.time.text = "\(crcyCode) \(self.acntMdlArry[indexPath.row].current_balance!)"
               var tagname = "A"
               cell.shortNme.text = "\(tagname.uppercased())"
           }
           else
           {
               let str = DashboardViewModel.acntMdlArry[indexPath.row-1]
               cell.title.text = str.account_name
               //cell.time.text = "\(crcyCode) \(self.acntMdlArry[indexPath.row].current_balance!)"
               var tagname = str.account_name!.prefix(1)
               cell.shortNme.text = "\(tagname.uppercased())"
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
            self.acntDispLbl.text = "All accounts"
            DispatchQueue.global().async {
                self.dashViewModel.getTransactions(acntId: "", pageCnt: 0,frmDate: "",toDate: "")
            }
            self.closeAcntView()
        }
        else
        {
            let str = DashboardViewModel.acntMdlArry[indexPath.row-1]
            self.acntDispLbl.text = str.account_name!
            self.startAnimating()
            DispatchQueue.global().async {
                self.dashViewModel.getTransactions(acntId: str.account_id!, pageCnt: 0,frmDate: "",toDate: "")
            }
            self.closeAcntView()
        }
    }
}
