//
//  RegisterViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 06/10/22.
//

import UIKit
import TransitionButton
import NVActivityIndicatorView
protocol regViewListening
{
    
    func regAlert(title:String,AlrtStr:String)
    
    
    func loginRedrct()
}
class RegisterViewController: UIViewController, regViewListening,NVActivityIndicatorViewable {
    
    func loginRedrct()
    {
        self.stopAnimating()
        self.performSegue(withIdentifier: "regLogin", sender: self)
    }
    
    
    func regAlert(title:String,AlrtStr:String) {
        self.stopAnimating()
        self.bgScroll.setContentOffset(CGPointMake(0, max(self.bgScroll.contentSize.height - self.bgScroll.bounds.size.height+50, 0) ), animated: true)
        let alert = UIAlertController(title: title, message: AlrtStr, preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var regButton: TransitionButton!
    @IBOutlet weak var nameTxt:UITextField!
    @IBOutlet weak var emailTxt:UITextField!
    @IBOutlet weak var pwdTxt:UITextField!
    @IBOutlet weak var cnfrmPwd:UITextField!
    @IBOutlet weak var bgScroll: UIScrollView!
    @IBOutlet weak var pwdViewImg: UIButton!
    var pwdImgToggle:Bool = true
    var Regdlgt = RegisterViewModel()
    var loginVwMdlObj = LoginViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.pwdTxt.isSecureTextEntry = true
        self.pwdViewImg.setImage(UIImage(named: "eye.png"), for: .normal)
        Regdlgt.regDlgt = self
        loginVwMdlObj.registerDlgt = self
        
        // Do any additional setup after loading the view.
    }
    @IBAction func buttonAction() {
        self.startAnimating()
        DispatchQueue.main.async {
            
            self.Regdlgt.getRegData(email: self.emailTxt.text!, pwd: self.pwdTxt.text!, name: self.nameTxt.text!,cnfrPwd: self.cnfrmPwd.text!)
        }
        }
    override func viewDidAppear(_ animated: Bool) {
        self.regButton.layer.cornerRadius = self.regButton.frame.height/2
        self.regButton.layer.masksToBounds = true
    }
    @IBAction func viewPwd()
    {
        if(self.pwdImgToggle)
        {
            self.pwdViewImg.setImage(UIImage(named: "eyeSlash.png"), for: .normal)
            self.pwdTxt.isSecureTextEntry = false
            self.pwdImgToggle = false
            
        }
        else
        {
            self.pwdViewImg.setImage(UIImage(named: "eye.png"), for: .normal)
            self.pwdTxt.isSecureTextEntry = true
            self.pwdImgToggle = true
            
        }
    }
    @IBAction func back()
    {
        self.dismiss(animated: false, completion: nil)
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
