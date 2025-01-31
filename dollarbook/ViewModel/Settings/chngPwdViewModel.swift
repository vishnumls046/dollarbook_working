//
//  chngPwdViewModel.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 10/02/23.
//

import Foundation
import Alamofire
import UIKit
import SwiftValidators
class chngPwdViewModel:NSObject
{
    var chngPwdDlgt:changePwdProt?
    func validates(crntPwd:String,newPwd:String,cnfrmPwd:String)
    {
        if(crntPwd == "")
        {
            chngPwdDlgt?.alert(alrtStr: "Enter old password !")
        }
        else if(newPwd == "")
        {
            chngPwdDlgt?.alert(alrtStr: "Enter new password !")
        }
        else if(Validator.minLength(8).apply(newPwd) == false)
        {
            chngPwdDlgt?.alert(alrtStr: "The password you entered is invalid. Please make sure it meets the following criteria: \n" +
                              "        - At least 8 characters long \n" +
                              "        - Contains at least one digit \n" +
                              "        - Contains at least one uppercase letter and one lowercase letter.")
        }
        
        else if(Validator.isAlphanumeric().apply(newPwd) == false)
        {
            chngPwdDlgt?.alert(alrtStr: "The password you entered is invalid. Please make sure it meets the following criteria: \n" +
                              "        - At least 8 characters long \n" +
                              "        - Contains at least one digit \n" +
                              "        - Contains at least one uppercase letter and one lowercase letter.")
        }
        else if(Validator.isLowercase().apply(newPwd) == true)
        {
            chngPwdDlgt?.alert(alrtStr: "The password you entered is invalid. Please make sure it meets the following criteria: \n" +
                              "        - At least 8 characters long \n" +
                              "        - Contains at least one digit \n" +
                              "        - Contains at least one uppercase letter and one lowercase letter.")
        }
        else if(Validator.isUppercase().apply(newPwd) == true)
        {
            chngPwdDlgt?.alert(alrtStr: "The password you entered is invalid. Please make sure it meets the following criteria: \n" +
                              "        - At least 8 characters long \n" +
                              "        - Contains at least one digit \n" +
                              "        - Contains at least one uppercase letter and one lowercase letter.")
        }
        else if(newPwd != cnfrmPwd)
        {
            chngPwdDlgt?.alert(alrtStr: "Password mismatch !")
        }
        else
        {
            
            DispatchQueue.global().async {
                self.changePwd(crntPwd:crntPwd,newPwd:newPwd,cnfrmPwd:cnfrmPwd)
            }
        }
    }
    
    
    func changePwd(crntPwd:String,newPwd:String,cnfrmPwd:String)
    {
        AF.request(APImanager.ChngPwdAPI(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"new_password":newPwd,"old_password":crntPwd] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let acntResponse  = try
                    JSONDecoder().decode(ChangePwdModel.self, from: data)
                    print(acntResponse.result!.message!)
                    //                    for anItem in acntResponse.tags! as Array {
                    //
                    //                        self.tagArry.append(anItem.tagName!)
                    //
                    //                    // do something with personName and personID
                    //                    }
                    
                    if(acntResponse.result?.value! == 1)
                    {
                        DispatchQueue.main.async {
                            self.chngPwdDlgt?.backAfterChange(alrtStr: acntResponse.result!.message!)
                        }
                    }
                    else
                    {
                        self.chngPwdDlgt?.alert(alrtStr: acntResponse.result!.message!)
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
