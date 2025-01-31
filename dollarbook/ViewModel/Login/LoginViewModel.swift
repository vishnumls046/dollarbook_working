//
//  LoginViewModel.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 29/09/22.
//

import Foundation
import Alamofire
import SwiftValidators
import Toaster
import NVActivityIndicatorView
protocol LoginProtocol:AnyObject
{
    func getLoginVal(vals:LoginModel)
    
}
protocol ValidatingProtocol
{
    func validate(emlVal:String,pwdVal:String)
    
}
class LoginViewModel:ValidatingProtocol
{
    var  plyrId:String = ""
    let apimngr = APImanager()
    var retDlgt:returnval?
    var registerDlgt:regViewListening?
    func validate(emlVal: String,pwdVal:String) {
        
        //var updtdVal = "\(emlVal) Updated"
        //print(updtdVal)
        if(Validator.isEmail().apply(emlVal) == false)
        {
            retDlgt?.loginAlert(title: "Login", AlrtStr: "Please enter valid Email !")
        }
        else if(pwdVal == "")
        {
            retDlgt?.loginAlert(title: "Login", AlrtStr: "Please enter password !")
        }
        else
        {
            self.getLoginData(email: emlVal, pwd: pwdVal)
            //retDlgt?.updateRetVal(vals: updtdVal)
        }
        
        
    }
    func validateFrgtPwd(emlVal:String)
    {
        if(Validator.isEmail().apply(emlVal) == false)
        {
            retDlgt?.loginAlert(title: "ForgotPassword", AlrtStr: "Please enter valid Email !")
        }
        else
        {
            DispatchQueue.global().async {
                self.frgtPwd(email: emlVal)
            }
            
        }
    }
    
    
    
   
    
    
    //var testprot:test?
    
    var loginDelegate:LoginProtocol?
    var loginArry = [LoginModel]()
    func getLoginData(email:String, pwd:String)
    {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
            }
        }
        print(modelCode)
        //var plyrId = ""
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
                        self.loginDelegate?.getLoginVal(vals: loginResponse)
                        UserDefaults.standard.set(loginResponse.result!.user_id, forKey: "user_id")
                        UserDefaults.standard.set(loginResponse.result!.full_name, forKey: "full_name")
                        UserDefaults.standard.set(loginResponse.result!.email_id, forKey: "email_id")
                        UserDefaults.standard.set(loginResponse.result!.user_status, forKey: "user_status")
                        UserDefaults.standard.set(loginResponse.result!.registered_date, forKey: "registered_date")
                        UserDefaults.standard.set(loginResponse.result!.last_login_time, forKey: "last_login_time")
                        UserDefaults.standard.set(loginResponse.result!.subscribed, forKey: "subscribed")
                        UserDefaults.standard.set(loginResponse.result!.account_exists, forKey: "accountExist")
                        self.retDlgt?.loginRedrct()
                    }
                    else
                    {
                        self.retDlgt?.loginAlert(title: "Login", AlrtStr: "Invalid credentials !")
                    }
                    //self.loginArry.append(contentsOf: loginResponse)
                    
                }
                catch let err{
                    print(err)
                }
                    
            }
        }
    }
    func frgtPwd(email:String) // not done fully ********************
    {
        
        AF.request(APImanager.ForgotPwd(), method: .post, parameters: ["email_id": email] , encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let loginResponse  = try
                    JSONDecoder().decode(ForgotPwd.self, from: data)
                    
                    print(loginResponse)
                    if(loginResponse.result!.userStatus! == "1")
                    {
                        DispatchQueue.main.async {
                            
                            Toast(text: loginResponse.result!.message!).show()
                            ToastView.appearance().backgroundColor = ColorManager.incomeColor()
                            ToastView.appearance().textColor = .white
                            self.retDlgt?.forgotPwdClose()
                        }
                        //self.retDlgt?.loginAlert(title: "Login", AlrtStr: "Invalid credentials !")
                    }
                    else
                    {
                        DispatchQueue.main.async {
                            
                            Toast(text: loginResponse.result!.message!).show()
                            ToastView.appearance().backgroundColor = ColorManager.expenseColor()
                            ToastView.appearance().textColor = .white
                        }
                       // self.retDlgt?.loginAlert(title: "Login", AlrtStr: "Invalid credentials !")
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

