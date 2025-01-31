//
//  ViewController.swift
//  SOTabBar
//
//  Created by Ahmadalsofi on 01/03/2020.
//  Copyright (c) 2020 Ahmadalsofi. All rights reserved.
//


import UIKit
import SOTabBar
class ViewController: SOTabBarController {

    override func loadView() {
        super.loadView()
        
        SOTabBarSetting.tabBarTintColor = #colorLiteral(red: 0.568627451, green: 0.4352941176, blue: 0.937254902, alpha: 1)
        SOTabBarSetting.tabBarHeight = 64.0
        
        //SOTabBarSetting.tabBarSizeSelectedImage = 50
        //SOTabBarSetting.tabBarTintColor = UIColor(red: 242/255, green: 238/255, blue: 255/255, alpha: 1.0)
        //SOTabBarSetting
        //SOTabBarSetting.tabBarTintColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
        //SOTabBarSetting.tabBarBackground = UIColor.white
        SOTabBarSetting.tabBarCircleSize = CGSize(width: 60, height: 60)
        //SOTabBarSetting.tabBarShadowColor = UIColor(red: 242/255, green: 238/255, blue: 255/255, alpha: 1.0).cgColor
        SOTabBarSetting.tabBarShadowColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0).cgColor
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let homeStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tab1")
        let chatStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tab2")
        let sleepStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tab3")
        let musicStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tab4")
        let meStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tab5")
        
        homeStoryboard.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Tab1_Small"), selectedImage: UIImage(named: "Tab1_Large"))
        chatStoryboard.tabBarItem = UITabBarItem(title: "Income", image: UIImage(named: "Tab2_Small"), selectedImage: UIImage(named: "Tab2_Large"))
        sleepStoryboard.tabBarItem = UITabBarItem(title: "Add", image: UIImage(named: "Tab3_Small"), selectedImage: UIImage(named: "Tab3_Large"))
        musicStoryboard.tabBarItem = UITabBarItem(title: "Expense", image: UIImage(named: "Tab4_Small"), selectedImage: UIImage(named: "Tab4_Large"))
        meStoryboard.tabBarItem = UITabBarItem(title: "Report", image: UIImage(named: "Tab5_Small"), selectedImage: UIImage(named: "Tab5_Large"))
        
        viewControllers = [homeStoryboard, chatStoryboard,sleepStoryboard,musicStoryboard,meStoryboard]
        
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
    override func viewDidAppear(_ animated: Bool) {
        //SOTabBarController().selectedIndex = 3
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let vc = storyboard.instantiateViewController(withIdentifier: "Tab4")
//            vc.loadViewIfNeeded()
//        vc.modalPresentationStyle = .popover
//        self.present(vc, animated: true)
        //SOTabBarController().selectedIndex = 3
        //SOTabBarController().tabBarController?.selectedIndex = 3
        
    }
    
}

extension ViewController: SOTabBarControllerDelegate {
    func tabBarController(_ tabBarController: SOTabBarController, didSelect viewController: UIViewController) {
        print(viewController.tabBarItem.title ?? "")
    }
}
