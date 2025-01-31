//
//  calendarViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 14/11/22.
//

import UIKit
import Fastis
class calendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
                var customConfig = FastisConfig.default
            customConfig.dayCell.dateLabelColor = UIColor(red: 141/255, green: 118/255, blue: 206/255, alpha: 1.0)
            customConfig.controller.barButtonItemsColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
                customConfig.monthHeader.labelColor = .black
            customConfig.dayCell.selectedBackgroundColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
            customConfig.dayCell.onRangeBackgroundColor = UIColor(red: 229/255, green: 220/255, blue: 255/255, alpha: 1.0)
                let fastisController = FastisController(mode: .range, config: customConfig)
                fastisController.title = "Choose range"
                fastisController.maximumDate = Date()
                fastisController.allowToChooseNilDate = true
        fastisController.shortcuts = [.today, .lastWeek,.lastMonth]
                fastisController.doneHandler = { resultRange in
                    print(resultRange)
                }
                fastisController.present(above: self)
            
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
