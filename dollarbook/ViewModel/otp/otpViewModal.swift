//
//  otpViewModal.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 07/02/25.
//

import Foundation
import Alamofire
import SwiftValidators
import Toaster
import NVActivityIndicatorView
protocol otpProt:AnyObject
{
    func sendOtp(email:String)
}
class otpViewModal:NSObject
{
    var  plyrId:String = ""
    let apimngr = APImanager()
    var otpProtDlgt:otpViewProt?
    func sendOtp(email:String)
    {
        if(Validator.isEmail().apply(email) == false)
        {
            DispatchQueue.main.async {
                
                self.otpProtDlgt?.showAlert(msg: "Invalid Email !")
            }
        }
        else
        {
            DispatchQueue.global().async {
                AF.request(APImanager.sendOtp(), method: .post, parameters: ["email_id": email,"full_name":"","device_type":"iOS","device_name":"", "player_id":""] , encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
                {
                    response in
                    if let data = response.data
                    {
                        do{
                            let otpResponse  = try
                            JSONDecoder().decode(sendotp_Modal.self, from: data)
                            
                            //print(loginResponse)
                            if(otpResponse.result!.user_status! == "1")
                            {
                                self.otpProtDlgt?.displayOtpField()
                                self.otpProtDlgt?.showAlert(msg: otpResponse.result!.message!)
                                 
                                
                            }
                            else
                            {
                                self.otpProtDlgt?.showAlert(msg: otpResponse.result!.message!)
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
    }
    
    
    
    func verifyOtp(email:String, otp:String)
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
        AF.request(APImanager.verifyOtp(), method: .post, parameters: ["email_id": email,"otp":otp] , encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let loginResponse  = try
                    JSONDecoder().decode(verifyotpBase.self, from: data)
                    
                    print(loginResponse)
                    if(loginResponse.result!.user_status! == 1)
                    {
                        
                        UserDefaults.standard.set(loginResponse.result!.user_id, forKey: "user_id")
                        UserDefaults.standard.set(loginResponse.result!.full_name, forKey: "full_name")
                        UserDefaults.standard.set(loginResponse.result!.email_id, forKey: "email_id")
                        UserDefaults.standard.set(loginResponse.result!.user_status, forKey: "user_status")
                        UserDefaults.standard.set(loginResponse.result!.registered_date, forKey: "registered_date")
                        UserDefaults.standard.set(loginResponse.result!.last_login_time, forKey: "last_login_time")
                        UserDefaults.standard.set(loginResponse.result!.subscribed, forKey: "subscribed")
                        UserDefaults.standard.set(loginResponse.result!.account_exists, forKey: "accountExist")
                        self.otpProtDlgt?.otpVerifyRedirect()
                    }
                    else
                    {
                        self.otpProtDlgt?.showAlert(msg: loginResponse.result!.message!)
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
