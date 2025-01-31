//
//  settingsViewModel.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 07/11/22.
//

import Foundation
import Alamofire
import UIKit
class settingsViewModel:NSObject
{
    var crncyOrAcnts = ""
    var settngsDlgt:settngsProt?
    var incmTagArry:[String] = []
    var expnsTagArry:[String] = []
    var crncyArry:[String] = []
    var crncyIdArry:[String] = []
    var crncyCodeArry:[String] = []
    var crncyMdlArry:[Currencies] = []
    var acntMdlArry:[Accounts] = []
   
    func logout()
    {
        UserDefaults.standard.removeObject(forKey: "user_id")
        UserDefaults.standard.removeObject(forKey: "full_name")
        UserDefaults.standard.removeObject(forKey: "email_id")
        UserDefaults.standard.removeObject(forKey: "user_status")
        UserDefaults.standard.removeObject(forKey: "registered_date")
        UserDefaults.standard.removeObject(forKey: "last_login_time")
        UserDefaults.standard.removeObject(forKey: "subscribed")
        UserDefaults.standard.removeObject(forKey: "subscribed")
        UserDefaults.standard.removeObject(forKey: "accountExist")
        UserDefaults.standard.removeObject(forKey: "theme")
        UserDefaults.standard.removeObject(forKey: "incDefltTags")
        UserDefaults.standard.removeObject(forKey: "expDefltTags")
        settngsDlgt?.logoutRedrct()
        
    }
    func deleteUserAcnt()
    {
        
        AF.request(APImanager.delUsrAcnt(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!],encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let delResponse  = try
                    JSONDecoder().decode(AddDataModel.self, from: data)
                    print(delResponse.addresult!.message!)
                    
                    DispatchQueue.main.async {
                        if(delResponse.addresult!.value! == 1)
                        {
                            self.logout()
                        }
                    }
                    
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
                    self.settngsDlgt?.updtCrncy(TblTyp: "currency")
                }
                catch let err{
                    print(err)
                }
            }
        }
        
    }
    func getAcnts()->[Accounts]
    {
        AF.request(APImanager.GetAccounts(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!],encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
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
                    self.settngsDlgt?.updtCrncy(TblTyp: "account")
                }
                catch let err{
                    print(err)
                }
            }
        }
        return self.acntMdlArry
        
    }
}

extension settingsViewModel: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.crncyArry.count
    }
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "listRecent", for: indexPath) as! recentTblViewCell
    cell.title.text = "\(self.crncyArry[indexPath.row])"
    if(crncyOrAcnts == "currency")
    {
    }
    else
    {
        var theme = UserDefaults.standard.value(forKey: "theme")!
        if(theme as! String == "income")
        {
            cell.title.textColor =  UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
        }
        else
        {
            cell.title.textColor =   UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
        }
    }
    return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if(crncyOrAcnts == "currency")
        {
            self.settngsDlgt?.crncyTblSelect(crncy: self.crncyArry[indexPath.row], crncyId: self.crncyIdArry[indexPath.row],crncycode:self.crncyCodeArry[indexPath.row])
            
            UserDefaults.standard.set(self.crncyMdlArry[indexPath.row].currency_code, forKey:"crncyCode")
            UserDefaults.standard.set(self.crncyMdlArry[indexPath.row].currency_id, forKey:"crncyId")
            UserDefaults.standard.set(self.crncyMdlArry[indexPath.row].currency_name, forKey:"crncyName")
            
        }
        else
        {
            self.settngsDlgt?.acntsTblSelect(acnt: self.crncyArry[indexPath.row], acntId: self.crncyIdArry[indexPath.row])
        }
            
        
    }
    
}
