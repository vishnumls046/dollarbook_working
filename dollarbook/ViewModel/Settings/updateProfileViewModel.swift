//
//  updateProfileViewModel.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 16/12/22.
//

import Foundation
import Alamofire
import UIKit
import SwiftValidators
import Kingfisher
class updateProfileViewModel:NSObject
{
    var crncyArry:[String] = []
    var crncyIdArry:[String] = []
    var crncyCodeArry:[String] = []
    var crncyMdlArry:[Currencies] = []
    var userPrflMdlArry:[User] = []
    var profileDlgt:profileProt?
    var dashDlgt:dashUpdateUIProt?
    func getCurrency(key:String)
    {
        AF.request(APImanager.GetCrncyAPI(),method: .post,parameters: ["keyword":key],encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            
            response in
            if let data = response.data
            {
                do{
                    self.crncyArry = []
                    self.crncyIdArry = []
                    self.crncyCodeArry = []
                    self.crncyMdlArry = []
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
                    //self.crncyOrAcnts = "currency"
                    DispatchQueue.main.async {
                        self.profileDlgt?.updtCrncy(TblTyp: "currency")
                    }
                    
                }
                catch let err{
                    print(err)
                }
            }
        }
        
    }
    func getUserProfile()
    {
        AF.request(APImanager.GetUserProfile(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!],encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            
            response in
            if let data = response.data
            {
                do{
                    
                    self.userPrflMdlArry = []
                    let AcntsResponse  = try
                    JSONDecoder().decode(UserProfile.self, from: data)
                    print(AcntsResponse.user!)
                    for anItem in AcntsResponse.user! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        
                        self.userPrflMdlArry.append(anItem)
                        
                    // do something with personName and personID
                    }
                    UserDefaults.standard.set(self.userPrflMdlArry[0].currencyCode, forKey: "crncyCode")
                    self.profileDlgt?.fillValues(val:self.userPrflMdlArry)
                }
                catch let err{
                    print(err)
                }
            }
        }
        
        
    }
    func validateUpdate(email:String,name:String,crncyId:String)
    {
        if(name == "")
        {
            profileDlgt?.regAlert(title: "Update", AlrtStr: "Enter name !")
        }
        else if(Validator.isEmail().apply(email) == false)
        {
            profileDlgt?.regAlert(title: "Update", AlrtStr: "Invalid Email ! ")
        }
        else
        {
            AF.request(APImanager.UpdtProfile(), method: .post, parameters: ["email_id": email,"full_name":name,"currency_id":crncyId,"user_id":UserDefaults.standard.value(forKey: "user_id")!] , encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
            {
                response in
                if let data = response.data
                {
                    do{
                        let loginResponse  = try
                        JSONDecoder().decode(RegisterModel.self, from: data)
                        
                        //print(loginResponse)
                        if(loginResponse.regresult!.value! == "1")
                        {
                            UserDefaults.standard.set(crncyId, forKey: "crncyId")
                            UserDefaults.standard.set(name, forKey: "full_name")
                            UserDefaults.standard.set(email, forKey: "email_id")
                            //print(loginResponse.regresult?.value)
                            //self.retDlgt.loginAlert(title: <#T##String#>, AlrtStr: <#T##String#>)
                            
                            self.profileDlgt?.updtRedirect()
                            
                            
                        }
                        else
                        {
                            //print(loginResponse.regresult?.value)
                            self.profileDlgt?.regAlert(title: "Update", AlrtStr: loginResponse.regresult!.message!)
                            //self.retDlgt?.loginAlert(title: "Login", AlrtStr: "Invalid credentials !")
                        }
                        //self.loginArry.append(contentsOf: loginResponse)
                        
                    }
                    catch let err{
                        print(err)
                    }
                    
                }
            }
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrolling")
        self.profileDlgt?.keybrdHide()
        //self.view.endEditing(true)
    }
}
extension updateProfileViewModel: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.crncyArry.count
    }
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "listRecent", for: indexPath) as! recentTblViewCell
    cell.title.text = "\(self.crncyMdlArry[indexPath.row].currency_name!)"
    let url = URL(string: "\(self.crncyMdlArry[indexPath.row].currency_flag!)")
    cell.Icn.kf.setImage(with: url)
    cell.accessoryType = .none
    if(self.userPrflMdlArry[0].currencyId! == self.crncyMdlArry[indexPath.row].currency_id!)
    {
        cell.accessoryType = .checkmark
    }
//    DispatchQueue.global().async {
//
//    let url = URL(string: "\(self.crncyMdlArry[indexPath.row].currency_flag!)")
//    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//        DispatchQueue.main.async {
//            cell.Icn.image = UIImage(data: data!)
//        }
    //}
    
    
    //cell.Icn.image = UIImage(named: "\(self.crncyMdlArry[indexPath.row].currency_flag)")
    return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
            self.profileDlgt?.crncyTblSelect(crncy: self.crncyArry[indexPath.row], crncyId: self.crncyIdArry[indexPath.row],crncycode:self.crncyCodeArry[indexPath.row])
            
            UserDefaults.standard.set(self.crncyMdlArry[indexPath.row].currency_code, forKey:"crncyCode")
            UserDefaults.standard.set(self.crncyMdlArry[indexPath.row].currency_id, forKey:"crncyId")
            UserDefaults.standard.set(self.crncyMdlArry[indexPath.row].currency_name, forKey:"crncyName")
       
    }
    
}
