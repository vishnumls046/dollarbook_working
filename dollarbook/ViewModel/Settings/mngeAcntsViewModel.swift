//
//  settingsViewModel.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 07/11/22.
//

import Foundation
import Alamofire
import Toaster
import UIKit
class mngeAcntsViewModel:NSObject
{
    static var slctdAcntId = ""
    static var dltAcntId = ""
    static var slctdAcntName = ""
    var crncyOrAcnts = ""
    var acntMngDlgt:acntMngeProt?
    var incmTagArry:[String] = []
    var expnsTagArry:[String] = []
    var crncyArry:[String] = []
    var crncyIdArry:[String] = []
    var crncyCodeArry:[String] = []
    var crncyMdlArry:[Currencies] = []
    var acntMdlArry:[Accounts] = []
   
    func getAcnts(acntType:String)
    {
        AF.request(APImanager.GetAccounts(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"account_type":acntType],encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            
            response in
            if let data = response.data
            {
                do{
                    self.crncyArry = []
                    self.crncyIdArry = []
                    self.acntMdlArry = []
                    let AcntsResponse  = try
                    JSONDecoder().decode(AccountsModel.self, from: data)
                    print(AcntsResponse.accounts!)
                    for anItem in AcntsResponse.accounts! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        self.crncyArry.append(anItem.account_name!)
                        self.crncyIdArry.append(anItem.account_id!)
                        self.acntMdlArry.append(anItem)
                        
                    // do something with personName and personID
                    }
                    self.crncyOrAcnts = "account"
                    
                    self.acntMngDlgt?.updtAcntTbl(count:self.acntMdlArry.count)
                }
                catch let err{
                    self.acntMngDlgt?.updtAcntTbl(count:self.acntMdlArry.count)
                    print(err)
                }
                
            }
            else
            {
                
            }
        }
        //return self.acntMdlArry
        
        
    }
    func validateEditAcnt(acnt:String,intlAmnt:String,acntId:String,acntType:String)
    {
        if (acnt == "")
        {
            self.acntMngDlgt?.valdteAcnt(alrtStr: "Please Enter Account Name !")
        }
        else if (intlAmnt == "")
        {
            self.acntMngDlgt?.valdteAcnt(alrtStr: "Please Enter Initial Amount !")
        }
        else
        {
            DispatchQueue.global().async {
                self.editAcnt(acntNme: acnt, acntIntAmnt: intlAmnt, acntId: acntId,acntType:acntType)
            }
            
            //self.addCrncyAcnt()
        }
    }
    func validateAcnt(acnt:String,intlAmnt:String,acntType:String)
    {
        if (acnt == "")
        {
            self.acntMngDlgt?.valdteAcnt(alrtStr: "Please Enter Account Name !")
        }
        else if (intlAmnt == "")
        {
            self.acntMngDlgt?.valdteAcnt(alrtStr: "Please Enter Initial Amount !")
        }
        else
        {
            DispatchQueue.global().async {
                self.addAcnt(acntNme: acnt,acntIntAmnt:intlAmnt,acntType:acntType)
            }
            
            //self.addCrncyAcnt()
        }
    }
    
    // API For Adding account
    func addAcnt(acntNme:String,acntIntAmnt:String,acntType:String)
    {
        AF.request(APImanager.addAcntAPI(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"account_name":acntNme,"starting_balance":acntIntAmnt,"account_type":acntType] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
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
                        //self.acntMngDlgt?.valdteAcnt(alrtStr: acntResponse.addresult!.message!)
                        Toast(text: acntResponse.addresult!.message!).show()
                        ToastView.appearance().backgroundColor = ColorManager.expenseColor()
                        ToastView.appearance().textColor = .white
                        UserDefaults.standard.set("1", forKey: "acnt")
                        UserDefaults.standard.set("1", forKey: "accountExist")
                        self.acntMngDlgt?.closeAcntView()
                    }
                    
                }
                catch let err{
                    print(err)
                }
            }
        }
        
    }
    
    // API For Editing account
    func editAcnt(acntNme:String,acntIntAmnt:String,acntId:String,acntType:String)
    {
        AF.request(APImanager.editAcntAPI(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"account_name":acntNme,"starting_balance":acntIntAmnt,"account_id":acntId,"account_type":acntType] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
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
                        self.acntMngDlgt?.valdteAcnt(alrtStr: acntResponse.addresult!.message!)
                        UserDefaults.standard.set("1", forKey: "acnt")
                        UserDefaults.standard.set("1", forKey: "accountExist")
                        self.acntMngDlgt?.closeAcntView()
                    }
                    
                }
                catch let err{
                    print(err)
                }
            }
        }
        
    }
    func Dlt(delAcntId:String)  // API For deleting account
    {
        AF.request(APImanager.delBankAcnt(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"account_id":delAcntId] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
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
                                Toast(text: acntResponse.addresult!.message!).show()
                                ToastView.appearance().backgroundColor = ColorManager.expenseColor()
                                ToastView.appearance().textColor = .white
                            }
                    DispatchQueue.global().async {
                        self.getAcnts(acntType: "")
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
}


extension mngeAcntsViewModel: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.acntMdlArry.count
    }
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "listRecent", for: indexPath) as! recentTblViewCell
    cell.title.text = "\(self.acntMdlArry[indexPath.row].account_name!)"
    let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
    let crcyCode = crncy.htmlToString
    cell.time.text = "\(crcyCode) \(self.acntMdlArry[indexPath.row].current_balance!)"
    var tagname = self.acntMdlArry[indexPath.row].account_name!.prefix(1)
    cell.shortNme.text = "\(tagname.uppercased())"
    if(self.acntMdlArry[indexPath.row].account_type == "1")
    {
        cell.Icn.isHidden = true
    }
    else
    {
        cell.Icn.isHidden = false
    }
    //var theme = UserDefaults.standard.value(forKey: "theme")!
