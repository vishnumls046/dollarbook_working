//
//  AddDataViewModel.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 20/10/22.
//

import Foundation
import Alamofire
import UIKit
class editTrnscnViewModel:NSObject
{
    var crncyOrAcnts = ""
    var editViewDlgt:editViewUpdt?
    var dashViewDlgt:dashUpdateUIProt?
    var appDlgt:tagProt?
    static var incmTagArry:[String] = []
    static var expnsTagArry:[String] = []
    static var incmTagIdArry:[String] = []
    static var expnsTagIdArry:[String] = []
    static var trans = TransactionDet()
    static var tagsNameArry:[String] = []
    static var tagsIdArry:[String] = []
    var crncyArry:[String] = []
    var crncyIdArry:[String] = []
    
//    var crncyCodeArry:[String] = []
//    var crncyMdlArry:[Currencies] = []
    static var slctdTagId = ""
    static var defIncmTagArry = [Tags]()
    static var usrIncTagArry = [Tags]()
    static var defExpTagArry = [Tags]()
    static var usrExpTagArry = [Tags]()
    
    func getTransactionValues()
    {
        AF.request(APImanager.TnscnDetail(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"transaction_id":acntReportViewModel.sltdTrnsId] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let TagResponse  = try
                    JSONDecoder().decode(TrnsDetModel.self, from: data)
                    //print(TagResponse.transaction!)
                    editTrnscnViewModel.tagsNameArry = []
                    editTrnscnViewModel.tagsIdArry = []
                    editTrnscnViewModel.trans = TagResponse.transaction![0]
//                    for anItem in TagResponse.transaction! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        //self.transArry.append(anItem)
                    if (editTrnscnViewModel.trans.tagss != nil)
                    {
                        for tag in editTrnscnViewModel.trans.tagss! as Array {
                            print(tag.tagName!)
                            editTrnscnViewModel.tagsNameArry.append(tag.tagName!)
                            editTrnscnViewModel.tagsIdArry.append(tag.tagId!)
                        }
                    }
                    // do something with personName and personID
                    //}
                    //print(self.transArry)
                    //self.editViewDlgt?.fillValues()
                }
                catch let err{
                    //self.dashDlgt?.recentTblUpdt(trnsCnt:"0")
                    print(err)
                }
            }
        }
        
    }
    func deleteTrscns(page:String)
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
                    
                        if(page == "dash")
                        {
                            DispatchQueue.main.async {
                                self.dashViewDlgt?.alerts(alrtStr: acntResponse.addresult!.message!)
                            }
                            
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
                    editTrnscnViewModel.incmTagArry = []
                    editTrnscnViewModel.expnsTagArry = []
                    for anItem in TagResponse.tags! as Array {
                        
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        if(anItem.tagType == "1")
                        {
                            editTrnscnViewModel.usrIncTagArry.append(anItem)
                            
                            editTrnscnViewModel.incmTagArry.append(anItem.tagName!)
                            editTrnscnViewModel.incmTagIdArry.append(anItem.tagId!)
                        }
                        else
                        {
                            editTrnscnViewModel.usrExpTagArry.append(anItem)
                            editTrnscnViewModel.expnsTagArry.append(anItem.tagName!)
                            editTrnscnViewModel.expnsTagIdArry.append(anItem.tagId!)
                        }
                        
                        
                    // do something with personName and personID
                    }
                    
//                    UserDefaults.standard.set(AddDataViewModel.incmTagIdArry, forKey: "incDefltIdTags")
//                    UserDefaults.standard.set(AddDataViewModel.expnsTagIdArry, forKey: "expDefltIdTags")
//                    UserDefaults.standard.set(AddDataViewModel.incmTagArry, forKey: "incDefltTags")
//                    UserDefaults.standard.set(AddDataViewModel.expnsTagArry, forKey: "expDefltTags")
                    
                    //self.addViewDlgt?.updtTags(tags: self.tagArry)
                    //self.appDlgt?.updtDefTags(incTags: self.incmTagArry,expnsTags: self.expnsTagArry)
                    
                }
                catch let err{
                    self.getDefltTags()
                    print(err)
                }
            }
        }
        
    }
    func getDefltTags()
    {
        AF.request(APImanager.GetDefltTags(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let TagResponse  = try
                    JSONDecoder().decode(TagsModel.self, from: data)
                    print(TagResponse.tags!)
                    editTrnscnViewModel.incmTagArry = []
                    editTrnscnViewModel.expnsTagArry = []
                    for anItem in TagResponse.tags! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        if(anItem.tagType == "1")
                        {
                            editTrnscnViewModel.defIncmTagArry.append(anItem)
                            editTrnscnViewModel.incmTagArry.append(anItem.tagName!)
                            editTrnscnViewModel.incmTagIdArry.append(anItem.tagId!)
                        }
                        else
                        {
                            editTrnscnViewModel.defExpTagArry.append(anItem)
                            editTrnscnViewModel.expnsTagArry.append(anItem.tagName!)
                            editTrnscnViewModel.expnsTagIdArry.append(anItem.tagId!)
                        }
                        
                        
                    // do something with personName and personID
                    }
                    UserDefaults.standard.set(editTrnscnViewModel.incmTagIdArry, forKey: "incDefltIdTags")
                    UserDefaults.standard.set(editTrnscnViewModel.expnsTagIdArry, forKey: "expDefltIdTags")
                    //self.addViewDlgt?.updtTags(tags: self.tagArry)
                    //self.appDlgt?.updtDefTags(incTags: self.incmTagArry,expnsTags: self.expnsTagArry)
                }
                catch let err{
                    print(err)
                }
            }
        }
        
    }
