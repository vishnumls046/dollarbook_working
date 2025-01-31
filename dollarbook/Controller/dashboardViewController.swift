//
//  dashboardViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 30/08/22.
//

import UIKit
//import RingPieChart
class dashboardViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    @IBOutlet weak var incmeBg:UILabel!
    @IBOutlet weak var expnsBg:UILabel!
    @IBOutlet weak var incTileBg:UIView!
    @IBOutlet weak var expTileBg:UIView!
    @IBOutlet weak var grphView:UIView!
    @IBOutlet weak var ddlBtn:UIButton!
    @IBOutlet weak var filterBtn:UIButton!
    @IBOutlet weak var grphlLoadView:UIView!
    @IBOutlet weak var grphlLoadCrv:UILabel!
    @IBOutlet weak var incmBubble:UILabel!
    @IBOutlet weak var expnseBubble:UILabel!
    @IBOutlet weak var tagsClnView:UICollectionView!
    @IBOutlet weak var recentsTblView:UITableView!
    
    var tagNameArry = NSMutableArray(array: ["Cafe", "Grocery", "Taxi","Loan","Fees", "Taxi","Loan","Fees"])
    
    var incExpNameArry = NSMutableArray(array: ["Salary", "Interest", "Bakery","Shopping","Medicine", "Divident","Electricity bill","Interest"])
    var incExpArry = NSMutableArray(array: ["1", "1", "2","2","2", "1","2","1"])
    var incExpTimeArry = NSMutableArray(array: ["2 Hours ago ", "5 Hours ago", "A day ago","30/Aug/2022","30/Aug/2022", "29/Aug/2022","29/Aug/2022","28/Aug/2022"])
    var incExpAmntArry = NSMutableArray(array: ["1000", "3000", "500","456","700", "200","1200","1850"])
    //var crncyNmeArry = NSMutableArray(array: ["Euro", "INR", "USD","GBP","RYL","SND","YEN"])
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.grphlLoadCrv.cornerRadius = self.grphlLoadCrv.frame.width/2
        self.incmBubble.cornerRadius = self.incmBubble.frame.height/2
        self.expnseBubble.cornerRadius = self.expnseBubble.frame.height/2
        self.incmeBg.cornerRadius = self.incmeBg.frame.height/2
        self.expnsBg.cornerRadius = self.incmeBg.frame.height/2
        self.incTileBg.cornerRadius = 17
        self.incTileBg.borderColor = UIColor(red: 211/255, green: 221/255, blue: 230/255, alpha: 1.0)
        self.incTileBg.shadowRadius = 3
        self.incTileBg.borderWidth = 1
        self.expTileBg.cornerRadius = 17
        self.expTileBg.borderColor = UIColor(red: 211/255, green: 221/255, blue: 230/255, alpha: 1.0)
        self.expTileBg.borderWidth = 1
        self.incTileBg.dropShadow(color: UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.7), opacity: 0.4, offSet: CGSize(width: -1, height: 1), radius: 17, scale: true)
        self.expTileBg.dropShadow(color: UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.7), opacity: 0.4, offSet: CGSize(width: -1, height: 1), radius: 17, scale: true)
        
        self.tagsClnView.dropShadow(color: UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.1), opacity: 0.1, offSet: CGSize(width: -1, height: 1), radius: 17, scale: true)
        
        self.grphView.cornerRadius = 17
        self.grphView.borderColor = UIColor(red: 211/255, green: 221/255, blue: 230/255, alpha: 1.0)
        self.grphView.borderWidth = 1
        self.grphView.dropShadow(color: UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 0.3), opacity: 0.3, offSet: CGSize(width: -1, height: 1), radius: 17, scale: true)
        
        self.ddlBtn.cornerRadius = 9
        self.ddlBtn.borderColor = UIColor(red: 186/255, green: 178/255, blue: 210/255, alpha: 1.0)
        self.ddlBtn.borderWidth = 1
        self.filterBtn.cornerRadius = 9
        self.filterBtn.borderColor = UIColor(red: 186/255, green: 178/255, blue: 210/255, alpha: 1.0)
        self.filterBtn.borderWidth = 1
        
        
        
         
        
