//
//  addTrnscnViewModel.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 20/10/22.
//

import Foundation
import Alamofire
import UIKit
import Toaster
import Kingfisher
class editTransactnViewModel:NSObject
{
    var acntId = ""
    var addingTyp = ""
    var crncyOrAcnts = ""
    //var addViewDlgt:editViewUpdt?
    var editTrnscnViewDlgt:editTrnsnViewUpdt?
    var appDlgt:tagProt?
    var indx:IndexPath? = nil
    static var trans = TransactionDet()
    static var incmTagArry:[String] = []
    static var expnsTagArry:[String] = []
    static var incmTagIdArry:[String] = []
    static var expnsTagIdArry:[String] = []
    static var incmTagTypeArry:[String] = []
    static var expnsTagTypeArry:[String] = []
    static var tagsNameArry:[String] = []
    static var tagsIdArry:[String] = []
    static var tagsClrArry:[String] = []
    static var tagsIcnUrlArry:[String] = []
    static var SlctdIndxs:[Int] = []
    static var acntsArry:[String] = []
    var colorArry:[UIColor] = [UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0), UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0),UIColor(red: 68/255, green: 157/255, blue: 245/255, alpha: 1.0),UIColor(red: 81/255, green: 233/255, blue: 192/255, alpha: 1.0), ]
    var crncyArry:[String] = []
    var crncyIdArry:[String] = []
    var crncyCodeArry:[String] = []
    var acntBlncArry:[String] = []
    var crncyMdlArry:[Currencies] = []
    var trnsTyp = ""
    static var tagSlctdId = ""
    static var tagName = ""
    static var icnUrl = ""
    static var slcdIcnColor = UIColor.gray
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
                    
                    editTransactnViewModel.tagsNameArry = []
                    editTransactnViewModel.tagsIdArry = []
                    editTransactnViewModel.tagsClrArry = []
                    editTransactnViewModel.tagsIcnUrlArry = []
                    editTransactnViewModel.trans = TagResponse.transaction![0]
                    self.trnsTyp = TagResponse.transaction![0].transactionType!
                    self.acntId = editTransactnViewModel.trans.accountId!
                    editTransactnViewModel.slcdIcnColor = UIColor(hex: TagResponse.transaction![0].icnClr!)
                    editTransactnViewModel.tagName = TagResponse.transaction![0].tagName!
                    editTransactnViewModel.icnUrl = TagResponse.transaction![0].icnUrl!
                    if let tagIdd = TagResponse.transaction?[0].tagId
                    {
                        editTransactnViewModel.tagSlctdId =  tagIdd
                    }
                    editTransactnViewModel.icnUrl =  TagResponse.transaction![0].icnUrl!
                    editTransactnViewModel.tagName =  TagResponse.transaction![0].tagName!
                    editTransactnViewModel.slcdIcnColor = UIColor(hex:  TagResponse.transaction![0].icnClr!)
