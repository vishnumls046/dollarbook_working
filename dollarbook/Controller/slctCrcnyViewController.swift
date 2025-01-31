//
//  splashloadViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 26/08/22.
//

import UIKit
import Foundation
import NVActivityIndicatorView

class slctCrcnyViewController: UIViewController,NVActivityIndicatorViewable,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var prpLbl:UILabel!
    @IBOutlet weak var load:NVActivityIndicatorView!
    @IBOutlet weak var logo:UIImageView!
    @IBOutlet weak var arrow:UIImageView!
    @IBOutlet weak var crncyView:UICollectionView!
    var crncyArry = NSMutableArray(array: ["€", "₹", "$","£","﷼","₽","¥"])
    var crncyNmeArry = NSMutableArray(array: ["Euro", "INR", "USD","GBP","SAR","RUB","JPY"])
    override func viewDidLoad() {
        self.arrow.dropShadow(color: UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.4), opacity: 0.3, offSet: CGSize(width: -1, height: 1), radius: 55, scale: true)
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.logo.alpha = 0
        //self.prpLbl.alpha = 0
        self.logo.fadeIn()
        Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.alarmAlertActivate), userInfo: nil, repeats: true)
        
        //self.prpLbl.fadeIn()
    }
    @objc func alarmAlertActivate(){
            UIView.animate(withDuration: 0.7) {
                self.arrow.alpha = self.arrow.alpha == 1.0 ? 0.8 : 1.0
            }
        }
    func goToSlctCrncy()
    {
        self.performSegue(withIdentifier: "slctcrncy", sender: self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return crncyArry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crncyCell", for: indexPath) as! CustomImageCell
        let mydata = crncyArry[indexPath.item]
        cell.title.text = mydata as? String
        cell.crncy.text = crncyNmeArry[indexPath.item] as? String
//        cell.bgLbl.layer.cornerRadius = cell.bgLbl.frame.width/2
//        cell.bgLbl.layer.masksToBounds = true
        cell.bgLbl.layer.borderColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0).cgColor
        cell.bgLbl.layer.borderWidth = 1.0
//        if mydata["type"] as! String == "1"{
//           cell.pic.image = mydata["data"] as! UIImage
//        }
//        else{
//            cell.pic.image = #imageLiteral(resourceName: "PlayCollect")
//        }
        //cell.deleteBttn.tag = indexPath.item
        //cell.deleteBttn.addTarget(self, action: #selector(self.handleDelete), for: .touchUpInside)
        return cell
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


}
class CustomImageCell: UICollectionViewCell {
    //@IBOutlet weak var pic: UIImageView!
    //@IBOutlet weak var deleteBttn: UIButton!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var crncy: UILabel!
    @IBOutlet weak var bgLbl: UILabel!
    
    
}
