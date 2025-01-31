//
//  SplashViewModel.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 19/07/23.
//

import Foundation
import Alamofire
import NVActivityIndicatorView

class SplashViewModel
{
    var splshProt:splashProt?
    var settingsProt:settngsProt?
    var updtProfProt:profileProt?
    func userCheck(from:String)
    {
        AF.request(APImanager.userCheck(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!],encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            
            response in
            if let data = response.data
            {
                do{
                    
                    
                    let AcntsResponse  = try
                    JSONDecoder().decode(UserCheck.self, from: data)
                    print(AcntsResponse.result!)
                   
                        if(AcntsResponse.result! == 0)
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
                            if(from == "splash")
                            {
                                self.splshProt?.userNotExist()
                            }
                            else if(from == "settings")
                            {
                                self.settingsProt?.userNotExist()
                            }
                            else if(from == "updateProfile")
                            {
                                self.updtProfProt?.userNotExist()
                            }
                            
                    }
                    else
                    {
                        if(from == "splash")
                        {
                            self.splshProt?.userExist()
                        }
                        else if(from == "updateProfile")
                        {
                            self.updtProfProt?.userExist()
                        }
                        
                    }
                    
                }
                catch let err{
                    print(err)
                }
            }
        }
        
        
    }
}
