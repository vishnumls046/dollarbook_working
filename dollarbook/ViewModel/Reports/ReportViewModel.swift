//
//  ReportViewModel.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 04/11/22.
//

import Foundation
import Alamofire
import UIKit
class ReportViewModel:NSObject
{
    var pagecount = 0
    var isLastPage = 0
    static var acntsMdlArry:[Accounts] = []
    static var test:[String] = []
    static var seltagName:[String] = []
    static var tagType:String = ""
    var incmArry = [IncomeTags]()
    var expArry = [ExpenseTags]()
    var transArry = [Transactions]()
    var tagsArry = [Tags]()
    var incmTagsArry = [Tags]()
    var expTagsArry = [Tags]()
    var incmTagsArry1 = [Tags]()
    var expTagsArry1 = [Tags]()
    var incmTagsArry2 = [Tags]()
    var expTagsArry2 = [Tags]()
    var incmTagArry:[String] = []
    var expnsTagArry:[String] = []
    var incmTagIdArry:[String] = []
    var expnsTagIdArry:[String] = []
    var incmTagArry1:[String] = []
    var expnsTagArry1:[String] = []
    
    var TagArry:[String] = []
    var TagArry1:[String] = []
    var TagArry2:[String] = []
    var slctdTagArry:[String] = []
    var tagType = ""
    

    var frmDate = ""
    var toDate = ""
    var dateFilter = ""
    var tags = ""
    var acntId = ""
    var type = ""
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
    let colors1 = [
        UIColor.yellow.withAlphaComponent(alpha1),
        UIColor.green.withAlphaComponent(alpha1),
        UIColor.purple.withAlphaComponent(alpha1),
        UIColor.cyan.withAlphaComponent(alpha1),
        UIColor.darkGray.withAlphaComponent(alpha1),
        UIColor.red.withAlphaComponent(alpha1),
        UIColor.magenta.withAlphaComponent(alpha1),
        UIColor.orange.withAlphaComponent(alpha1),
        UIColor.brown.withAlphaComponent(alpha1),
        UIColor.lightGray.withAlphaComponent(alpha1),
        UIColor.gray.withAlphaComponent(alpha1),
    ]
    
    static var frmDate:String = ""
    static var toDate:String = ""
    static var dateFilter:String = ""
    static var tags:String = ""
    static var acntId:String = ""
    static var trnscnTyp:String = ""
    static var incTot:String = ""
    static var expTot:String = ""
//    var TagArry = ["sds","gdfgh","jghjghj","sds","gdfgh","jghjghj","sds","gdfgh","jghjghj","sds","gdfgh","jghjghj","gdfgh","jghjghj","sds","gdfgh","jghjghj","sds","gdfgh","jghjghj","sds","gdfgh","jghjghj","gdfgh","jghjghj","sds","gdfgh","jghjghj","sds","gdfgh","jghjghj","sds","gdfgh","jghjghj"]
    var reprtDlgt:reportsUIUpdt?
    func getDashStat(fromDate:String,toDate:String,dateFilter:String,tag_id:String,account_id:String)
    {
        AF.request(APImanager.DashStat(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"datefilter":dateFilter,"startDate":fromDate,"endDate":toDate,"account_id":account_id,"tag_id":tag_id] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let Response  = try
                    JSONDecoder().decode(dashStatModel.self, from: data)
                    self.reprtDlgt?.reprtStatUpdt(val: Response)
                    print(Response)
                    var tot =  Double(Response.total_income!)! + Double(Response.total_expense!)!
                    if(tot>0)
                    {
                        var IncPerc = (Double(Response.total_income!)!) / tot * 100
                        var ExpPerc = (Double(Response.total_expense!)!) / tot * 100
                        //self.reprtDlgt?.graphValUpdt(IncVals: Double(IncPerc), ExpVals: Double(ExpPerc))
                    }
                    else
                    {
                        var IncPerc = 0
                        var ExpPerc = 0
                        //self.reprtDlgt?.graphValUpdt(IncVals: Double(IncPerc), ExpVals: Double(ExpPerc))
                    }
//                    if(Response.total_income! == "0" || Response.total_income! == "0")
//                    {
//                        self.reprtDlgt?.graphValUpdt(IncVals: 50, ExpVals: 50)
//                    }
//                    else
//                    {
                        
                    //}
                    
                }
                catch let err{
                    print(err)
                }
            }
        }
    }
    func getReports(fromDate:String,toDate:String,dateFilter:String,tags:String,acntId:String, type:String)
    {
        self.type = type
        self.frmDate = fromDate
        self.toDate = toDate
        self.dateFilter = dateFilter
        self.tags = tags
        self.acntId = acntId
        ReportViewModel.trnscnTyp = type
        //self.pagecount = pageCnt
        
        AF.request(APImanager.getReport(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"datefilter":dateFilter,"start_date":fromDate,"end_date":toDate,"tag_id":tags,"account_id":acntId] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let TagResponse  = try
                    JSONDecoder().decode(ReportsView.self, from: data)
                    print(TagResponse.incomeTags!)
                    
                        self.incmArry = []
                        self.expArry = []
                    for anItem in TagResponse.incomeTags! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        self.incmArry.append(anItem)
                        
                    // do something with personName and personID
                    }
                    for anItem in TagResponse.expenseTags! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        self.expArry.append(anItem)
                        
                    // do something with personName and personID
                    }