//    func getCurrency()
//    {
//        AF.request(APImanager.GetCrncyAPI(),method: .get,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
//        {
//
//            response in
//            if let data = response.data
//            {
//                do{
//                    self.crncyArry = []
//                    self.crncyIdArry = []
//                    self.crncyCodeArry = []
//                    let CrncyResponse  = try
//                    JSONDecoder().decode(CurrencyModel.self, from: data)
//                    print(CrncyResponse.currencies!)
//                    for anItem in CrncyResponse.currencies! as Array {
//                        //let tagName = anItem.tagName as! String
//                      //let tagID = anItem["tag_id"] as! String
//                        self.crncyMdlArry.append(anItem)
//                        self.crncyArry.append(anItem.currency_name!)
//                        self.crncyIdArry.append(anItem.currency_id!)
//                        self.crncyCodeArry.append(anItem.currency_code!)
//                    // do something with personName and personID
//                    }
//                    self.crncyOrAcnts = "currency"
//                    self.addViewDlgt?.updtCrncy(TblTyp: "currency")
//                }
//                catch let err{
//                    print(err)
//                }
//            }
//        }
//
//    }
    func getAcnts()
    {
        AF.request(APImanager.GetAccounts(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!],encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            
            response in
            if let data = response.data
            {
                do{
                    self.crncyArry = []
                    self.crncyIdArry = []
                    let AcntsResponse  = try
                    JSONDecoder().decode(AccountsModel.self, from: data)
                    print(AcntsResponse.accounts!)
                    for anItem in AcntsResponse.accounts! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        self.crncyArry.append(anItem.account_name!)
                        self.crncyIdArry.append(anItem.account_id!)
                        
                    // do something with personName and personID
                    }
                    self.crncyOrAcnts = "account"
                    self.editViewDlgt?.updtCrncy(TblTyp: "account")
                }
                catch let err{
                    print(err)
                }
            }
        }
        
    }
//    func addAcnt(acntNme:String,acntIntAmnt:String,crncyId:String,crncy:String,crncyCode:String)
//    {
//        AF.request(APImanager.addAcntAPI(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"account_name":acntNme,"starting_balance":acntIntAmnt,"currency_id":crncyId] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
//        {
//            response in
//            if let data = response.data
//            {
//                do{
//                    let acntResponse  = try
//                    JSONDecoder().decode(AddDataModel.self, from: data)
//                    print(acntResponse.addresult!.message!)
////                    for anItem in acntResponse.tags! as Array {
////
////                        self.tagArry.append(anItem.tagName!)
////
////                    // do something with personName and personID
////                    }
//                    DispatchQueue.main.async {
//                        self.addViewDlgt?.valdteAcntcrncy(alrtStr: acntResponse.addresult!.message!)
//                        UserDefaults.standard.set("1", forKey: "acnt")
//                        UserDefaults.standard.set(crncy, forKey: "crncy")
//                        UserDefaults.standard.set(crncyCode, forKey: "crncyCode")
//                        UserDefaults.standard.set("1", forKey: "accountExist")
//                        self.addViewDlgt?.closeSetAcntView()
//                    }
//
//                }
//                catch let err{
//                    print(err)
//                }
//            }
//        }
//
//    }
    func editInc(amnt:String,descr:String,acnt:String,date:String,tag:String,type:String,usertags:String)
    {
        
        var api = ""
        if(type == "1")
        {
           api = APImanager.EditIncome()
        }
        else
        {
            api = APImanager.EditExpense()
        }
        AF.request(api,method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"transaction_amount":amnt,"account_id":acnt,"transaction_text":descr,"cleared_date":date,"tag_ids":tag,"tags":usertags,"transaction_id":acntReportViewModel.sltdTrnsId] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
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
                        self.editViewDlgt?.alerts(alrtStr: acntResponse.addresult!.message!)
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
//                            self.editViewDlgt?.BackAfterDataAdd()
//                        })
                        //self.addViewDlgt?.closeSetAcntView()
                        
                    }
                    
                }
                catch let err{
                    print(err)
                }
            }
        }
        
    }
    //*************  Add Currency & Account Validation and Alert *************//
