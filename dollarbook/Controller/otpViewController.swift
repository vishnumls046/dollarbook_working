//
//  otpViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 06/02/25.
//

import UIKit
import KWVerificationCodeView
import NVActivityIndicatorView
import SwiftEntryKit
protocol otpViewProt
{
    func showAlert(msg:String)
    func otpVerifyRedirect()
    func displayOtpField()
}
class otpViewController: UIViewController,otpViewProt, KWVerificationCodeViewDelegate,NVActivityIndicatorViewable {
    @IBOutlet weak var verificationCodeView: KWVerificationCodeView!
    @IBOutlet weak var otpLegnd:UILabel!
    @IBOutlet weak var otpCnstrnt:NSLayoutConstraint!
    @IBOutlet weak var emailTxt:UITextField!
    @IBOutlet weak var sendOtpImg:UIButton!
    var otpViewMdlObj = otpViewModal()
    var cnt = 0
    func didChangeVerificationCode() {
      if(self.verificationCodeView.hasValidCode())
        {
         
          self.startAnimating()
          self.view.endEditing(true)
          let email =  self.emailTxt.text!
          let otpval = self.verificationCodeView.getVerificationCode()
          DispatchQueue.global().async {
            self.otpViewMdlObj.verifyOtp(email: email, otp: otpval)
        }
          
      }
    }
    func otpVerifyRedirect()
    {
        self.performSegue(withIdentifier: "otpRedirect", sender: self)
    }
    func showAlert(msg:String)
    {
        self.stopAnimating()
        // Generate top floating entry and set some properties
        var attributes = EKAttributes.topFloat
        //attributes.entryBackground = .color(color: EKColor(ColorManager.incomeColor()))
        attributes.entryBackground = .gradient(
            gradient: .init(
                colors: [EKColor(UIColor(red: 195/255, green: 182/255, blue: 253/255, alpha: 1.0)), EKColor(UIColor(red: 131/255, green: 108/255, blue: 244/255, alpha: 1.0))],
                startPoint: .zero,
                endPoint: CGPoint(x: 1, y: 1)
            )
        )
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        attributes.statusBar = .dark
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        //attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)

        let title = EKProperty.LabelContent(
            text: "Dollarbook",
            style: .init(
                font: .systemFont(ofSize: 14, weight: .bold),
                color: EKColor(UIColor.white),
                alignment: .left,
                displayMode: .light
            )
        )
        let Description = EKProperty.LabelContent(
            text: msg,
            style: .init(
                font: .systemFont(ofSize: 12, weight: .light),
                color: EKColor(UIColor.white),
                alignment: .left,
                displayMode: .light
            )
        )
        let image = EKProperty.ImageContent(image: UIImage(named: "logo3.png")!, size: CGSize(width: 44, height: 30))
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: Description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)

        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.emailTxt.becomeFirstResponder()
        //self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.otpViewMdlObj.otpProtDlgt = self
        //self.verificationCodeView.isUserInteractionEnabled = false
        self.verificationCodeView.resignFirstResponder()
        self.otpLegnd.isHidden = true
        self.verificationCodeView.isHidden = true
        self.otpCnstrnt.constant = 30
        // Do any additional setup after loading the view.
    }
    @IBAction func clickSendOtp()
    {
        self.startAnimating()
        let emailVal = emailTxt.text!
        DispatchQueue.global().async {
            self.otpViewMdlObj.sendOtp(email: emailVal)
        }
    }
    func displayOtpField()
    {
        self.stopAnimating()
        verificationCodeView.delegate = self
        self.verificationCodeView.isUserInteractionEnabled = true
        self.verificationCodeView.focus()
        self.otpLegnd.isHidden = false
        self.verificationCodeView.isHidden = false
        self.otpCnstrnt.constant = 169
        self.verificationCodeView.becomeFirstResponder()
        let newImage = UIImage(named: "resendOtp.png")
        
        self.sendOtpImg.setImage(newImage, for: .normal)
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
