//
//  ExpenseViewModel.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 19/10/22.
//

import Foundation
import Alamofire
import UIKit
import Kingfisher
class ExpenseViewModel:NSObject
{
    var pagecount = 0
    var isLastPage = 0
    var expnsDlgt:ExpenseUIupdt?
    var transArry = [Transactions]()
    var monthArry = [String]()
    var ExpnsArry = [Int]()
    func getTransactions()
    {
        AF.request(APImanager.GetTransactions(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"transaction_type":"2", "page_no":self.pagecount],encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
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
                        //self.expnsDlgt?.trnscnTblUpt()
                        self.expnsDlgt?.recentTblUpdt(trnsCnt:"\(self.transArry.count)")
                    }
                    
                }
                catch let err{
                    DispatchQueue.main.async {
                        //self.expnsDlgt?.noTrnscnUpt()
                        self.expnsDlgt?.recentTblUpdt(trnsCnt:"\(self.transArry.count)")
                    }
                    
                    print(err)
                }
            }
        }
        
    }
    func getMnthsBarGraphData()
    {
        self.transArry = []
        self.monthArry = []
        self.ExpnsArry = []
        AF.request(APImanager.GetBarGrphData(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!],encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let monthResponse  = try
                    JSONDecoder().decode(BarGrphModel.self, from: data)
                    print(monthResponse)
                    for anItem in monthResponse.transactions! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        self.monthArry.append(anItem.month!)
                        let nf = NumberFormatter()
                        let x = nf.number(from: anItem.totExpense!)!.intValue
                        
                        self.ExpnsArry.append(x)
                        //var totIncm = Int(anItem.totalIncome!)
//                        if let totIncm = Int(anItem.totalIncome!) {
//                            self.IncmArry.append(totIncm/1000)
//                        }
//                        else {
//                            self.IncmArry.append(0)
//                        }
                        

                    // do something with personName and personID
                    }
                    DispatchQueue.main.async {
                        self.expnsDlgt?.barGrphUpt(valArry:self.ExpnsArry,mnthArry:self.monthArry)
                    }
                    
                }
                catch let err{
                    
                    print(err)
                }
            }
        }
    }
}
extension ExpenseViewModel: UITableViewDataSource,UITableViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height + 15
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            if self.isLastPage == 0{
                self.getTransactions()
                        }
            print(" you reached end of the table")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.transArry.count
    }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "listRecent", for: indexPath) as! recentTblViewCell
    
    cell.title.text = "\(self.transArry[indexPath.row].transactionText!)"
    let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
    let crcyCode = crncy.htmlToString
    cell.amount.text = "- \(crcyCode) \(self.transArry[indexPath.row].transactionAmount!)"
    var addDate = self.transArry[indexPath.row].transactionAddedDate!
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    // Convert String to Date
    var date = dateFormatter.date(from: addDate)
    var frmtdate = date!.timeAgoDisplay()
    cell.time.text = "\(frmtdate)"
    if(self.transArry[indexPath.row].transactionType! == "1")
    {
        
        
//        cell.Icn.image = UIImage(named: "IncmTbl_Icn")
//        cell.crvdLbl.backgroundColor = UIColor(red: 242/255, green: 238/255, blue: 255/255, alpha: 1.0)
        cell.crvdLbl.layer.cornerRadius = 11
        cell.crvdLbl.layer.masksToBounds = true
    }
    else
    {
        if let url = URL(string: self.transArry[indexPath.row].iconUrl!) {
            let processor = OverlayImageProcessor(overlay: UIColor(hex: self.transArry[indexPath.row].iconClr!), fraction: 0.1)
            
                    // Load the image with Kingfisher and apply the tint
//                           self.ctgryIcon.kf.setImage(
//                                       with: url)
            cell.Icn.kf.setImage(with: url, options: [.processor(processor)])
            
                }
        cell.crvdLbl.backgroundColor = UIColor(hex: self.transArry[indexPath.row].iconClr!)
        cell.crvdLbl.alpha = 0.2
        
        
//        cell.Icn.image = UIImage(named: "expTbl_Icn")
//        cell.crvdLbl.backgroundColor = UIColor(red: 255/255, green: 233/255, blue: 233/255, alpha: 1.0)
        cell.crvdLbl.layer.cornerRadius = 11
        cell.crvdLbl.layer.masksToBounds = true
        cell.amount.textColor = UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
    }
        
    return cell
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
                                self.expnsDlgt?.alerts(alrtStr: acntResponse.addresult!.message!)
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
        
        acntReportViewModel.sltdTrnsId = self.transArry[inx.row].transactionId!
        expnsDlgt?.deleteAlert()
        
        
    }
    private func handleMarkAsFavourite(inx:IndexPath) {
//        self.acntMngDlgt?.editAcnt(acntNme:self.acntMdlArry[inx.row].account_name!,intlAmnt:self.acntMdlArry[inx.row].starting_balance!,acntId:self.acntMdlArry[inx.row].account_id!)
        print("Edit \(inx.row)")
        DashboardViewModel.trnscTyp = self.transArry[inx.row].transactionType!
        acntReportViewModel.sltdTrnsId = self.transArry[inx.row].transactionId!
        self.expnsDlgt?.editRedrct()
    }
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.handleMarkAsFavourite(inx:indexPath)
                                            completionHandler(true)
        }
        action.backgroundColor = ColorManager.expenseColor()
        let delete = UIContextualAction(style: .normal,
                                        title: "Delete") { [weak self] (delete, view, completionHandler) in
            self?.handleDelete(inx:indexPath)
                                            completionHandler(true)
        }
        delete.backgroundColor = UIColor.red

        return UISwipeActionsConfiguration(actions: [action,delete])
    }
}
