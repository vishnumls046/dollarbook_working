//
//  AppDelegate.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 26/08/22.
//

import UIKit
import IQKeyboardManagerSwift
import NVActivityIndicatorView
import OneSignal

//protocol tagProt
//{
//    func updtDefTags(incTags:[String],expnsTags:[String])
//}
@main

class AppDelegate: UIResponder, UIApplicationDelegate, OSSubscriptionObserver {
//    func updtDefTags(incTags: [String],expnsTags:[String]) {
//        UserDefaults.standard.set(incTags, forKey: "incDefltTags")
//        UserDefaults.standard.set(expnsTags, forKey: "expDefltTags")
//    }
    

    var window: UIWindow?
    //var addDataViewMdlObj = AddDataViewModel()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //FirebaseApp.configure()
        // Remove this method to stop OneSignal Debugging
          OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
          
          // OneSignal initialization
          OneSignal.initWithLaunchOptions(launchOptions)
          OneSignal.setAppId("63a66738-6f1d-4bb8-a8a2-f2794541af15")
          
          // promptForPushNotifications will show the native iOS notification permission prompt.
          // We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 8)
          OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
          })
        OneSignal.add(self as OSSubscriptionObserver)
        let playerId = OneSignal.getDeviceState().userId
        if(playerId != nil)
        {
            UserDefaults.standard.set(playerId!, forKey: "playerId")
        }
        
          // Set your customer userId
          // OneSignal.setExternalUserId("userId")
        if(UserDefaults.standard.value(forKey: "crncyCode") == nil)
        {
            UserDefaults.standard.set("&#36;", forKey:"crncyCode")
        }
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        self.addDataViewMdlObj.appDlgt = appDelegate
//        self.addDataViewMdlObj.getTags()
        IQKeyboardManager.shared.enable = true
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        NVActivityIndicatorView.DEFAULT_TYPE = .audioEqualizer
        NVActivityIndicatorView.DEFAULT_COLOR = ColorManager.expenseColor()
        // Override point for customization after application launch.
        return true
    }
    func onOSSubscriptionChanged(_ stateChanges: OSSubscriptionStateChanges) {
//          if !stateChanges.from.subscribed && stateChanges.to.subscribed {
//             print("Subscribed for OneSignal push notifications!")
//          }
          print("SubscriptionStateChange: \n\(stateChanges)")

          //The player id is inside stateChanges. But be careful, this value can be nil if the user has not granted you permission to send notifications.
          if let playerId = stateChanges.to.userId {
             print("Current playerId \(playerId)")
            UserDefaults.standard.set(playerId, forKey: "playerId")
          }
       }
    // MARK: UISceneSession Lifecycle
    func applicationWillEnterForeground(_ application: UIApplication) {
        NotificationCenter.default.post(name: Notification.Name("foreground"), object: nil)
        
        print("foreeeee")
        
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        NotificationCenter.default.post(name: Notification.Name("background"), object: nil)
    }



}