//        let chart = Circular(percentages: [42,27,18,13], colors: [.blue,.purple,.orange,.red],aimationType: .animationFadeIn,showPercentageStyle: .inward)
//        chart.frame = CGRect(x: 50, y: 50, width: 250, height: 250)
//         self.view .addSubview(chart)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let chart = Circular(percentages: [50,40], colors: [UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0),UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)],aimationType: .animationFanAll,showPercentageStyle: .inward)
        chart.frame = CGRect(x: 35, y: 50, width: 250, height: 250)
        self.grphlLoadView.addSubview(chart)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagNameArry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crncyCell", for: indexPath) as! tagsViewCell
        let mydata = tagNameArry[indexPath.item]
        //cell.bgLbl.cornerRadius = 8
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        cell.tagshort.cornerRadius = cell.tagshort.frame.height/2
        cell.tagName.text = mydata as? String
        
        //cell.title.text = mydata as? String
        //cell.tagshort.text = "A"
        //cell.bgLbl.cornerRadius = 8
//        cell.bgLbl.layer.cornerRadius = 27
//        cell.bgLbl.layer.masksToBounds = true
//        cell.bgLbl.layer.borderColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0).cgColor
//        cell.bgLbl.layer.borderWidth = 1.0
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.incExpArry.count
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
           let cell = tableView.dequeueReusableCell(withIdentifier: "listRecent", for: indexPath) as! recentTblViewCell
           cell.crvdLbl.cornerRadius = 11
        //var ordList = orderLst()
           
           let str = self.incExpNameArry[indexPath.row] as! String
           cell.title.text = str
           cell.time.text = self.incExpTimeArry[indexPath.row] as! String
           if(self.incExpArry[indexPath.row] as! String == "1")
           {
               cell.Icn.image = UIImage(named: "IncmTbl_Icn")
               cell.crvdLbl.backgroundColor = UIColor(red: 242/255, green: 238/255, blue: 255/255, alpha: 1.0)
               cell.amount.textColor = UIColor(red: 145/255, green: 11/255, blue: 239/255, alpha: 1.0)
               cell.amount.text = "+$\(self.incExpAmntArry[indexPath.row] as! String)"
           }
           else
           {
               cell.Icn.image = UIImage(named: "expTbl_Icn")
               cell.crvdLbl.backgroundColor = UIColor(red: 254/255, green: 232/255, blue: 232/255, alpha: 1.0)
               cell.amount.textColor = UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
               cell.amount.text = "-$\(self.incExpAmntArry[indexPath.row] as! String)"
           }
           
        //cell.title.text = str
        //cell.time.text = str
        //cell.amount.text = str
        
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
extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 3, height: 2)
            layer.shadowOpacity = 0.8
            layer.shadowRadius = shadowRadius
        }
    }
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
    
}
class tagsViewCell: UICollectionViewCell {
    //@IBOutlet weak var pic: UIImageView!
    //@IBOutlet weak var deleteBttn: UIButton!
    @IBOutlet weak var tagName: UILabel!
    @IBOutlet weak var tagImg: UIImageView!
    @IBOutlet weak var tagshort: UILabel!
    @IBOutlet weak var bgLbl: UILabel!
    @IBOutlet weak var amount: UILabel!
    
}
class recentTblViewCell: UITableViewCell {
    @IBOutlet weak var Icn: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var crvdLbl: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var shortNme: UILabel!
    @IBOutlet weak var frmAcntLbl: UILabel!
    @IBOutlet weak var toAcntLbl: UILabel!
    @IBOutlet weak var trnsfrIcn: UIImageView!
    
    @IBOutlet weak var percntgVal: UILabel!
    @IBOutlet weak var percntg: UILabel!
    @IBOutlet weak var percntgBg: UILabel!
    @IBOutlet weak var percntgLength: NSLayoutConstraint!
}