//                    for anItem in TagResponse.transaction! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        //self.transArry.append(anItem)
                    if (editTransactnViewModel.trans.tagss != nil)
                    {
                        
                        for tag in editTransactnViewModel.trans.tagss! as Array {
                            print(tag.tagName!)
                            
                            
                            
                            
                            editTransactnViewModel.tagsNameArry.append(tag.tagName!)
                            editTransactnViewModel.tagsIdArry.append(tag.tagId!)
                            editTransactnViewModel.tagsClrArry.append(tag.tagClr!)
                            editTransactnViewModel.tagsIcnUrlArry.append(tag.tagUrl!)
                            
                        }
                    }
                    // do something with personName and personID
                    //}
                    //print(self.transArry)
                    self.editTrnscnViewDlgt?.fills()
                }
                catch let err{
                    //self.dashDlgt?.recentTblUpdt(trnsCnt:"0")
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
                    editTransactnViewModel.incmTagArry = []
                    editTransactnViewModel.expnsTagArry = []
                    editTransactnViewModel.incmTagIdArry = []
                    editTransactnViewModel.expnsTagIdArry = []
                    editTransactnViewModel.incmTagTypeArry = []
                    editTransactnViewModel.expnsTagTypeArry = []
                    
                    editTransactnViewModel.usrIncTagArry = []
                    editTransactnViewModel.usrExpTagArry = []
                    for anItem in TagResponse.tags! as Array {
                        
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        if(anItem.tagType == "1")
                        {
                            editTransactnViewModel.usrIncTagArry.append(anItem)
                            
                            editTransactnViewModel.incmTagArry.append(anItem.tagName!)
                            editTransactnViewModel.incmTagIdArry.append(anItem.tagId!)
                            editTransactnViewModel.incmTagTypeArry.append("addedTag")
                        }
                        else
                        {
                            editTransactnViewModel.usrExpTagArry.append(anItem)
                            editTransactnViewModel.expnsTagArry.append(anItem.tagName!)
                            editTransactnViewModel.expnsTagIdArry.append(anItem.tagId!)
                            editTransactnViewModel.expnsTagTypeArry.append("addedTag")
                        }
                        
                        
                    // do something with personName and personID
                    }
                    
//                    UserDefaults.standard.set(AddDataViewModel.incmTagIdArry, forKey: "incDefltIdTags")
//                    UserDefaults.standard.set(AddDataViewModel.expnsTagIdArry, forKey: "expDefltIdTags")
//                    UserDefaults.standard.set(AddDataViewModel.incmTagArry, forKey: "incDefltTags")
//                    UserDefaults.standard.set(AddDataViewModel.expnsTagArry, forKey: "expDefltTags")
                    
                    //self.addViewDlgt?.updtTags(tags: self.tagArry)
                    //self.appDlgt?.updtDefTags(incTags: self.incmTagArry,expnsTags: self.expnsTagArry)
//                    DispatchQueue.main.async {
//                        self.editTrnscnViewDlgt?.Tags()
//
//                    }
                    self.getDefltTags()
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
//                    editTransactnViewModel.incmTagArry = []
//                    editTransactnViewModel.expnsTagArry = []
                    for anItem in TagResponse.tags! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        if(anItem.tagType == "1")
                        {
                            if(editTransactnViewModel.incmTagArry.contains(anItem.tagName!)){
                                
                            }
                            else
                            {
                                editTransactnViewModel.defIncmTagArry.append(anItem)
                                editTransactnViewModel.incmTagArry.append(anItem.tagName!)
                                editTransactnViewModel.incmTagIdArry.append(anItem.tagId!)
                                editTransactnViewModel.incmTagTypeArry.append("defaultTag")
                            }
                        }
                        else
                        {
                            if(editTransactnViewModel.expnsTagArry.contains(anItem.tagName!)){
                                
                            }
                            else
                            {
                                editTransactnViewModel.defExpTagArry.append(anItem)
                                editTransactnViewModel.expnsTagArry.append(anItem.tagName!)
                                editTransactnViewModel.expnsTagIdArry.append(anItem.tagId!)
                                editTransactnViewModel.expnsTagTypeArry.append("defaultTag")
                            }
                        }
                        
                        
                    // do something with personName and personID
                    }
                    UserDefaults.standard.set(editTransactnViewModel.incmTagIdArry, forKey: "incDefltIdTags")
                    UserDefaults.standard.set(editTransactnViewModel.expnsTagIdArry, forKey: "expDefltIdTags")
                    
                    DispatchQueue.main.async {
                        self.editTrnscnViewDlgt?.Tags()
                        
                    }
                    
                    //self.addViewDlgt?.updtTags(tags: self.tagArry)
                    //self.appDlgt?.updtDefTags(incTags: self.incmTagArry,expnsTags: self.expnsTagArry)
                }
                catch let err{
                    print(err)
                }
            }
        }
        
    }
    func getCurrency()
    {
        AF.request(APImanager.GetCrncyAPI(),method: .get,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            
            response in
            if let data = response.data
            {
                do{
                    self.crncyArry = []
                    self.crncyIdArry = []
                    self.crncyCodeArry = []
                    let CrncyResponse  = try
                    JSONDecoder().decode(CurrencyModel.self, from: data)
                    print(CrncyResponse.currencies!)
                    for anItem in CrncyResponse.currencies! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        self.crncyMdlArry.append(anItem)
                        self.crncyArry.append(anItem.currency_name!)
                        self.crncyIdArry.append(anItem.currency_id!)
                        self.crncyCodeArry.append(anItem.currency_code!)
                    // do something with personName and personID
                    }
                    self.crncyOrAcnts = "currency"
                    self.editTrnscnViewDlgt?.updtCrncy(TblTyp: "currency")
                }
                catch let err{
                    print(err)
                }
            }
        }
        
    }
    func getAcnts(typ:String)
    {
        AF.request(APImanager.GetAccounts(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!],encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            
            response in
            if let data = response.data
            {
                do{
                    self.crncyArry = []
                    self.crncyIdArry = []
                    self.acntBlncArry = []
                    let AcntsResponse  = try
                    JSONDecoder().decode(AccountsModel.self, from: data)
                    print(AcntsResponse.accounts!)
                    for anItem in AcntsResponse.accounts! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        self.crncyArry.append(anItem.account_name!)
                        self.crncyIdArry.append(anItem.account_id!)
                        self.acntBlncArry.append(anItem.current_balance!)
                    // do something with personName and personID
                    }
                    editTransactnViewModel.acntsArry = self.crncyIdArry
                    self.crncyOrAcnts = "account"
                    self.editTrnscnViewDlgt?.loadAcntCln()
                    self.editTrnscnViewDlgt?.updtCrncy(TblTyp: "account")
                    if(typ == "trnscn")
                    {
                        self.addingTyp = "trnscn"
                    }
                    else if(typ == "from")
                    {
                        self.addingTyp = "from"
                    }
                    else if(typ == "to")
                    {
                        self.addingTyp = "to"
                    }
                }
                catch let err{
                    print(err)
                }
            }
        }
        
    }
    func addAcnt(acntNme:String,acntIntAmnt:String,crncyId:String,crncy:String,crncyCode:String)
    {
        AF.request(APImanager.addAcntAPI(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"account_name":acntNme,"starting_balance":acntIntAmnt,"currency_id":crncyId] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let acntResponse  = try
                    JSONDecoder().decode(AddDataModel.self, from: data)
                    if(acntResponse.addresult != nil)
                    {
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
                            //self.addViewDlgt?.valdteAcntcrncy(alrtStr: acntResponse.addresult!.message!)
                            UserDefaults.standard.set("1", forKey: "acnt")
                            UserDefaults.standard.set(crncy, forKey: "crncy")
                            UserDefaults.standard.set(crncyCode, forKey: "crncyCode")
                            UserDefaults.standard.set("1", forKey: "accountExist")
                            self.editTrnscnViewDlgt?.closeSetAcntView()
                        }
                    }
                    
                }
                catch let err{
                    print(err)
                }
            }
        }
        
    }
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
        AF.request(api,method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"transaction_amount":amnt,"account_id":acnt,"transaction_text":descr,"cleared_date":date,"tag_ids":editTransactnViewModel.tagSlctdId,"tags":"","transaction_id":acntReportViewModel.sltdTrnsId] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
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
                        if(type == "1")
                        {
                            ToastView.appearance().backgroundColor = ColorManager.incomeColor()
                        }
                        else
                        {
                            ToastView.appearance().backgroundColor = ColorManager.expenseColor()
                        }
                        ToastView.appearance().textColor = .white
                        //self.addViewDlgt?.valdteAcntcrncy(alrtStr: acntResponse.addresult!.message!)
                        
                            self.editTrnscnViewDlgt?.BackAfterDataAdd()
                        
                        //self.addViewDlgt?.closeSetAcntView()
                        
                    }
                    
                }
                catch let err{
                    print(err)
                }
            }
        }
        
    }
    func editTrnsfr(amnt:String,descr:String,frmAcnt:String,toAcnt:String,date:String,tag:String,type:String,usertags:String)
    {
        
        AF.request(APImanager.EditTrnsfr(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"transaction_amount":amnt,"from_account_id":frmAcnt,"to_account_id":toAcnt,"transaction_text":descr,"cleared_date":date,"tag_ids":tag,"tags":usertags,"transaction_id":acntReportViewModel.sltdTrnsId] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let acntResponse  = try
                    JSONDecoder().decode(AddDataModel.self, from: data)
                    //print(acntResponse.addresult!.message!)
//                    for anItem in acntResponse.tags! as Array {
//
//                        self.tagArry.append(anItem.tagName!)
//
//                    // do something with personName and personID
//                    }
                    DispatchQueue.main.async {
                        Toast(text: acntResponse.addresult!.message!).show()
                        ToastView.appearance().backgroundColor = ColorManager.transferColor()
                        //self.addViewDlgt?.valdteAcntcrncy(alrtStr: acntResponse.addresult!.message!)
                        
                            self.editTrnscnViewDlgt?.BackAfterDataAdd()
                        
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
//    func validateIncmExpsAddiotion(amnt:String,descrptn:String,acnt:String,date:String,tag:[String],typeVal:String,userTags:[String])
//    {
//        if(amnt == "")
//        {
//            self.addViewDlgt?.valdteAcntcrncy(alrtStr: "Please Enter Amount !")
//        }
//        else if (descrptn == "")
//        {
//            self.addViewDlgt?.valdteAcntcrncy(alrtStr: "Please Enter Description !")
//        }
//        else if (acnt == "")
//        {
//            self.addViewDlgt?.valdteAcntcrncy(alrtStr: "Please Select Account Name !")
//        }
//        else if (date == "")
//        {
//            self.addViewDlgt?.valdteAcntcrncy(alrtStr: "Please Select Date !")
//        }
//        else if (tag.count == 0)&&(userTags.count == 0)
//        {
//            self.addViewDlgt?.valdteAcntcrncy(alrtStr: "Please Select a Tag !")
//        }
//        else
//        {
//            DispatchQueue.global().async {
//
//                self.addInc(amnt: amnt, descr: descrptn, acnt: acnt, date: date, tag: tag.joined(separator: ", "),type:typeVal, usertags: userTags.joined(separator: ", "))
//            }
//
//            //self.addCrncyAcnt()
//        }
//    }
}
extension editTransactnViewModel: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.crncyArry.count
    }
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "acntlist", for: indexPath) as! recentTblViewCell
    cell.title.text = "\(self.crncyArry[indexPath.row])"
    var tagname = self.crncyArry[indexPath.row].prefix(1)
    cell.shortNme.text = "\(tagname.uppercased())"
    let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
    let crcyCode = crncy.htmlToString
    cell.time.text = "\(crcyCode) \(self.acntBlncArry[indexPath.row])"
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
        
        if(crncyOrAcnts == "currency")
        {
            self.editTrnscnViewDlgt?.crncyTblSelect(crncy: self.crncyArry[indexPath.row], crncyId: self.crncyIdArry[indexPath.row],crncycode:self.crncyCodeArry[indexPath.row])
            
            UserDefaults.standard.set(self.crncyMdlArry[indexPath.row].currency_code, forKey:"crncyCode")
            UserDefaults.standard.set(self.crncyMdlArry[indexPath.row].currency_id, forKey:"crncyId")
            UserDefaults.standard.set(self.crncyMdlArry[indexPath.row].currency_name, forKey:"crncyName")
            
        }
        else
        {
            if(self.addingTyp == "trnscn")
            {
                self.editTrnscnViewDlgt?.acntsTblSelect(acnt: self.crncyArry[indexPath.row], acntId: self.crncyIdArry[indexPath.row])
            }
            else if(self.addingTyp == "from")
            {
            
                self.editTrnscnViewDlgt?.trnsfrAcntSelect(acnt: self.crncyArry[indexPath.row], acntId: self.crncyIdArry[indexPath.row],typ:"from")
            }
            else if(self.addingTyp == "to")
            {
                self.editTrnscnViewDlgt?.trnsfrAcntSelect(acnt: self.crncyArry[indexPath.row], acntId: self.crncyIdArry[indexPath.row],typ:"to")
            }
            
        }
            
        
    }
    
}
extension editTransactnViewModel:UICollectionViewDataSource,UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView.tag == 1)
        {
            return self.crncyArry.count
        }
        else
        {
            if(self.trnsTyp == "1")
            {
                return editTransactnViewModel.usrIncTagArry.count
            }
            else if(self.trnsTyp == "2")
            {
                return editTransactnViewModel.usrExpTagArry.count
            }
            print("tag Collection")
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView.tag == 1)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crncyCell", for: indexPath) as! tagsViewCell
            if(self.crncyIdArry[indexPath.row] == self.acntId)
            {
                
                cell.layer.borderWidth = 3.5
            }
            else
            {
                cell.layer.borderWidth = 0.0
            }
            cell.layer.borderColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0).cgColor
            //        let mydata = tagmanageViewModel.tagArry1[indexPath.item]
            //        let tagData = tagmanageViewModel.tagArry1[indexPath.item]
            //cell.bgLbl.cornerRadius = 8
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            cell.tagshort.cornerRadius = cell.tagshort.frame.height/2
            //cell.tagName.text = mydata
            var tagname = "\(self.crncyArry[indexPath.row])".prefix(1)
            cell.tagshort.text = "\(tagname.uppercased())"
            var clrInd = indexPath.row % 4
            cell.tagshort.backgroundColor = self.colorArry[clrInd]
            cell.tagName.text = "\(self.crncyArry[indexPath.row])"
            let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
            let crcyCode = crncy.htmlToString
            cell.amount.text = "\(crcyCode) \(self.acntBlncArry[indexPath.row])"
            
            return cell
        }
        else if(collectionView.tag == 2)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as! tagsViewCell
            cell.layer.borderWidth = 0.0
            cell.layer.borderColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0).cgColor
            
            //cell.bgLbl.cornerRadius = 8
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            cell.tagshort.cornerRadius = cell.tagshort.frame.height/2
            //cell.tagName.text = mydata
            
