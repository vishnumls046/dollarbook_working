//
//  loginViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 27/09/22.
//

import UIKit
import TransitionButton
import SwiftValidators
import NVActivityIndicatorView
protocol returnval
{
    func updateRetVal(vals:String)
    func loginAlert(title:String,AlrtStr:String)
    func loginRedrct()
    func forgotPwdClose()
}
class loginViewController: UIViewController, LoginProtocol,returnval,NVActivityIndicatorViewable {
    func loginRedrct() {
        self.performSegue(withIdentifier: "login", sender: self)
    }
    func forgotPwdClose()
    {
        self.frgtPwdView.isHidden = true
    }
    func loginAlert(title:String,AlrtStr:String) {
        let alert = UIAlertController(title: title, message: AlrtStr, preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var emailTxt:UITextField!
    @IBOutlet weak var pwdTxt:UITextField!
    @IBOutlet weak var comfirmButton: UIButton!
    @IBOutlet weak var frgtPwdView:UIView!
    @IBOutlet weak var frgtEmailTxt:UITextField!
    @IBOutlet weak var pwdViewImg: UIButton!
    var pwdImgToggle:Bool = true
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
    func updateRetVal(vals: String) {
        print(vals)
        self.emailTxt.text = vals
    }
    func getLoginVal(vals: LoginModel) {
        print(vals.result!.email_id!)
    }
    var loginViewModel = LoginViewModel()
    @IBOutlet var addbutton : TransitionButton!
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
        self.addbutton.layer.cornerRadius = self.addbutton.frame.height/2
        self.addbutton.layer.masksToBounds = true
    }
    @IBAction func back()
    {
        self.dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pwdTxt.isSecureTextEntry = true
        self.pwdViewImg.setImage(UIImage(named: "eye.png"), for: .normal)
        self.frgtPwdView.isHidden = true
        
        loginViewModel.loginDelegate = self
        loginViewModel.retDlgt = self
        
          
//        passwordTextField.successImage = UIImage(named: "thumb_up")
//        passwordTextField.errorImage = UIImage(named: "thumb_down")
        //loginViewModel.getLoginData()
        
        //var val = loginViewModel.getLoginData()
        //print(val)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clkFrgtPwd()
    {
        if(self.frgtPwdView.isHidden == false)
        {
            self.frgtPwdView.isHidden = true
        }
        else
        {
            self.frgtPwdView.isHidden = false
        }
    }
    @objc func networkStatusChanged(_ notification: Notification) {
            let status = Reach().connectionStatus()
            
            let size = CGSize(width: 30, height: 30)
            
            switch status {
            case .unknown, .offline:
                print("Not connected")
            DispatchQueue.main.async {
                self.startAnimating(size, message: "No Network Connection !")
            }
            
//            JSSAlertView().warning(
//              self,
//              title: "Alert",
//              text: "No Network Connection !"
//            )
            //self.AlertDisplay(mytitle: "", mymessage: "Sin conexión a Internet")
            break
        default :
            DispatchQueue.main.async
                {
                self.stopAnimating()
            }
            
            break
        }
    }
    @IBAction func frgtPwdSubmit()
    {
        self.view.endEditing(true)
        self.loginViewModel.validateFrgtPwd(emlVal: self.frgtEmailTxt.text!)
    }
    @IBAction func buttonAction(_ button: TransitionButton) {
        self.addbutton.startAnimation() // 2: Then start the animation when the user tap the button
            let qualityOfServiceClass = DispatchQoS.QoSClass.background
            let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
            backgroundQueue.async(execute: {
                
                sleep(3) // 3: Do your networking task or background work here.
                
                DispatchQueue.main.async(execute: { () -> Void in
                    self.loginViewModel.validate(emlVal: self.emailTxt.text!, pwdVal: self.pwdTxt.text!)
                    
                    // 4: Stop the animation, here you have three options for the `animationStyle` property:
                    // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                    // .shake: when you want to reflect to the user that the task did not complete successfly
                    // .normal
                    self.addbutton.stopAnimation(animationStyle: .shake, completion: {
                        self.addbutton.layer.cornerRadius = self.addbutton.frame.height/2
                        self.addbutton.layer.masksToBounds = true
                        //let secondVC = UIViewController()
                        //self.present(secondVC, animated: true, completion: nil)
                    })
                })
            })
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

