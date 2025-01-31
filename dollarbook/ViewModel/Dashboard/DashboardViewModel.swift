//
//  DashboardTotalViewModel.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 12/10/22.
//

import Foundation
import Alamofire
import UIKit
import Kingfisher

class DashboardViewModel:NSObject
{
    var pagecount = 0
    var isLastPage = 0
    static var trnscTyp:String = ""
    static var acntMdlArry:[Accounts] = []
    var tagArry:[Tags] = []
    var transArry = [Transactions]()
    var dashDlgt:dashUpdateUIProt?
    var  plyrId:String = ""
    var  acntId:String = ""
    var  frmDte = ""
    var  toDte = ""
    func getDashStat()
    {
        
        AF.request(APImanager.DashStat(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let Response  = try
                    JSONDecoder().decode(dashStatModel.self, from: data)
                    DispatchQueue.main.async {
                        self.dashDlgt?.dashStatUpdt(val: Response)
                    }
                    print(Response)
                     
                    
                }
                catch let err{
                    print(err)
                }
            }
        }
    }
    func getIncExpTotal()
    {
        AF.request(APImanager.DashTotalAPI(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let Response  = try
                    JSONDecoder().decode(DashboardTotalModel.self, from: data)
                    self.dashDlgt?.incExpTotUpdt(val: Response)
                    print(Response)
                    var tot =  Double(Response.totalMonthlyIncome!)! + Double(Response.totalMonthlyExpense!)!
                    var IncPerc = (Double(Response.totalMonthlyIncome!)!) / tot * 100
                    var ExpPerc = (Double(Response.totalMonthlyExpense!)!) / tot * 100
//                    if(Response.totalMonthlyIncome! == "0")
//                    {
//                        self.dashDlgt?.graphValUpdt(IncVals: 50, ExpVals: 50)
//                    }
//                    else
//                    {
//                        self.dashDlgt?.graphValUpdt(IncVals: Double(IncPerc), ExpVals: Double(ExpPerc))
//                    }
                    if(tot>0)
                    {
                        var IncPerc = (Double(Response.totalMonthlyIncome!)!) / tot * 100
                        var ExpPerc = (Double(Response.totalMonthlyExpense!)!) / tot * 100
                        DispatchQueue.main.async {
                            self.dashDlgt?.graphValUpdt(IncVals: Double(IncPerc), ExpVals: Double(ExpPerc))
                        }
                    }
                    else
                    {
                        var IncPerc = 50
                        var ExpPerc = 50
                        DispatchQueue.main.async {
                            self.dashDlgt?.graphValUpdt(IncVals: Double(IncPerc), ExpVals: Double(ExpPerc))
                        }
                    }
                }
                catch let err{
                    print(err)
                }
            }
        }
    }
    
    
    func getTags()
    {
        AF.request(APImanager.GetTagsAPI(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let TagResponse  = try
                    JSONDecoder().decode(TagsModel.self, from: data)
                    print(TagResponse.tags!)
                    self.tagArry = []
                    for anItem in TagResponse.tags! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        self.tagArry.append(anItem)
                        
                    // do something with personName and personID
                    }
                    
                    DispatchQueue.main.async {
                        self.dashDlgt?.tagsClnUpdt(tagsCnt:"1")
                    }
                }
                catch let err{
                    DispatchQueue.main.async {
                        self.dashDlgt?.tagsClnUpdt(tagsCnt:"0")
                    }
                    print(err)
                }
            }
        }
        
    }
    
    func getTransactions(acntId:String, pageCnt:Int,frmDate:String,toDate:String)
    {
        self.acntId = acntId
        self.pagecount = pageCnt
        self.frmDte = frmDate
        self.toDte = toDate
        if(UserDefaults.standard.value(forKey: "playerId") != nil)
        {
            plyrId =  UserDefaults.standard.value(forKey: "playerId")! as! String
        }
        else
        {
             plyrId = ""
        }
        AF.request(APImanager.GetTransactions(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"account_id":acntId, "player_id":self.plyrId,"page_no":self.pagecount,"start_date":frmDate,"end_date":toDate] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let TagResponse  = try
                    JSONDecoder().decode(TransactionsModel.self, from: data)
                    print(TagResponse.transactions!)
                    if(self.pagecount == 0)
                    {
                        self.transArry = []
                    }
                    for anItem in TagResponse.transactions! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        self.transArry.append(anItem)
                        
                    // do something with personName and personID
                    }
                    if(TagResponse.isLastpage != nil)
                    {
                        self.isLastPage = TagResponse.isLastpage!
                    }
                        if self.isLastPage == 0{
                            self.pagecount=self.pagecount+1
                        }
                    DispatchQueue.main.async {
                        self.dashDlgt?.recentTblUpdt(trnsCnt:"\(self.transArry.count)")
                    }
                }
                catch let err{
                    DispatchQueue.main.async {
                        self.dashDlgt?.recentTblUpdt(trnsCnt:"\(self.transArry.count)")
                    }
                    print(err)
                }
            }
        }
        
    }
    func getAcnts()
    {
        AF.request(APImanager.GetAccounts(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!],encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            
            response in
            if let data = response.data
            {
                do{
                    
                    DashboardViewModel.acntMdlArry = []
                    let AcntsResponse  = try
                    JSONDecoder().decode(AccountsModel.self, from: data)
                    print(AcntsResponse.accounts!)
                    struct TaylorFan {
                        static var favoriteSong = "Look What You Made Me Do"

                        
                        
                        var account_id : String?
                        var user_id : String?
                        var account_name : String?
                        var starting_balance : String?
                        var added_date : String?
                        var bank_status : String?
                        var banks_cc : String?
                        var sort_order : String?
                        var current_balance : String
                    }
                    let allAcnts = TaylorFan(account_id: "", account_name: "All Accounts",starting_balance : "",added_date:"",bank_status:"",banks_cc:"",sort_order:"",current_balance:"" )
                    //DashboardViewModel.acntMdlArry.append(anItem)
                    for anItem in AcntsResponse.accounts! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        
                        DashboardViewModel.acntMdlArry.append(anItem)
                        
                    // do something with personName and personID
                    }
                    self.dashDlgt?.updtAcntTbl()
                }
                catch let err{
                    print(err)
                }
            }
        }
        
        
    }
}
extension DashboardViewModel: UITableViewDataSource,UITableViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height + 15
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            if self.isLastPage == 0{
                self.getTransactions(acntId: self.acntId, pageCnt: self.pagecount,frmDate:self.frmDte,toDate:self.toDte)
//                            self.fetchlist()
                        }
            print(" you reached end of the table")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.transArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //var frmtdate = date!.timeAgoDisplay()
        //cell.time.text = "\(frmtdate)"
        if(self.transArry[indexPath.row].transactionType! == "1")
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "listRecent", for: indexPath) as! recentTblViewCell
            cell.title.text = "\(self.transArry[indexPath.row].transactionText!)"
            let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
            let crcyCode = crncy.htmlToString
            cell.amount.text = "+ \(crcyCode) \(self.transArry[indexPath.row].transactionAmount!)"
            
            var addDate = self.transArry[indexPath.row].transactionAddedDate!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            // Convert String to Date
            let date = dateFormatter.date(from: addDate)
            var frmtdate = date!.timeAgoDisplay()
            cell.time.text = "\(frmtdate)"
            //cell.Icn.image = UIImage(named: "IncmTbl_Icn")
            if let url = URL(string: self.transArry[indexPath.row].iconUrl!) {
                let processor = OverlayImageProcessor(overlay: UIColor(hex: self.transArry[indexPath.row].iconClr!), fraction: 0.1)
                
                        // Load the image with Kingfisher and apply the tint
//                           self.ctgryIcon.kf.setImage(
//                                       with: url)
                cell.Icn.kf.setImage(with: url, options: [.processor(processor)])
                
                    }
            cell.crvdLbl.backgroundColor = UIColor(hex: self.transArry[indexPath.row].iconClr!)
            cell.crvdLbl.alpha = 0.2
            cell.crvdLbl.layer.cornerRadius = 11
            cell.crvdLbl.layer.masksToBounds = true