//            if(self.IncExpTypVal == "1")
//            {
            if(self.trnsTyp == "1")
            {
                let mydata = editTransactnViewModel.usrIncTagArry[indexPath.item]
                var tagname = mydata.tagName!.prefix(1)
                cell.tagshort.text = "\(tagname.uppercased())"
                cell.tagName.text = mydata.tagName!
                if let url = URL(string: "\(mydata.iconUrl!)") {
                    let processor = OverlayImageProcessor(overlay: UIColor(hex: mydata.iconClor!), fraction: 0.1)
                    
                            // Load the image with Kingfisher and apply the tint
    //                           self.ctgryIcon.kf.setImage(
    //                                       with: url)
                    cell.tagImg.kf.setImage(with: url, options: [.processor(processor)])
                    
                        }
                cell.tagshort.backgroundColor = UIColor(hex: mydata.iconClor!)
                cell.tagshort.alpha = 0.2
                //cell.tagshort.backgroundColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
                //cell.tagshort.backgroundColor = ColorManager.incomeColor()
            }
            else if(self.trnsTyp == "2")
            {
                let mydata = editTransactnViewModel.usrExpTagArry[indexPath.item]
                var tagname = mydata.tagName!.prefix(1)
                cell.tagshort.text = "\(tagname.uppercased())"
                cell.tagName.text = mydata.tagName!
                if let url = URL(string: "\(mydata.iconUrl!)") {
                    let processor = OverlayImageProcessor(overlay: UIColor(hex: mydata.iconClor!), fraction: 0.1)
                    
                            // Load the image with Kingfisher and apply the tint
    //                           self.ctgryIcon.kf.setImage(
    //                                       with: url)
                    cell.tagImg.kf.setImage(with: url, options: [.processor(processor)])
                    
                        }
                cell.tagshort.backgroundColor = UIColor(hex: mydata.iconClor!)
                cell.tagshort.alpha = 0.2
                //cell.tagshort.backgroundColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
                //cell.tagshort.backgroundColor = ColorManager.expenseColor()
            }
                //let tagData = tagmanageViewModel.tagArry1[indexPath.item]
                
            //}