//                    if(TagResponse.isLastpage != nil)
//                    {
//                        self.isLastPage = TagResponse.isLastpage!
//                    }
//                        if self.isLastPage == 0{
//                            self.pagecount=self.pagecount+1
//                        }
                    ReportViewModel.test = []
                    
                    if(type == "1")
                    {
                        self.reprtDlgt?.recentTblUpdt(trnsCnt:"\(self.incmArry.count)")
                        self.reprtDlgt?.chartUpdt(incmArry: self.incmArry, expArry: self.expArry)
                    }
                    else
                    {
                        self.reprtDlgt?.recentTblUpdt(trnsCnt:"\(self.expArry.count)")
                        self.reprtDlgt?.chartUpdt(incmArry: self.incmArry, expArry: self.expArry)
                    }
                }
                catch let err{
                    if(type == "1")
                    {
                        self.reprtDlgt?.recentTblUpdt(trnsCnt:"\(self.incmArry.count)")
                    }
                    else
                    {
                        self.reprtDlgt?.recentTblUpdt(trnsCnt:"\(self.expArry.count)")
                    }
                    print(err)
                }
            }
        }
        
    }
    func getTransactions(fromDate:String,toDate:String,dateFilter:String,tags:String,acntId:String, pageCnt:Int)
    {
        self.frmDate = fromDate
        self.toDate = toDate
        self.dateFilter = dateFilter
        self.tags = tags
        self.acntId = acntId
        self.pagecount = pageCnt
        AF.request(APImanager.GetTransactions(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"datefilter":dateFilter,"start_date":fromDate,"end_date":toDate,"tag_id":tags,"account_id":acntId,"page_no":self.pagecount] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
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
                    ReportViewModel.test = []
                    self.reprtDlgt?.recentTblUpdt(trnsCnt:"\(self.transArry.count)")
                }
                catch let err{
                    self.reprtDlgt?.recentTblUpdt(trnsCnt:"\(self.transArry.count)")
                    print(err)
                }
            }
        }
        
    }
    func getTags(tags:String)
    {
        ReportViewModel.test = []
        self.slctdTagArry = []
        ReportViewModel.tagType = tags
        
        AF.request(APImanager.GetTagsAPI(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let TagResponse  = try
                    JSONDecoder().decode(TagsModel.self, from: data)
                    print(TagResponse.tags!)
                    self.tagsArry = []
                    //self.incmTagArry = []
                    //self.expnsTagArry = []
                    self.incmTagsArry = []
                    self.TagArry = []
                    self.TagArry1 = []
                    self.TagArry2 = []
                    self.slctdTagArry = []
                    
                    self.incmTagArry = []
                    self.expnsTagArry = []
                    self.incmTagIdArry = []
                    self.expnsTagIdArry = []
                    for anItem in TagResponse.tags! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        self.tagsArry.append(anItem)
                        if(anItem.tagType == "1")
                        {
                            self.incmTagsArry.append(anItem)
                            //self.incmTagArry.append(anItem.tagName!)
                            self.incmTagArry.append(anItem.tagName!)
                            self.incmTagIdArry.append(anItem.tagId!)
                           
                        }
                        else
                        {
                            self.expTagsArry.append(anItem)
                            self.expnsTagArry.append(anItem.tagName!)
                            self.expnsTagIdArry.append(anItem.tagId!)
                            
                        }
                        
                        
                    // do something with personName and personID
                    }
                    if(tags == "income")
                    {
                        self.TagArry.append(contentsOf: self.incmTagArry)
                    }
                    else
                    {
                        self.TagArry.append(contentsOf: self.expnsTagArry)
                    }
                    //self.getDfltTags(tags: tags)
                    self.reprtDlgt?.loadTagsCln()
                    
                }
                catch let err{
                    self.reprtDlgt?.loadTagsCln()
                    print(err)
                }
            }
        }
        
    }
    func getDfltTags(tags:String)
    {
        ReportViewModel.test = []
        self.slctdTagArry = []
        self.tagType = tags
        ReportViewModel.tagType = tags
        AF.request(APImanager.GetDefltTags(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let TagResponse  = try
                    JSONDecoder().decode(TagsModel.self, from: data)
                    print(TagResponse.tags!)
                    //self.tagsArry = []
                    self.incmTagArry1 = []
                    self.expnsTagArry1 = []
                    
                    
                    
                    //self.incmTagsArry = []
                    self.TagArry1 = []
                    self.slctdTagArry = []
                    for anItem in TagResponse.tags! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        self.tagsArry.append(anItem)
                        if(anItem.tagType == "1")
                        {
                            self.incmTagsArry1.append(anItem)
                            self.incmTagArry1.append(anItem.tagName!)
                            
//                            self.incmTagArry.append(anItem.tagName!)
//                            self.incmTagIdArry.append(anItem.tagId!)
                            if(self.incmTagArry.contains(anItem.tagName!))
                            {
                                
                            }
                            else
                            {
                                self.incmTagArry.append(anItem.tagName!)
                                self.incmTagIdArry.append(anItem.tagId!)
                            }
                        }
                        else
                        {
                            self.expTagsArry1.append(anItem)
                            self.expnsTagArry1.append(anItem.tagName!)
                            
//                            self.expnsTagArry.append(anItem.tagName!)
//                            self.expnsTagIdArry.append(anItem.tagId!)
                            if(self.expnsTagArry.contains(anItem.tagName!))
                            {
                                
                            }
                            else
                            {
                                self.expnsTagArry.append(anItem.tagName!)
                                self.expnsTagIdArry.append(anItem.tagId!)
                            }
                        }
                        
                        
                    // do something with personName and personID
                    }
                    if(tags == "income")
                    {
                        self.TagArry1.append(contentsOf: self.incmTagArry1)
                    }
                    else
                    {
                        self.TagArry1.append(contentsOf: self.expnsTagArry1)
                    }
                    self.TagArry2 = self.TagArry + self.TagArry1
                    
                    self.incmTagsArry2 = self.incmTagsArry + self.incmTagsArry1
                    self.expTagsArry2 = self.expTagsArry + self.expTagsArry1
                    self.reprtDlgt?.loadTagsCln()
                    
                    //self.getTags(tags: tags)
                }
                catch let err{
                   // self.reprtDlgt?.loadTagsCln()
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
                    
                    ReportViewModel.acntsMdlArry = []
                    let AcntsResponse  = try
                    JSONDecoder().decode(AccountsModel.self, from: data)
                    print(AcntsResponse.accounts!)
                    for anItem in AcntsResponse.accounts! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        
                        ReportViewModel.acntsMdlArry.append(anItem)
                        
                    // do something with personName and personID
                    }
                    self.reprtDlgt?.updtAcntTbl()
                }
                catch let err{
                    print(err)
                }
            }
        }
        
        
    }
}
extension ReportViewModel: UITableViewDataSource,UITableViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height + 15
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            if self.isLastPage == 0{
                self.getTransactions(fromDate: self.frmDate, toDate: self.toDate, dateFilter: self.dateFilter, tags: self.tags, acntId: self.acntId, pageCnt: self.pagecount)
//                            self.fetchlist()
                        }
            print(" you reached end of the table")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.type == "1")
        {
            return self.incmArry.count
        }
        else 
        {
            return self.expArry.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "listRecent", for: indexPath) as! recentTblViewCell
        if(self.type == "1")
        {
            if(self.incmArry.count > 0)
            {
                cell.title.text = "\(self.incmArry[indexPath.row].tagName!)"
                let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
                let crcyCode = crncy.htmlToString
                cell.amount.text = "+ \(crcyCode) \(self.incmArry[indexPath.row].totIncome!)"
                //cell.Icn.image = UIImage(named: "IncmTbl_Icn")
                cell.crvdLbl.backgroundColor = UIColor(hex: self.incmArry[indexPath.row].iconColor!)
                var tagname = self.incmArry[indexPath.row].tagName!.prefix(1)
                cell.crvdLbl.text =  "\(tagname.uppercased())"
                cell.amount.textColor = ColorManager.incomeColor()
                cell.percntgVal.text = "\(self.incmArry[indexPath.row].income_percentage!)%"
                cell.percntg.backgroundColor = colors[indexPath.row]
                var totlngth = cell.percntgBg.frame.width
                var fillLength = Int(totlngth)*(self.incmArry[indexPath.row].income_percentage!)/100
                cell.percntgLength.constant = CGFloat(fillLength)
                
            }
        }
        else
        {
            if(self.expArry.count > 0)
            {
                cell.title.text = "\(self.expArry[indexPath.row].tagName!)"
                let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
                let crcyCode = crncy.htmlToString
                cell.amount.text = "- \(crcyCode) \(self.expArry[indexPath.row].totExpense!)"
                //cell.Icn.image = UIImage(named: "expTbl_Icn")
                cell.crvdLbl.backgroundColor = ColorManager.expenseColorTblIcn()
                var tagname = self.expArry[indexPath.row].tagName!.prefix(1)
                cell.crvdLbl.text =  "\(tagname.uppercased())"
                cell.amount.textColor = ColorManager.expenseColor()
                cell.percntg.backgroundColor = colors[indexPath.row]
                cell.percntgVal.text = "\(self.expArry[indexPath.row].expense_percentage!)%"
                var totlngth = cell.percntgBg.frame.width
                var fillLength = Int(totlngth)*(self.expArry[indexPath.row].expense_percentage!)/100
                cell.percntgLength.constant = CGFloat(fillLength)
            }
            cell.crvdLbl.layer.cornerRadius = 11
            cell.crvdLbl.layer.masksToBounds = true
        }
                