//            cell.frmAcntLbl.isHidden = true
//            cell.toAcntLbl.isHidden = true
//            cell.trnsfrIcn.isHidden = true
            
            cell.amount.textColor = ColorManager.incomeColor()
            return cell
        }
        else if(self.transArry[indexPath.row].transactionType! == "2")
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "listRecent", for: indexPath) as! recentTblViewCell
            cell.title.text = "\(self.transArry[indexPath.row].transactionText!)"
            let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
            let crcyCode = crncy.htmlToString
            cell.amount.text = "- \(crcyCode) \(self.transArry[indexPath.row].transactionAmount!)"
            
            var addDate = self.transArry[indexPath.row].transactionAddedDate!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            // Convert String to Date
            let date = dateFormatter.date(from: addDate)
            var frmtdate = date!.timeAgoDisplay()
            cell.time.text = "\(frmtdate)"
            if let url = URL(string: self.transArry[indexPath.row].iconUrl!) {
                let processor = OverlayImageProcessor(overlay: UIColor(hex: self.transArry[indexPath.row].iconClr!), fraction: 0.1)
                
                        // Load the image with Kingfisher and apply the tint
//                           self.ctgryIcon.kf.setImage(
//                                       with: url)
                cell.Icn.kf.setImage(with: url, options: [.processor(processor)])
                
                    }
            //cell.Icn.image = UIImage(named: "expTbl_Icn")
            //cell.crvdLbl.backgroundColor = UIColor(red: 255/255, green: 233/255, blue: 233/255, alpha: 1.0)
            cell.crvdLbl.backgroundColor = UIColor(hex: self.transArry[indexPath.row].iconClr!)
            cell.crvdLbl.alpha = 0.2
            cell.crvdLbl.layer.cornerRadius = 11
            cell.crvdLbl.layer.masksToBounds = true
            cell.amount.textColor = ColorManager.expenseColor()
