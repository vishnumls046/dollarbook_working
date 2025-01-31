//
//  currencyViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 06/02/25.
//

import UIKit
import NVActivityIndicatorView
protocol crncyProt
{
    func updtCrncy(TblTyp:String)
    func crncyTblSelect(crncy:String,crncyId:String,crncycode:String)
}
class currencyViewController: UIViewController,crncyProt,NVActivityIndicatorViewable,UISearchBarDelegate, UIScrollViewDelegate {
    @IBOutlet weak var crncyTbl:UITableView!
    @IBOutlet weak var crncyView:UICollectionView!
    @IBOutlet weak var crcnyDdlBgCurv:UILabel!
    @IBOutlet var crncyTblView : UIView!
    @IBOutlet var slctTblTitle : UILabel!
    var crcyVwMdl = currencyViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.crcyVwMdl.crncyDlgt = self
        DispatchQueue.global().async {
            self.crcyVwMdl.getCurrency(key: "")
        }
        
        self.crncyTbl.dataSource = crcyVwMdl
        self.crncyTbl.delegate = crcyVwMdl
        
        // Do any additional setup after loading the view.
    }
    func updtCrncy(TblTyp:String) {
        self.stopAnimating()
        if(TblTyp == "currency")
        {
           // self.slctTblTitle.text = "Select Currency"
        }
        else
        {
            //self.slctTblTitle.text = "Select Account"
        }
        self.crncyTbl.reloadData()
        
    }
    func crncyTblSelect(crncy: String, crncyId: String,crncycode:String) {
        //textView.attributedText = htmlText.htmlToAttributedString
        self.view.endEditing(true)
//        self.crncyVal = crncyId
//        self.crncyTxt.text = crncy
        //self.crcnyDdlBgCurv.text = (crncycode.htmlToString)
        //self.crncyTblView.isHidden = true
        //self.crncyTbl.reloadData()
        DispatchQueue.global().async {
            self.crcyVwMdl.getCurrency(key: "")
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
extension currencyViewController {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)        {
        print(searchText)
        self.crcyVwMdl.getCurrency(key:searchText)
      //code
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("search cancel clicked")
        
     //code
    }
}
