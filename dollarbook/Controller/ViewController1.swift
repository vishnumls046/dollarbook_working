//
//  ViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 26/08/22.
//

import UIKit
import FloatingTabBarController
class ViewController1: FloatingTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabbar()
        
        // Do any additional setup after loading the view.
    }
     func loadTabbar()
    {
        tabBar.tintColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
        tabBar.backgroundColor = UIColor.white
        
        viewControllers = (1...5).map { "Tab\($0)" }.map {
            let selected = UIImage(named: $0 + "_Large")!
            let normal = UIImage(named: $0 + "_Small")!
            let controller = storyboard!.instantiateViewController(withIdentifier: $0)
            controller.title = $0
            controller.view.backgroundColor = UIColor.white
            controller.floatingTabItem = FloatingTabItem(selectedImage: selected, normalImage: normal)
            controller.tabBarItem.title = "xxcx"
            return controller
        }
    }

}

