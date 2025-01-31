//
//  RegisterViewModel.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 06/10/22.
//

import Foundation
import Alamofire
import SwiftValidators
protocol RegisterProtocol
{
    func getRegData(email:String, pwd:String,name:String, cnfrPwd:String)
}
class RegisterViewModel:RegisterProtocol
{
    var  plyrId:String = ""
    var regDlgt:regViewListening?
    func getRegData(email:String, pwd:String,name:String, cnfrPwd:String)
    {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
            }
        }
        if(name == "")
        {
            regDlgt?.regAlert(title: "Register", AlrtStr: "Enter name !")
        }
        else if(Validator.isEmail().apply(email) == false)
        {
            regDlgt?.regAlert(title: "Register", AlrtStr: "Invalid Email ! ")
        }
        else if(pwd == "")
        {
            regDlgt?.regAlert(title: "Register", AlrtStr: "Enter password !")
        }
        else if(Validator.minLength(8).apply(pwd) == false)
        {
            regDlgt?.regAlert(title: "Register", AlrtStr: "The password you entered is invalid. Please make sure it meets the following criteria: \n" +
                              "        - At least 8 characters long \n" +
                              "        - Contains at least one digit \n" +
                              "        - Contains at least one uppercase letter and one lowercase letter.")
        }
        
        else if(Validator.isAlphanumeric().apply(pwd) == false)
        {
            regDlgt?.regAlert(title: "Register", AlrtStr: "The password you entered is invalid. Please make sure it meets the following criteria: \n" +
                              "        - At least 8 characters long \n" +
                              "        - Contains at least one digit \n" +
                              "        - Contains at least one uppercase letter and one lowercase letter.")
        }
        else if(Validator.isLowercase().apply(pwd) == true)
        {
            regDlgt?.regAlert(title: "Register", AlrtStr: "The password you entered is invalid. Please make sure it meets the following criteria: \n" +
                              "        - At least 8 characters long \n" +
                              "        - Contains at least one digit \n" +
                              "        - Contains at least one uppercase letter and one lowercase letter.")
        }
        else if(Validator.isUppercase().apply(pwd) == true)
        {
            regDlgt?.regAlert(title: "Register", AlrtStr: "The password you entered is invalid. Please make sure it meets the following criteria: \n" +
                              "        - At least 8 characters long \n" +
                              "        - Contains at least one digit \n" +
                              "        - Contains at least one uppercase letter and one lowercase letter.")
        }
        
        else if(pwd != cnfrPwd)
        {
            regDlgt?.regAlert(title: "Register", AlrtStr: "Password mismatch !")
        }
        
        else
        {
            if(UserDefaults.standard.value(forKey: "playerId") != nil)
            {
                plyrId =  UserDefaults.standard.value(forKey: "playerId")! as! String
            }
            else
            {
                 plyrId = ""
            }
            AF.request(APImanager.registerAPI(), method: .post, parameters: ["email_id": email,"user_password":pwd,"full_name":name,"device_type":"iOS","device_name":modelCode!, "player_id":self.plyrId] , encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
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
                            //print(loginResponse.regresult?.value)
                            //self.retDlgt.loginAlert(title: <#T##String#>, AlrtStr: <#T##String#>)
                            self.Login(email: email, pwd: pwd)
                            
                        }
                        else
                        {
                            //print(loginResponse.regresult?.value)
                            self.regDlgt?.regAlert(title: "Register", AlrtStr: loginResponse.regresult!.message!)
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
    func Login(email:String, pwd:String)
    {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
            }
        }
        if(UserDefaults.standard.value(forKey: "playerId") != nil)
        {
            plyrId =  UserDefaults.standard.value(forKey: "playerId")! as! String
        }
        else
        {
             plyrId = ""
        }
        AF.request(APImanager.LoginAPI(), method: .post, parameters: ["email_id": email,"password":pwd,"device_type":"iOS","device_name":modelCode!, "player_id":self.plyrId] , encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let loginResponse  = try
                    JSONDecoder().decode(LoginModel.self, from: data)
                    
                    //print(loginResponse)
                    if(loginResponse.result!.user_status! == "1")
                    {
                        
                        UserDefaults.standard.set(loginResponse.result!.user_id, forKey: "user_id")
                        UserDefaults.standard.set(loginResponse.result!.full_name, forKey: "full_name")
                        UserDefaults.standard.set(loginResponse.result!.email_id, forKey: "email_id")
                        UserDefaults.standard.set(loginResponse.result!.user_status, forKey: "user_status")
                        UserDefaults.standard.set(loginResponse.result!.registered_date, forKey: "registered_date")
                        UserDefaults.standard.set(loginResponse.result!.last_login_time, forKey: "last_login_time")
                        UserDefaults.standard.set(loginResponse.result!.subscribed, forKey: "subscribed")
                        UserDefaults.standard.set(loginResponse.result!.account_exists, forKey: "accountExist")
                        self.regDlgt?.loginRedrct()
                    }
                    else
                    {
                        self.regDlgt?.regAlert(title: "Login", AlrtStr: "Login failed !")
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