//                var addDate = self.transArry[indexPath.row].transactionAddedDate!
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//                // Convert String to Date
//                let date = dateFormatter.date(from: addDate)
//                var frmtdate = date!.timeAgoDisplay()
//                cell.time.text = "\(frmtdate)"
                
                
                //            cell.frmAcntLbl.isHidden = true
                //            cell.toAcntLbl.isHidden = true
                //            cell.trnsfrIcn.isHidden = true
                
                
                return cell
            
            
            
        
        //return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if(self.type == "1")
        {
            ReportViewModel.tags = self.incmArry[indexPath.row].tagId!
            ReportViewModel.incTot = self.incmArry[indexPath.row].totIncome!
            ReportViewModel.expTot = "0"
        }
        else
        {
            ReportViewModel.tags = self.expArry[indexPath.row].tagId!
            ReportViewModel.incTot = "0"
            ReportViewModel.expTot = self.expArry[indexPath.row].totExpense!
        }
        ReportViewModel.frmDate = self.frmDate
        ReportViewModel.toDate = self.toDate
        ReportViewModel.dateFilter = self.dateFilter
        ReportViewModel.acntId = self.acntId
            
        //ReportDetViewModel.slctdAcntName = self.acntMdlArry[indexPath.row].account_name!
        self.reprtDlgt?.slctTbl()
        
            //self.acntMngDlgt?.acntsTblSelect(acnt: self.acntMdlArry[indexPath.row], acntId: self.crncyIdArry[indexPath.row])
        
            
        
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
                                self.reprtDlgt?.alerts(alrtStr: acntResponse.addresult!.message!)
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
//    private func handleDelete(inx:IndexPath) {
////        self.acntMngDlgt?.editAcnt(acntNme:self.acntMdlArry[inx.row].account_name!,intlAmnt:self.acntMdlArry[inx.row].starting_balance!,acntId:self.acntMdlArry[inx.row].account_id!)
//        print("Edit \(inx.row)")
//
//        acntReportViewModel.sltdTrnsId = self.transArry[inx.row].transactionId!
//        reprtDlgt?.deleteAlert()
//
//
//    }
//    private func handleMarkAsFavourite(inx:IndexPath) {
////        self.acntMngDlgt?.editAcnt(acntNme:self.acntMdlArry[inx.row].account_name!,intlAmnt:self.acntMdlArry[inx.row].starting_balance!,acntId:self.acntMdlArry[inx.row].account_id!)
//        print("Edit \(inx.row)")
//        DashboardViewModel.trnscTyp = self.transArry[inx.row].transactionType!
//        acntReportViewModel.sltdTrnsId = self.transArry[inx.row].transactionId!
//        self.reprtDlgt?.editRedrct()
//    }
//    func tableView(_ tableView: UITableView,
//                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let action = UIContextualAction(style: .normal,
//                                        title: "Edit") { [weak self] (action, view, completionHandler) in
//            self?.handleMarkAsFavourite(inx:indexPath)
//                                            completionHandler(true)
//        }
//        if(self.transArry[indexPath.row].transactionType! == "1")
//        {
//            action.backgroundColor = ColorManager.incomeColor()
//        }
//        else if(self.transArry[indexPath.row].transactionType! == "2")
//        {
//            action.backgroundColor = ColorManager.expenseColor()
//        }
//        else
//        {
//            action.backgroundColor = ColorManager.transferColor()
//        }
//        let delete = UIContextualAction(style: .normal,
//                                        title: "Delete") { [weak self] (delete, view, completionHandler) in
//            self?.handleDelete(inx:indexPath)
//                                            completionHandler(true)
//        }
//        delete.backgroundColor = UIColor.red
//
//        return UISwipeActionsConfiguration(actions: [action,delete])
//    }
}
extension ReportViewModel:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(ReportViewModel.tagType == "income")
        {
            return self.incmTagArry.count
        }
        else if(ReportViewModel.tagType == "expense")
        {
            return self.expnsTagArry.count
        }
        else
        {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crncyCell", for: indexPath) as! tagsViewCell
        cell.layer.borderWidth = 0.0
        cell.layer.borderColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0).cgColor
        if(ReportViewModel.tagType == "income")
        {
            let mydata = incmTagArry[indexPath.item]
            var tagname = mydata.prefix(1)
            cell.tagshort.text = "\(tagname.uppercased())"
            cell.tagName.text = mydata
        }
        else
        {
            let mydata = expnsTagArry[indexPath.item]
            var tagname = mydata.prefix(1)
            cell.tagshort.text = "\(tagname.uppercased())"
            cell.tagName.text = mydata
        }
        //let tagData = tagsArry[indexPath.item]
        //cell.bgLbl.cornerRadius = 8
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        cell.tagshort.cornerRadius = cell.tagshort.frame.height/2
        //cell.tagName.text = mydata
        
        if(ReportViewModel.tagType == "income")
        {
            cell.tagshort.backgroundColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
        }
        else
        {
            cell.tagshort.backgroundColor = UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
            
            
        }
        //cell.tagshort.text = "T"
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
extension ReportViewModel: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0).cgColor
        if(ReportViewModel.tagType == "income")
        {
            ReportViewModel.test.append(incmTagIdArry[indexPath.item])
            ReportViewModel.seltagName.append(incmTagArry[indexPath.item])
            //print(self.slctdTagArry)
            //ReportViewModel.test = self.slctdTagArry
            //ReportViewModel.test.append(contentsOf: self.slctdTagArry)
        }
        else
        {
            ReportViewModel.test.append(expnsTagIdArry[indexPath.item])
            ReportViewModel.seltagName.append(expnsTagArry[indexPath.item])
            //print(self.slctdTagArry)
           // ReportViewModel.test.append(contentsOf: self.slctdTagArry)
            //ReportViewModel.test = self.slctdTagArry
        }
        print(ReportViewModel.test)
            //self.reprtDlgt?.slctTagId(val: self.slctdTagArry)
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0.0
        cell?.layer.borderColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0).cgColor
        if(ReportViewModel.tagType == "income")
        {
            var deslcVal = incmTagIdArry[indexPath.item]
            ReportViewModel.test.removeAll(where: { $0 == deslcVal })
            
            var deslcVal1 = incmTagArry[indexPath.item]
            ReportViewModel.seltagName.removeAll(where: { $0 == deslcVal1 })
        }
        else
        {
            var deslcVal = expnsTagIdArry[indexPath.item]
            ReportViewModel.test.removeAll(where: { $0 == deslcVal })
            
            var deslcVal1 = expnsTagArry[indexPath.item]
            ReportViewModel.seltagName.removeAll(where: { $0 == deslcVal1 })
        }
        
        //ReportViewModel.test = self.slctdTagArry
        //ReportViewModel.test.append(contentsOf: self.slctdTagArry)
        //print(self.slctdTagArry)
        //self.reprtDlgt?.slctTagId(val: self.slctdTagArry)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300/3, height: 300/3)
    }
}

