//
//  ReportDetView.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 25/07/23.
//

import Foundation
import Alamofire
import UIKit
class ReportDetViewModel:NSObject
{
    var pagecount = 0
    var isLastPage = 0
    var transArry = [Transactions]()
    var tagType = ""
    

    var frmDate = ""
    var toDate = ""
    var dateFilter = ""
    var tags = ""
    var acntId = ""
    var reprtDetDlgt:reportsDetUIUpdt?
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
                    self.reprtDetDlgt?.reprtStatUpdt(val: Response)
//                    print(Response)
                }
                catch let err{
                    print(err)
                }
            }
        }
    }
    
    //Get transactions for the selected tag
    func getTransactions(fromDate:String,toDate:String,dateFilter:String,tags:String,acntId:String, pageCnt:Int)
    {
        self.frmDate = fromDate
        self.toDate = toDate
        self.dateFilter = dateFilter
        self.tags = tags
        self.acntId = acntId
        self.pagecount = pageCnt
        AF.request(APImanager.getReportDet(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"datefilter":dateFilter,"start_date":fromDate,"end_date":toDate,"tag_id":tags,"account_id":acntId,"page_no":self.pagecount,"transaction_type":ReportViewModel.trnscnTyp] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
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
                    self.reprtDetDlgt?.recentTblUpdt(trnsCnt:"\(self.transArry.count)")
                }
                catch let err{
                    self.reprtDetDlgt?.recentTblUpdt(trnsCnt:"\(self.transArry.count)")
                    print(err)
                }
            }
        }
        
    }
}

extension ReportDetViewModel: UITableViewDataSource,UITableViewDelegate {
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
            cell.Icn.image = UIImage(named: "IncmTbl_Icn")
            cell.crvdLbl.backgroundColor = UIColor(red: 242/255, green: 238/255, blue: 255/255, alpha: 1.0)
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
            cell.Icn.image = UIImage(named: "expTbl_Icn")
            cell.crvdLbl.backgroundColor = UIColor(red: 255/255, green: 233/255, blue: 233/255, alpha: 1.0)
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
            cell.amount.text = "+ \(crcyCode) \(self.transArry[indexPath.row].transactionAmount!)"
            
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
        self.reprtDetDlgt?.editRedrct()
    }
    private func handleDelete(inx:IndexPath) {
//        self.acntMngDlgt?.editAcnt(acntNme:self.acntMdlArry[inx.row].account_name!,intlAmnt:self.acntMdlArry[inx.row].starting_balance!,acntId:self.acntMdlArry[inx.row].account_id!)
        print("Edit \(inx.row)")
        
        acntReportViewModel.sltdTrnsId = self.transArry[inx.row].transactionId!
        reprtDetDlgt?.deleteAlert()
        
        
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
                                self.reprtDetDlgt?.alerts(alrtStr: acntResponse.addresult!.message!)
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
