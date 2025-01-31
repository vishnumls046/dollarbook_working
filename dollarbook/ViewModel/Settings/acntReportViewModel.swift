//
//  acntReportViewModel.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 17/12/22.
//

import Foundation
import UIKit
import Alamofire

class acntReportViewModel:NSObject
{
    var pagecount = 0
    var isLastPage = 0
    var acntRprtDlgt:acntReportProt?
    var transArry = [Transactions]()
    static var sltdTrnsId = ""
    var frmDte = ""
    var toDte = ""
    var acntId  = ""
    var closingBal = 0
    var frstTrnscnSts = ""
    var initlBal = ""
    func getTransactions(fromDate:String,toDate:String,tags:String,acntId:String)
    {
        
        self.acntId = acntId
        let monthsToAdd = -1
         let currentDate = Date()
        var dateComponent = DateComponents()
         dateComponent.month = monthsToAdd
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if(fromDate == "")
        {
            self.frmDte = dateFormatter1.string(from: futureDate!)
        }
        else
        {
            self.frmDte = fromDate
        }
        if(toDate == "")
        {
            self.toDte = dateFormatter1.string(from: currentDate)
        }
        else
        {
            self.toDte = toDate
        }
        
        print("\(frmDte)---\(toDte)")
        AF.request(APImanager.BankReport(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"start_date":frmDte,"end_date":toDte,"account_id":acntId,"ending_balance":self.closingBal, "page_no":self.pagecount] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
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
                        self.closingBal = anItem.closing_balance!
                    // do something with personName and personID
                    }
                    self.frstTrnscnSts = TagResponse.first_transaction!
                    
                    self.isLastPage = TagResponse.isLastpage!
                        if self.isLastPage == 0{
                            self.pagecount=self.pagecount+1
                        }
                    if(self.frstTrnscnSts == "1")
                    {
                        self.initlBal = TagResponse.initial_balance!
                        self.acntRprtDlgt?.recentTblUpdt(trnsCnt:"\(self.transArry.count+1)")
                    }
                    else
                    {
                        self.acntRprtDlgt?.recentTblUpdt(trnsCnt:"\(self.transArry.count)")
                    }
                }
                catch let err{
                    self.acntRprtDlgt?.recentTblUpdt(trnsCnt:"\(self.transArry.count)")
                    print(err)
                }
            }
        }
        
    }
    
}
extension acntReportViewModel: UITableViewDataSource,UITableViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height + 15
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            if self.isLastPage == 0{
            self.getTransactions(fromDate: self.frmDte, toDate: self.toDte, tags: "", acntId: self.acntId)
//                            self.fetchlist()
                        }
            print(" you reached end of the table")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.frstTrnscnSts == "1")
        {
            return self.transArry.count+1
        }
        else
        {
            return self.transArry.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(self.frstTrnscnSts == "1")
        {
            if(indexPath.row == 0)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "listInitialBal", for: indexPath) as! initialBalTblViewCell
                let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
                let crcyCode = crncy.htmlToString
                cell.initilBal_amnt.text = "+ \(crcyCode)\(self.initlBal)"
                cell.crvdLbl1.cornerRadius = 11
                cell.crvdLbl1.backgroundColor = UIColor(red: 242/255, green: 238/255, blue: 255/255, alpha: 1.0)
                return cell
            }
            else
            {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "listRecent", for: indexPath) as! recentTblViewCell
                
                cell.title.text = "\(self.transArry[indexPath.row-1].transactionText!)"
                let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
                let crcyCode = crncy.htmlToString
                cell.balance.text = " \(crcyCode) \(self.transArry[indexPath.row-1].closing_balance!)"
                cell.amount.text = "+ \(crcyCode) \(self.transArry[indexPath.row-1].transactionAmount!)"
                cell.title.textColor = UIColor.black
                cell.balance.textColor = UIColor.black
                cell.time.textColor = UIColor.gray
                var addDate = self.transArry[indexPath.row-1].clearedDate!
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "dd-MMM-YYYY"
                // Convert String to Date
                let date = dateFormatter.date(from: addDate)
                //var frmtdate = date!.timeAgoDisplay()
                cell.time.text = "\(dateFormatter1.string(from: date!))"
                if(self.transArry[indexPath.row-1].transactionType! == "1")
                {
                    cell.Icn.image = UIImage(named: "IncmTbl_Icn")
                    //cell.title.textColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
                    cell.crvdLbl.backgroundColor = UIColor(red: 242/255, green: 238/255, blue: 255/255, alpha: 1.0)
                    cell.crvdLbl.layer.cornerRadius = 11
                    cell.crvdLbl.layer.masksToBounds = true
                    
                    //cell.balance.textColor = ColorManager.incomeColor()
                    cell.amount.text = "+ \(crcyCode) \(self.transArry[indexPath.row-1].transactionAmount!)"
                    cell.amount.textColor = ColorManager.incomeColor()
                }
                else if(self.transArry[indexPath.row-1].transactionType! == "2")
                {
                    cell.Icn.image = UIImage(named: "expTbl_Icn")
                    //cell.title.textColor = UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
                    cell.crvdLbl.backgroundColor = UIColor(red: 255/255, green: 233/255, blue: 233/255, alpha: 1.0)
                    cell.crvdLbl.layer.cornerRadius = 11
                    cell.crvdLbl.layer.masksToBounds = true
                    cell.amount.text = "- \(crcyCode) \(self.transArry[indexPath.row-1].transactionAmount!)"
                    cell.amount.textColor = ColorManager.expenseColor()
                    //cell.balance.textColor = ColorManager.expenseColor()
                }
                else
                {
                    cell.Icn.image = UIImage(named: "transfrIcon")
                    //cell.title.textColor = UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
                    cell.crvdLbl.backgroundColor = ColorManager.transferColor()
                    cell.crvdLbl.layer.cornerRadius = 11
                    cell.crvdLbl.layer.masksToBounds = true
                    cell.amount.text = "\(crcyCode) \(self.transArry[indexPath.row-1].transactionAmount!)"
                    cell.amount.textColor = ColorManager.transferColor()
                    //cell.balance.textColor = ColorManager.expenseColor()
                }
                
                return cell
            }
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "listRecent", for: indexPath) as! recentTblViewCell
            
            cell.title.text = "\(self.transArry[indexPath.row].transactionText!)"
            let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
            let crcyCode = crncy.htmlToString
            cell.balance.text = " \(crcyCode) \(self.transArry[indexPath.row].closing_balance!)"
            
            cell.title.textColor = UIColor.black
            cell.balance.textColor = UIColor.black
            cell.time.textColor = UIColor.gray
            var addDate = self.transArry[indexPath.row].clearedDate!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "dd-MMM-YYYY"
            // Convert String to Date
            let date = dateFormatter.date(from: addDate)
            //var frmtdate = date!.timeAgoDisplay()
            cell.time.text = "\(dateFormatter1.string(from: date!))"
            if(self.transArry[indexPath.row].transactionType! == "1")
            {
                cell.Icn.image = UIImage(named: "IncmTbl_Icn")
                //cell.title.textColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
                cell.crvdLbl.backgroundColor = UIColor(red: 242/255, green: 238/255, blue: 255/255, alpha: 1.0)
                cell.crvdLbl.layer.cornerRadius = 11
                cell.crvdLbl.layer.masksToBounds = true
                
                //cell.balance.textColor = ColorManager.incomeColor()
                cell.amount.text = "+ \(crcyCode) \(self.transArry[indexPath.row].transactionAmount!)"
                cell.amount.textColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
            }
            else if(self.transArry[indexPath.row].transactionType! == "2")
            {
                cell.Icn.image = UIImage(named: "expTbl_Icn")
                //cell.title.textColor = UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
                cell.crvdLbl.backgroundColor = UIColor(red: 255/255, green: 233/255, blue: 233/255, alpha: 1.0)
                cell.crvdLbl.layer.cornerRadius = 11
                cell.crvdLbl.layer.masksToBounds = true
                cell.amount.text = "- \(crcyCode) \(self.transArry[indexPath.row].transactionAmount!)"
                cell.amount.textColor = ColorManager.expenseColor()
                //cell.balance.textColor = ColorManager.expenseColor()
            }
            else
            {
                cell.Icn.image = UIImage(named: "transfrIcon")
                //cell.title.textColor = UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
                cell.crvdLbl.backgroundColor = ColorManager.transferColor()
                cell.crvdLbl.layer.cornerRadius = 11
                cell.crvdLbl.layer.masksToBounds = true
                cell.amount.text = "\(crcyCode) \(self.transArry[indexPath.row].transactionAmount!)"
                cell.amount.textColor = ColorManager.transferColor()
                //cell.balance.textColor = ColorManager.expenseColor()
            }
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        acntReportViewModel.slctdAcntId = self.transArry[indexPath.row].accountId!
//        self.acntRprtDlgt?.slctTbl()
        
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
                                self.acntRprtDlgt?.alerts(alrtStr: acntResponse.addresult!.message!)
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
    private func handleDelete(inx:IndexPath) {
//        self.acntMngDlgt?.editAcnt(acntNme:self.acntMdlArry[inx.row].account_name!,intlAmnt:self.acntMdlArry[inx.row].starting_balance!,acntId:self.acntMdlArry[inx.row].account_id!)
        print("Edit \(inx.row)")
        self.pagecount = 0
        if(self.frstTrnscnSts == "1") && (inx.row != 0)
        {
            acntReportViewModel.sltdTrnsId = self.transArry[inx.row-1].transactionId!
            acntRprtDlgt?.deleteAlert()
        }
        else
        {
            acntReportViewModel.sltdTrnsId = self.transArry[inx.row].transactionId!
            acntRprtDlgt?.deleteAlert()
        }
        
    }
    private func handleMarkAsFavourite(inx:IndexPath) {
//        self.acntMngDlgt?.editAcnt(acntNme:self.acntMdlArry[inx.row].account_name!,intlAmnt:self.acntMdlArry[inx.row].starting_balance!,acntId:self.acntMdlArry[inx.row].account_id!)
        print("Edit \(inx.row)")
        self.pagecount = 0
        if(self.frstTrnscnSts == "1") && (inx.row != 0)
        {
            DashboardViewModel.trnscTyp = self.transArry[inx.row-1].transactionType!
            acntReportViewModel.sltdTrnsId = self.transArry[inx.row-1].transactionId!
            self.acntRprtDlgt?.editRedrct()
        }
        else
        {
            DashboardViewModel.trnscTyp = self.transArry[inx.row].transactionType!
            acntReportViewModel.sltdTrnsId = self.transArry[inx.row].transactionId!
            self.acntRprtDlgt?.editRedrct()
        }
    }
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if(self.frstTrnscnSts == "1") && (indexPath.row == 0)
        {
        }
        else if(self.frstTrnscnSts == "1") && (indexPath.row != 0)
        {
            let action = UIContextualAction(style: .normal,
                                            title: "Edit") { [weak self] (action, view, completionHandler) in
                self?.handleMarkAsFavourite(inx:indexPath)
                completionHandler(true)
            }
            if(self.transArry[indexPath.row-1].transactionType! == "1")
            {
                action.backgroundColor = ColorManager.incomeColor()
            }
            else
            {
                action.backgroundColor = ColorManager.expenseColor()
            }
            let delete = UIContextualAction(style: .normal,
                                            title: "Delete") { [weak self] (delete, view, completionHandler) in
                self?.handleDelete(inx:indexPath)
                completionHandler(true)
            }
            delete.backgroundColor = UIColor.red
            
            return UISwipeActionsConfiguration(actions: [action,delete])
        }
        else
        {
            let action = UIContextualAction(style: .normal,
                                            title: "Edit") { [weak self] (action, view, completionHandler) in
                self?.handleMarkAsFavourite(inx:indexPath)
                completionHandler(true)
            }
            if(self.transArry[indexPath.row].transactionType! == "1")
            {
                action.backgroundColor = ColorManager.incomeColor()
            }
            else
            {
                action.backgroundColor = ColorManager.expenseColor()
            }
            let delete = UIContextualAction(style: .normal,
                                            title: "Delete") { [weak self] (delete, view, completionHandler) in
                self?.handleDelete(inx:indexPath)
                completionHandler(true)
            }
            delete.backgroundColor = UIColor.red
            
            return UISwipeActionsConfiguration(actions: [action,delete])
        }
        return nil
    }

}