//            cell.frmAcntLbl.isHidden = true
//            cell.toAcntLbl.isHidden = true
//            cell.trnsfrIcn.isHidden = true
            return cell
        }
        else
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "listTrnsfr", for: indexPath) as! recentTblViewCell
            cell.title.text = "\(self.transArry[indexPath.row].transactionText!)"
            let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
            let crcyCode = crncy.htmlToString
            cell.amount.text = "\(crcyCode) \(self.transArry[indexPath.row].transactionAmount!)"
            
            var addDate = self.transArry[indexPath.row].transactionAddedDate!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            // Convert String to Date
            let date = dateFormatter.date(from: addDate)
            var frmtdate = date!.timeAgoDisplay()
            cell.time.text = "\(frmtdate)"
            //cell.Icn.image = UIImage(named: "transferIcn")
//            cell.crvdLbl.backgroundColor = .systemGreen
//            cell.crvdLbl.layer.cornerRadius = 11
//            cell.crvdLbl.layer.masksToBounds = true
            cell.amount.textColor = .systemGreen
            cell.frmAcntLbl.text = self.transArry[indexPath.row].frmAcnName!
            cell.toAcntLbl.text = self.transArry[indexPath.row].toAcnName!
//            cell.frmAcntLbl.isHidden = false
//            cell.toAcntLbl.isHidden = false
//            cell.trnsfrIcn.isHidden = false
            return cell
        }
            
        
    }
    private func handleMarkAsFavourite(inx:IndexPath) {
//        self.acntMngDlgt?.editAcnt(acntNme:self.acntMdlArry[inx.row].account_name!,intlAmnt:self.acntMdlArry[inx.row].starting_balance!,acntId:self.acntMdlArry[inx.row].account_id!)
        print("Edit \(inx.row)")
        acntReportViewModel.sltdTrnsId = self.transArry[inx.row].transactionId!
        DashboardViewModel.trnscTyp = self.transArry[inx.row].transactionType!
        self.dashDlgt?.editRedrct()
    }
    private func handleDelete(inx:IndexPath) {
//        self.acntMngDlgt?.editAcnt(acntNme:self.acntMdlArry[inx.row].account_name!,intlAmnt:self.acntMdlArry[inx.row].starting_balance!,acntId:self.acntMdlArry[inx.row].account_id!)
        print("Edit \(inx.row)")
        
        acntReportViewModel.sltdTrnsId = self.transArry[inx.row].transactionId!
        dashDlgt?.deleteAlert()
        
        
    }
    func Dlt()
    {
        AF.request(APImanager.DeleteTrnscn(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"transaction_id":acntReportViewModel.sltdTrnsId] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let acntResponse  = try
                    JSONDecoder().decode(AddDataModel.self, from: data)
                    print(acntResponse.addresult!.message!)
//                    for anItem in acntResponse.tags! as Array {
//
//                        self.tagArry.append(anItem.tagName!)
//
//                    // do something with personName and personID
//                    }
                    
                        
                            DispatchQueue.main.async {
                                self.dashDlgt?.alerts(alrtStr: acntResponse.addresult!.message!)
                            }
                        
                        //self.editViewDlgt?.alerts(alrtStr: acntResponse.addresult!.message!)
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
//                            self.editViewDlgt?.BackAfterDataAdd()
//                        })
                        //self.addViewDlgt?.closeSetAcntView()
                        
                    
                    
                }
                catch let err{
                    print(err)
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.handleMarkAsFavourite(inx:indexPath)
                                            completionHandler(true)
        }
        let delete = UIContextualAction(style: .normal,
                                        title: "Delete") { [weak self] (delete, view, completionHandler) in
            self?.handleDelete(inx:indexPath)
                                            completionHandler(true)
        }
        delete.backgroundColor = UIColor.red
        if(self.transArry[indexPath.row].transactionType! == "1")
        {
            action.backgroundColor = ColorManager.incomeColor()
        }
        else if(self.transArry[indexPath.row].transactionType! == "2")
        {
            action.backgroundColor = ColorManager.expenseColor()
        }
        else
        {
            action.backgroundColor = ColorManager.transferColor()
        }
        
        return UISwipeActionsConfiguration(actions: [action,delete])
    }
}
extension DashboardViewModel:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagArry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crncyCell", for: indexPath) as! tagsViewCell
        let mydata = tagArry[indexPath.item]
        //cell.bgLbl.cornerRadius = 8
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        cell.tagshort.cornerRadius = cell.tagshort.frame.height/2
        cell.tagName.text = mydata.tagName!
        var tagname = mydata.tagName!.prefix(1)
        cell.tagshort.text = "\(tagname.uppercased())"
        
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
    
    
}
extension Date {
        func timeAgoDisplay() -> String {
            let calendar = Calendar.current
            let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
            let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
            let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
            let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
            if minuteAgo < self {
                let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
                return "\(diff) sec ago"
            } else if hourAgo < self {
                let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
                return "\(diff) min ago"
            } else if dayAgo < self {
                let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
                return "\(diff) hrs ago"
            } else if weekAgo < self {
                let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
                if(diff > 1)
                {
                    return "\(diff) days ago"
                }
                else
                {
                    return "\(diff) day ago"
                }
            }
            let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
            if(diff>1)
            {
                return "\(diff) weeks ago"
            }
            else
            {
                return "\(diff) week ago"
            }
        }
    }
