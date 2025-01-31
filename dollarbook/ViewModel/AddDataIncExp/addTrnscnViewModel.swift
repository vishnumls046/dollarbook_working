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
class addTrnscnViewModel:NSObject
{
    var addingTyp = ""
    var crncyOrAcnts = ""
    var addViewDlgt:addViewUpdt?
    var addTrnscnViewDlgt:addTrnsnViewUpdt?
    var appDlgt:tagProt?
    var indx:IndexPath? = nil
    static var incmTagArry:[String] = []
    static var expnsTagArry:[String] = []
    static var incmTagIdArry:[String] = []
    static var expnsTagIdArry:[String] = []
    static var incmTagTypeArry:[String] = []
    static var expnsTagTypeArry:[String] = []
    
    var colorArry:[UIColor] = [UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0), UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0),UIColor(red: 68/255, green: 157/255, blue: 245/255, alpha: 1.0),UIColor(red: 81/255, green: 233/255, blue: 192/255, alpha: 1.0), ]
    var crncyArry:[String] = []
    var crncyIdArry:[String] = []
    var crncyCodeArry:[String] = []
    var acntBlncArry:[String] = []
    var crncyMdlArry:[Currencies] = []
    var incmTagsArry = [Tags]()
    var expnTagsArry = [Tags]()
    static var defIncmTagArry = [Tags]()
    static var usrIncTagArry = [Tags]()
    static var defExpTagArry = [Tags]()
    static var usrExpTagArry = [Tags]()
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
                    addTrnscnViewModel.incmTagArry = []
                    addTrnscnViewModel.expnsTagArry = []
                    addTrnscnViewModel.incmTagIdArry = []
                    addTrnscnViewModel.expnsTagIdArry = []
                    addTrnscnViewModel.incmTagTypeArry = []
                    addTrnscnViewModel.expnsTagTypeArry = []
                    self.incmTagsArry = []
                    self.expnTagsArry = []
                    for anItem in TagResponse.tags! as Array {
                        
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        if(anItem.tagType == "1")
                        {
                            self.incmTagsArry.append(anItem)
                            addTrnscnViewModel.usrIncTagArry.append(anItem)
                            
                            addTrnscnViewModel.incmTagArry.append(anItem.tagName!)
                            addTrnscnViewModel.incmTagIdArry.append(anItem.tagId!)
                            addTrnscnViewModel.incmTagTypeArry.append("addedTag")
                        }
                        else
                        {
                            self.expnTagsArry.append(anItem)
                            addTrnscnViewModel.usrExpTagArry.append(anItem)
                            addTrnscnViewModel.expnsTagArry.append(anItem.tagName!)
                            addTrnscnViewModel.expnsTagIdArry.append(anItem.tagId!)
                            addTrnscnViewModel.expnsTagTypeArry.append("addedTag")
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
//                        self.addTrnscnViewDlgt?.Tags()
//
//                    }
                    self.getDefltTags()
                }
                catch let err{
                    self.getDefltTags()
                    //self.getDefltTags()
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
                    
                    for anItem in TagResponse.tags! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        if(anItem.tagType == "1")
                        {
                            if(addTrnscnViewModel.incmTagArry.contains(anItem.tagName!)){
                                
                            }
                            else
                            {
                                addTrnscnViewModel.defIncmTagArry.append(anItem)
                                addTrnscnViewModel.incmTagArry.append(anItem.tagName!)
                                addTrnscnViewModel.incmTagIdArry.append(anItem.tagId!)
                                addTrnscnViewModel.incmTagTypeArry.append("defaultTag")
                            }
                        }
                        else
                        {
                            if(addTrnscnViewModel.expnsTagArry.contains(anItem.tagName!)){
                                
                            }
                            else
                            {
                                addTrnscnViewModel.defExpTagArry.append(anItem)
                                addTrnscnViewModel.expnsTagArry.append(anItem.tagName!)
                                addTrnscnViewModel.expnsTagIdArry.append(anItem.tagId!)
                                addTrnscnViewModel.expnsTagTypeArry.append("defaultTag")
                            }
                        }
                        
                        
                    // do something with personName and personID
                    }
                    //self.getTags()
                    UserDefaults.standard.set(addTrnscnViewModel.incmTagIdArry, forKey: "incDefltIdTags")
                    UserDefaults.standard.set(addTrnscnViewModel.expnsTagIdArry, forKey: "expDefltIdTags")
                    
                    DispatchQueue.main.async {
                        self.addTrnscnViewDlgt?.Tags()
                        
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
        AF.request(APImanager.GetCrncyAPI(),method: .post,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
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
                    self.addTrnscnViewDlgt?.updtCrncy(TblTyp: "currency")
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
                    if(AcntsResponse.accounts!.count > 0)
                    {
                        UserDefaults.standard.set("1", forKey: "accountExist")
                    }
                    else
                    {
                        UserDefaults.standard.set("0", forKey: "accountExist")
                    }
                    for anItem in AcntsResponse.accounts! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        self.crncyArry.append(anItem.account_name!)
                        self.crncyIdArry.append(anItem.account_id!)
                        self.acntBlncArry.append(anItem.current_balance!)
                        
                    // do something with personName and personID
                    }
                    self.crncyOrAcnts = "account"
                    self.addTrnscnViewDlgt?.loadAcntCln()
                    self.addTrnscnViewDlgt?.updtCrncy(TblTyp: "account")
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
    func addAcnt(acntNme:String,acntIntAmnt:String)
    {
        AF.request(APImanager.addAcntAPI(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"account_name":acntNme,"starting_balance":Float(acntIntAmnt),"currency_id":"","account_type":"1"] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
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
                            //UserDefaults.standard.set(crncy, forKey: "crncy")
                            //UserDefaults.standard.set(crncyCode, forKey: "crncyCode")
                            UserDefaults.standard.set("1", forKey: "accountExist")
                            self.addTrnscnViewDlgt?.closeSetAcntView()
                        }
                    }
                    
                }
                catch let err{
                    print(err)
                }
            }
        }
        
    }
    func addInc(amnt:String,descr:String,acnt:String,date:String,tag:String,type:String,usertags:String)
    {
        
        var api = ""
        if(type == "1")
        {
           api = APImanager.addIncome()
        }
        else
        {
            api = APImanager.addExpense()
        }
        AF.request(api,method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"transaction_amount":amnt,"account_id":acnt,"transaction_text":descr,"cleared_date":date,"tag_ids":usertags,"tags":tag] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
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
                        
                            self.addTrnscnViewDlgt?.BackAfterDataAdd()
                        
                        //self.addViewDlgt?.closeSetAcntView()
                        
                    }
                    
                }
                catch let err{
                    print(err)
                }
            }
        }
        
    }
    func addTrnsfr(amnt:String,descr:String,frmAcnt:String,toAcnt:String,date:String,tag:String,type:String,usertags:String)
    {
        
        
           
        
        AF.request(APImanager.addTrnsfr(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"transaction_amount":amnt,"from_account_id":frmAcnt,"to_account_id":toAcnt,"transaction_text":descr,"cleared_date":date,"tag_ids":tag,"tags":usertags] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
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
                        ToastView.appearance().backgroundColor = ColorManager.transferColor()
                        //self.addViewDlgt?.valdteAcntcrncy(alrtStr: acntResponse.addresult!.message!)
                        
                            self.addTrnscnViewDlgt?.BackAfterDataAdd()
                        
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
    func validateAcntCrncy(acnt:String,intlAmnt:String,crncyIdVal:String,crncyCode:String)
    {
         if (acnt == "")
        {
            self.addTrnscnViewDlgt?.valdteAcntcrncy(alrtStr: "Please Enter Account Name !")
        }
        else if (intlAmnt == "")
        {
            self.addTrnscnViewDlgt?.valdteAcntcrncy(alrtStr: "Please Enter Initial Amount !")
        }
        else
        {
            DispatchQueue.global().async {
                self.addAcnt(acntNme: acnt,acntIntAmnt:intlAmnt)
            }
            
            //self.addCrncyAcnt()
        }
    }
    
    func addCrncyAcnt()
    {
        UserDefaults.standard.set("1", forKey: "acnt")
        UserDefaults.standard.set("1", forKey: "crncy")
        
        self.addViewDlgt?.closeSetAcntView()
    }
    
    //*************  Add Income Expense Validation and Alert *************//
    func validateIncmExpsAddiotion(amnt:String,descrptn:String,acnt:String,date:String,tag:[String],typeVal:String,userTags:[String])
    {
        if(amnt == "")
        {
            self.addViewDlgt?.valdteAcntcrncy(alrtStr: "Please Enter Amount !")
        }
        else if (descrptn == "")
        {
            self.addViewDlgt?.valdteAcntcrncy(alrtStr: "Please Enter Description !")
        }
        else if (acnt == "")
        {
            self.addViewDlgt?.valdteAcntcrncy(alrtStr: "Please Select Account Name !")
        }
        else if (date == "")
        {
            self.addViewDlgt?.valdteAcntcrncy(alrtStr: "Please Select Date !")
        }
        else if (tag.count == 0)&&(userTags.count == 0)
        {
            self.addViewDlgt?.valdteAcntcrncy(alrtStr: "Please Select a Tag !")
        }
        else
        {
            DispatchQueue.global().async {
                
                self.addInc(amnt: amnt, descr: descrptn, acnt: acnt, date: date, tag: tag.joined(separator: ", "),type:typeVal, usertags: userTags.joined(separator: ", "))
            }
            
            //self.addCrncyAcnt()
        }
    }
}
extension addTrnscnViewModel: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.crncyArry.count
    }
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //let cell = tableView.dequeueReusableCell(withIdentifier: "listRecent", for: indexPath) as! recentTblViewCell
    //let cell1 = tableView.dequeueReusableCell(withIdentifier: "acntlist", for: indexPath) as! recentTblViewCell
    
    if(crncyOrAcnts == "currency")
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listRecent", for: indexPath) as! recentTblViewCell
        cell.title.text = "\(self.crncyArry[indexPath.row])"
        let url = URL(string: "\(self.crncyMdlArry[indexPath.row].currency_flag!)")
        cell.Icn.kf.setImage(with: url, placeholder: UIImage(named: "bankIcn"))
        return cell
        //cell.Icn.isHidden = false
    }
    else
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "acntlist", for: indexPath) as! recentTblViewCell
        cell.title.text = "\(self.crncyArry[indexPath.row])"
        var tagname = self.crncyArry[indexPath.row].prefix(1)
        cell.shortNme.text = "\(tagname.uppercased())"
        let crncy:String = UserDefaults.standard.value(forKey: "crncyCode") as! String
        let crcyCode = crncy.htmlToString
        cell.time.text = "\(crcyCode) \(self.acntBlncArry[indexPath.row])"
        
        return cell
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
    //return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if(crncyOrAcnts == "currency")
        {
            self.addTrnscnViewDlgt?.crncyTblSelect(crncy: self.crncyArry[indexPath.row], crncyId: self.crncyIdArry[indexPath.row],crncycode:self.crncyCodeArry[indexPath.row])
            
            UserDefaults.standard.set(self.crncyMdlArry[indexPath.row].currency_code, forKey:"crncyCode")
            UserDefaults.standard.set(self.crncyMdlArry[indexPath.row].currency_id, forKey:"crncyId")
            UserDefaults.standard.set(self.crncyMdlArry[indexPath.row].currency_name, forKey:"crncyName")
            
        }
        else
        {
            if(self.addingTyp == "trnscn")
            {
                self.addTrnscnViewDlgt?.acntsTblSelect(acnt: self.crncyArry[indexPath.row], acntId: self.crncyIdArry[indexPath.row])
            }
            else if(self.addingTyp == "from")
            {
            
                self.addTrnscnViewDlgt?.trnsfrAcntSelect(acnt: self.crncyArry[indexPath.row], acntId: self.crncyIdArry[indexPath.row],typ:"from")
            }
            else if(self.addingTyp == "to")
            {
                self.addTrnscnViewDlgt?.trnsfrAcntSelect(acnt: self.crncyArry[indexPath.row], acntId: self.crncyIdArry[indexPath.row],typ:"to")
            }
            
        }
            
        
    }
    
}
extension addTrnscnViewModel:UICollectionViewDataSource,UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView.tag == 1)
        {
            return self.crncyArry.count
        }
        else
        {
            if(UserDefaults.standard.value(forKey: "theme")! as! String  == "income")
            {
                return self.incmTagsArry.count
            }
            else if(UserDefaults.standard.value(forKey: "theme") as! String == "expense")
            {
                return self.expnTagsArry.count
            }
            print("tag Collection")
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView.tag == 1)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crncyCell", for: indexPath) as! tagsViewCell
            cell.layer.borderWidth = 0.0
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
            if(UserDefaults.standard.value(forKey: "theme")! as! String  == "income")
            {
                let mydata = self.incmTagsArry[indexPath.item]
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
            else if(UserDefaults.standard.value(forKey: "theme")! as! String  == "expense")
            {
                let mydata = self.expnTagsArry[indexPath.item]
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
                self.addTrnscnViewDlgt?.acntsTblSelect(acnt: self.crncyArry[indexPath.row], acntId: self.crncyIdArry[indexPath.row])
            }
            else if(self.addingTyp == "from")
            {
                
                self.addTrnscnViewDlgt?.trnsfrAcntSelect(acnt: self.crncyArry[indexPath.row], acntId: self.crncyIdArry[indexPath.row],typ:"from")
            }
            else if(self.addingTyp == "to")
            {
                self.addTrnscnViewDlgt?.trnsfrAcntSelect(acnt: self.crncyArry[indexPath.row], acntId: self.crncyIdArry[indexPath.row],typ:"to")
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
            if(UserDefaults.standard.value(forKey: "theme")! as! String  == "income")
            {
                self.addTrnscnViewDlgt?.clkCtgryFill(ctgryNme: self.incmTagsArry[indexPath.item].tagName!, ctgryId: self.incmTagsArry[indexPath.item].tagId!,tagIcnUrl: self.incmTagsArry[indexPath.item].iconUrl!,tagIcnClr: UIColor(hex: self.incmTagsArry[indexPath.item].iconClor!))
            }
            else if(UserDefaults.standard.value(forKey: "theme")! as! String  == "expense")
            {
                self.addTrnscnViewDlgt?.clkCtgryFill(ctgryNme: self.expnTagsArry[indexPath.item].tagName!, ctgryId: self.expnTagsArry[indexPath.item].tagId!,tagIcnUrl: self.expnTagsArry[indexPath.item].iconUrl!,tagIcnClr: UIColor(hex: self.expnTagsArry[indexPath.item].iconClor!))
            }
        }
    }
}
