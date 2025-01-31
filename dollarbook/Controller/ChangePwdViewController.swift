//
//  ChangePwdViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 10/02/23.
//

import UIKit
import NVActivityIndicatorView
import Toaster
protocol changePwdProt
{
    func alert(alrtStr:String)
    func backAfterChange(alrtStr:String)
}

class ChangePwdViewController: UIViewController,NVActivityIndicatorViewable,changePwdProt {
    @IBOutlet weak var curntPwdTxt:UITextField!
    @IBOutlet weak var newPwdTxt:UITextField!
    @IBOutlet weak var cnfrmPwdTxt:UITextField!
    let chngPwdModelObj = chngPwdViewModel()
    func alert(alrtStr:String)
    {
        self.stopAnimating()
        Toast(text: alrtStr).show()
        ToastView.appearance().backgroundColor = ColorManager.expenseColor()
        ToastView.appearance().textColor = .white
    }
    func backAfterChange(alrtStr:String)
    {
        self.stopAnimating()
        Toast(text: alrtStr).show()
        ToastView.appearance().backgroundColor = ColorManager.expenseColor()
        ToastView.appearance().textColor = .white
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func back()
    {
        self.dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chngPwdModelObj.chngPwdDlgt = self        // Do any additional setup after loading the view.
    }
    @IBAction func clkSubmit()
    {
        self.startAnimating()
        self.chngPwdModelObj.validates(crntPwd: self.curntPwdTxt.text!, newPwd: self.newPwdTxt.text!, cnfrmPwd: self.cnfrmPwdTxt.text!)
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
