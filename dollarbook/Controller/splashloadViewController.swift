//
//  splashloadViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 26/08/22.
//

import UIKit
import Foundation
import NVActivityIndicatorView
protocol splashProt
{
    func userExist()
    func userNotExist()
}

class splashloadViewController: UIViewController,NVActivityIndicatorViewable, splashProt {
    @IBOutlet weak var prpLbl:UILabel!
    @IBOutlet weak var load:NVActivityIndicatorView!
    @IBOutlet weak var logo:UIImageView!
    var splshMdl = SplashViewModel()
    
    func userExist()
    {
        self.performSegue(withIdentifier: "autologin", sender: self)
    }
    func userNotExist()
    {
        self.goToSlctCrncy()
    }
    override func viewDidLoad() {
        self.splshMdl.splshProt = self
        super.viewDidLoad()
        //let animationImages = self.logo
        //imageView.animationImages = animationImages
        //self.logo.animationDuration = 10
        self.logo.alpha = 0
        self.prpLbl.alpha = 0
        
        // Do any additional setup after loading the view.
    }
    func goToSlctCrncy()
    {
        self.performSegue(withIdentifier: "login", sender: self)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.logo.fadeIn()
        self.prpLbl.fadeIn()
        //self.prpLbl.layer.cornerRadius = self.prpLbl.frame.size.height/2
        self.prpLbl.cornerRadius = self.prpLbl.frame.size.height/2
        self.prpLbl.layer.masksToBounds = true
        self.load.startAnimating()
        
        if(UserDefaults.standard.value(forKey: "user_status") == nil)
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                self.goToSlctCrncy()
            })
        }
        else
        {
            self.splshMdl.userCheck(from: "splash")
            //self.performSegue(withIdentifier: "autologin", sender: self)
        }
            
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
public extension UIView {

/**
 Fade in a view with a duration
 
 - parameter duration: custom animation duration
 */
 func fadeIn(duration: TimeInterval = 2.0) {
     UIView.animate(withDuration: duration, animations: {
        self.alpha = 1.0
     })
 }

/**
 Fade out a view with a duration
 
 - parameter duration: custom animation duration
 */
func fadeOut(duration: TimeInterval = 1.0) {
    UIView.animate(withDuration: duration, animations: {
        self.alpha = 0.0
    })
  }
func zoom()
    {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                  self.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
              }) { (finished) in
                  UIView.animate(withDuration: 1, animations: {
                  self.transform = CGAffineTransform.identity
              })
              }
    }
}