//            else
//            {
//                //cell.tagshort.backgroundColor = UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
//                cell.tagshort.backgroundColor = ColorManager.expenseColor()
//
//            }
       
            return cell
        }
        let fallbackCell = UICollectionViewCell()
            fallbackCell.backgroundColor = .clear // Optional: Visual indication for debugging
            return fallbackCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView.tag == 1)
        {
        if(self.addingTyp == "trnscn")
        {
            let indexOfAcnt = self.crncyIdArry.firstIndex(of: self.acntId)
            let indexPaths = NSIndexPath(row: indexOfAcnt!, section: 0)
            let cell2 = collectionView.cellForItem(at: indexPaths as IndexPath)
            cell2?.layer.borderWidth = 0.0
        }
        if(self.indx != nil)
        {
            let cell1 = collectionView.cellForItem(at: self.indx!)
            cell1?.layer.borderWidth = 0.0
        }
        self.indx = indexPath
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 3.5
        cell?.layer.borderColor = ColorManager.incomeColor().cgColor
        //        let mydata = tagmanageViewModel.tagArry1[indexPath.item]
        //        let tagData = tagmanageViewModel.tagArry1[indexPath.item]
        //cell.bgLbl.cornerRadius = 8
        cell?.layer.cornerRadius = 8
        cell?.layer.masksToBounds = true
        
        if(self.addingTyp == "trnscn")
        {
            self.editTrnscnViewDlgt?.acntsTblSelect(acnt: self.crncyArry[indexPath.row], acntId: self.crncyIdArry[indexPath.row])
        }
        else if(self.addingTyp == "from")
        {
            
            self.editTrnscnViewDlgt?.trnsfrAcntSelect(acnt: self.crncyArry[indexPath.row], acntId: self.crncyIdArry[indexPath.row],typ:"from")
        }
        else if(self.addingTyp == "to")
        {
            self.editTrnscnViewDlgt?.trnsfrAcntSelect(acnt: self.crncyArry[indexPath.row], acntId: self.crncyIdArry[indexPath.row],typ:"to")
        }
        //            let cell = collectionView.cellForItem(at: indexPath)
        //            cell?.layer.borderWidth = 2.0
        //            cell?.layer.borderColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0).cgColor
        //            let mydata = tagmanageViewModel.tagArry1[indexPath.item]
        //
        //            //print(self.slctdTagArry)
        //
        //
        //        self.editTag(tagNme: mydata.tagName!, tagType: mydata.tagType!, tagId: mydata.tagId!)
        //
    }
        else if(collectionView.tag == 2)
        {
            if(self.trnsTyp == "1")
            {
                editTransactnViewModel.tagSlctdId = editTransactnViewModel.usrIncTagArry[indexPath.item].tagId!
                self.editTrnscnViewDlgt?.clkCtgryFill(ctgryNme: editTransactnViewModel.usrIncTagArry[indexPath.item].tagName!, ctgryId: editTransactnViewModel.usrIncTagArry[indexPath.item].tagId!,tagIcnUrl: editTransactnViewModel.usrIncTagArry[indexPath.item].iconUrl!,tagIcnClr: UIColor(hex: editTransactnViewModel.usrIncTagArry[indexPath.item].iconClor!))
            }
            else if(self.trnsTyp == "2")
            {
                editTransactnViewModel.tagSlctdId = editTransactnViewModel.usrExpTagArry[indexPath.item].tagId!
                self.editTrnscnViewDlgt?.clkCtgryFill(ctgryNme: editTransactnViewModel.usrExpTagArry[indexPath.item].tagName!, ctgryId: editTransactnViewModel.usrExpTagArry[indexPath.item].tagId!,tagIcnUrl: editTransactnViewModel.usrExpTagArry[indexPath.item].iconUrl!,tagIcnClr: UIColor(hex: editTransactnViewModel.usrExpTagArry[indexPath.item].iconClor!))
            }
        }
        
    }
    
    
    
    
    
    
}