//    func validateAcntCrncy(crncy:String,acnt:String,intlAmnt:String,crncyIdVal:String,crncyCode:String)
//    {
//        if(crncy == "")
//        {
//            self.addViewDlgt?.valdteAcntcrncy(alrtStr: "Please Select Currency !")
//        }
//        else if (acnt == "")
//        {
//            self.addViewDlgt?.valdteAcntcrncy(alrtStr: "Please Enter Account Name !")
//        }
//        else if (intlAmnt == "")
//        {
//            self.addViewDlgt?.valdteAcntcrncy(alrtStr: "Please Enter Initial Amount !")
//        }
//        else
//        {
//            DispatchQueue.global().async {
//                self.addAcnt(acntNme: acnt,acntIntAmnt:intlAmnt, crncyId: crncyIdVal,crncy:crncy,crncyCode:crncyCode)
//            }
//
//            //self.addCrncyAcnt()
//        }
//    }
    
//    func addCrncyAcnt()
//    {
//        UserDefaults.standard.set("1", forKey: "acnt")
//        UserDefaults.standard.set("1", forKey: "crncy")
//
//        self.addViewDlgt?.closeSetAcntView()
//    }
    
    //*************  Add Income Expense Validation and Alert *************//
    func validateIncmExpsAddiotion(amnt:String,descrptn:String,acnt:String,date:String,tag:[String],typeVal:String,userTags:[String])
    {
        if(amnt == "")
        {
            self.editViewDlgt?.valdteAcntcrncy(alrtStr: "Please Enter Amount !")
        }
        else if (descrptn == "")
        {
            self.editViewDlgt?.valdteAcntcrncy(alrtStr: "Please Enter Description !")
        }
        else if (acnt == "")
        {
            self.editViewDlgt?.valdteAcntcrncy(alrtStr: "Please Select Account Name !")
        }
        else if (date == "")
        {
            self.editViewDlgt?.valdteAcntcrncy(alrtStr: "Please Select Date !")
        }
        else if (tag.count == 0)&&(userTags.count == 0)
        {
            self.editViewDlgt?.valdteAcntcrncy(alrtStr: "Please Select a Tag !")
        }
        else
        {
            DispatchQueue.global().async {
                
                self.editInc(amnt: amnt, descr: descrptn, acnt: acnt, date: date, tag: tag.joined(separator: ", "),type:typeVal, usertags: userTags.joined(separator: ", "))
            }
            
            //self.addCrncyAcnt()
        }
    }
}
extension editTrnscnViewModel: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.crncyArry.count
    }
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "listRecent", for: indexPath) as! recentTblViewCell
    cell.title.text = "\(self.crncyArry[indexPath.row])"
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

//        if(crncyOrAcnts == "currency")
//        {
//            self.editViewDlgt?.crncyTblSelect(crncy: self.crncyArry[indexPath.row], crncyId: self.crncyIdArry[indexPath.row],crncycode:self.crncyCodeArry[indexPath.row])
//
//            UserDefaults.standard.set(self.crncyMdlArry[indexPath.row].currency_code, forKey:"crncyCode")
//            UserDefaults.standard.set(self.crncyMdlArry[indexPath.row].currency_id, forKey:"crncyId")
//            UserDefaults.standard.set(self.crncyMdlArry[indexPath.row].currency_name, forKey:"crncyName")
//
//        }
//        else
//        {
            self.editViewDlgt?.acntsTblSelect(acnt: self.crncyArry[indexPath.row], acntId: self.crncyIdArry[indexPath.row])
        //}


    }
    
}