//    if(theme as! String == "income")
//    {
//        cell.title.textColor =  UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
//    }
//    else
//    {
//        cell.title.textColor =   UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
//    }
    return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        mngeAcntsViewModel.slctdAcntId = self.acntMdlArry[indexPath.row].account_id!
        mngeAcntsViewModel.slctdAcntName = self.acntMdlArry[indexPath.row].account_name!
        self.acntMngDlgt?.slctTbl()
        
            //self.acntMngDlgt?.acntsTblSelect(acnt: self.acntMdlArry[indexPath.row], acntId: self.crncyIdArry[indexPath.row])
        
            
        
    }
    private func handleDelete(inx:IndexPath) {
//        self.acntMngDlgt?.editAcnt(acntNme:self.acntMdlArry[inx.row].account_name!,intlAmnt:self.acntMdlArry[inx.row].starting_balance!,acntId:self.acntMdlArry[inx.row].account_id!)
        print("Delete \(inx.row)")
        mngeAcntsViewModel.dltAcntId = self.acntMdlArry[inx.row].account_id!
        self.acntMngDlgt?.deleteAlert(acntId:mngeAcntsViewModel.dltAcntId)
//        acntReportViewModel.sltdTrnsId = self.transArry[inx.row].transactionId!
//        acntRprtDlgt?.deleteAlert()
        
        
    }
    private func handleMarkAsFavourite(inx:IndexPath) {
        self.acntMngDlgt?.editAcnt(acntNme:self.acntMdlArry[inx.row].account_name!,intlAmnt:self.acntMdlArry[inx.row].starting_balance!,acntId:self.acntMdlArry[inx.row].account_id!,acntType:self.acntMdlArry[inx.row].account_type! )
        print("Edit \(inx.row)")
    }
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.handleMarkAsFavourite(inx:indexPath)
                                            completionHandler(true)
        }
        action.backgroundColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
        let delete = UIContextualAction(style: .normal,
                                        title: "Delete") { [weak self] (delete, view, completionHandler) in
            self?.handleDelete(inx:indexPath)
                                            completionHandler(true)
        }
        delete.backgroundColor = UIColor.red

        return UISwipeActionsConfiguration(actions: [action,delete])
        
    }
    
}

