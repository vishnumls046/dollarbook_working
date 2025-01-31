//
//  TagManageViewController.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 07/12/22.
//

import UIKit
import NVActivityIndicatorView
import RandomColorSwift
import Kingfisher
protocol tagmanageProt
{
    func loadIconsCln()
    func loadTagsCln()
    func valdteTag(alrtStr:String)
    func editTag(tagNme:String,tagType:String,tagId:String,tagIcnClr:String,tagIcnUrl:String,tagIcnId:String)
    func closeTagView(tagTyp:String)
}
class TagManageViewController: UIViewController,tagmanageProt,NVActivityIndicatorViewable,UIGestureRecognizerDelegate {
    @IBOutlet weak var iconsCln:UICollectionView!
    @IBOutlet weak var tagsCln:UICollectionView!
    @IBOutlet weak var colorsCln:UICollectionView!
    @IBOutlet weak var tagSwitch: UISwitch!
    @IBOutlet weak var addTagView:UIView!
    @IBOutlet weak var addBtn:UIButton!
    @IBOutlet weak var AddTagBtn:UIButton!
    @IBOutlet weak var EditTagBtn:UIButton!
    @IBOutlet weak var tagNmeTxt:UITextField!
    @IBOutlet weak var tagIdTxt:UITextField!
    @IBOutlet weak var addEditLbl:UILabel!
    @IBOutlet weak var noTags:UILabel!
    @IBOutlet weak var AddEditTagSwitch: UISwitch!
    @IBOutlet weak var ctgryIcon: UIImageView!
    @IBOutlet weak var doneBg: UIImageView!
    @IBOutlet weak var ctgryIconBgLbl: UILabel!
    var tagmanageViewMdl = tagmanageViewModel()
    
    var iconUrl = ""
    var slctColor = UIColor.gray
    var switchVal = "income"
    var tag_Id = ""
    var icn_id = ""
    //var colors: [UIColor]!
    var colors = [
        UIColor(red: 0.17, green: 0.55, blue: 0.99, alpha: 1.00),
        UIColor(red: 0.16, green: 0.68, blue: 0.18, alpha: 1.00),
        UIColor(red: 0.35, green: 0.27, blue: 0.95, alpha: 1.00),
        UIColor(red: 0.65, green: 0.78, blue: 0.49, alpha: 1.00),
        UIColor(red: 0.00, green: 0.76, blue: 0.95, alpha: 1.00),
        UIColor(red: 0.84, green: 0.71, blue: 0.03, alpha: 1.00),
        UIColor(red: 0.89, green: 0.85, blue: 0.45, alpha: 1.00),
        UIColor(red: 0.55, green: 0.21, blue: 0.15, alpha: 1.00),
        UIColor(red: 0.15, green: 0.62, blue: 0.32, alpha: 1.00),
        UIColor(red: 0.40, green: 0.88, blue: 0.19, alpha: 1.00),
        UIColor(red: 0.37, green: 0.82, blue: 0.69, alpha: 1.00),
        UIColor(red: 0.72, green: 0.75, blue: 0.18, alpha: 1.00),
        UIColor(red: 0.74, green: 0.16, blue: 0.75, alpha: 1.00),
        UIColor(red: 0.50, green: 0.44, blue: 0.47, alpha: 1.00),
        UIColor(red: 0.86, green: 0.42, blue: 0.78, alpha: 1.00),
        UIColor(red: 0.34, green: 0.40, blue: 0.60, alpha: 1.00),
        UIColor(red: 0.62, green: 0.60, blue: 0.97, alpha: 1.00),
        UIColor(red: 0.18, green: 0.71, blue: 0.74, alpha: 1.00),
        UIColor(red: 0.38, green: 0.09, blue: 0.48, alpha: 1.00),
        UIColor(red: 0.29, green: 0.73, blue: 0.49, alpha: 1.00),
        UIColor(red: 0.56, green: 0.47, blue: 0.92, alpha: 1.00),
        UIColor(red: 0.49, green: 0.25, blue: 0.37, alpha: 1.00),
        UIColor(red: 0.20, green: 0.73, blue: 0.49, alpha: 1.00),
        UIColor(red: 0.15, green: 0.28, blue: 0.40, alpha: 1.00),
        UIColor(red: 0.01, green: 0.77, blue: 0.43, alpha: 1.00),
        UIColor(red: 0.55, green: 0.59, blue: 0.32, alpha: 1.00),
        UIColor(red: 0.10, green: 0.03, blue: 0.83, alpha: 1.00),
        UIColor(red: 0.20, green: 0.72, blue: 0.43, alpha: 1.00)
    ]
    fileprivate var count = 45
    fileprivate var hue: Hue = .random
    fileprivate var luminosity: Luminosity = .bright
    
    func loadIconsCln()
    {
        if(tagmanageViewModel.sections.count > 0)
        {
            self.iconsCln.reloadData()
        }
        else
        {
            
        }
    }
    func deleteAlert()
    {
        DispatchQueue.main.async {
            var refreshAlert = UIAlertController(title: "DollarBook", message: "Do you want to delete tag ?", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                self.startAnimating()
                DispatchQueue.global().async {
                    if(self.switchVal == "income")
                    {
                        self.tagmanageViewMdl.delTag(tagId:self.tag_Id, tagType: "1")
                    }
                    else if(self.switchVal == "expense")
                    {
                        self.tagmanageViewMdl.delTag(tagId:self.tag_Id, tagType: "2")
                    }
                    //self.dashViewModel.Dlt()
                }
                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            self.present(refreshAlert, animated: true, completion: nil)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        self.ctgryIconBgLbl.layer.cornerRadius = self.ctgryIconBgLbl.frame.width/2
        self.ctgryIconBgLbl.layer.masksToBounds = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshColor()
        self.AddTagBtn.isHidden = true
        self.EditTagBtn.isHidden = true
        self.doneBg.isHidden = true
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        self.tagsCln?.addGestureRecognizer(longPressedGesture)
        
        
        
        //self.addBtn.setBackgroundImage(UIImage(named: "plus"), for: .normal)
        self.tagmanageViewMdl.tagmangDlt = self
        self.addTagView.isHidden = true
        self.tagSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        // Do any additional setup after loading the view.
    }
    func refreshColor() {
        //colors = randomColors(count: count, hue: hue, luminosity: luminosity)
        self.colorsCln?.reloadData()
    }
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
            return
        }

        let p = gestureRecognizer.location(in: self.tagsCln)

        if let indexPath = self.tagsCln?.indexPathForItem(at: p) {
            self.deleteAlert()
            print("Long press at item: \(indexPath.row)")
            self.tag_Id = tagmanageViewModel.tagArry1[indexPath.row].tagId!
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.noTags.isHidden = true
        self.startAnimating()
        DispatchQueue.global().async {
            self.tagmanageViewMdl.getTags(tags:self.switchVal)
            self.tagmanageViewMdl.getIcons()
            
        }
        
    }
    
    func closeTagView(tagTyp:String)
    {
        DispatchQueue.main.async {
        
        self.view.endEditing(true)
        self.tagmanageViewMdl.getTags(tags: self.switchVal)
       // self.addBtn.setBackgroundImage(UIImage(named: "plus"), for: .normal)
        self.addTagView.isHidden = true
        }
        if(tagTyp == "1")
        {
            
            self.switchVal = "income"
            DispatchQueue.main.async {
                
                self.tagSwitch.setOn(false, animated: false)
            }
            DispatchQueue.global().async {
                self.tagmanageViewMdl.getTags(tags: self.switchVal)
            }
        }
        else
        {
            self.switchVal = "expense"
            DispatchQueue.main.async {
                self.tagSwitch.setOn(true, animated: false)
            }
            DispatchQueue.global().async {
                self.tagmanageViewMdl.getTags(tags: self.switchVal)
            }
        }
    }
    @IBAction func addTagSubmit()
    {
        self.tagmanageViewMdl.validateAddTag(tagName: self.tagNmeTxt.text!, tagType: self.AddEditTagSwitch.isOn,tagIcnClr: self.slctColor,tagIcnUrl: self.iconUrl,tagIcnId: self.icn_id)
        
    }
    func valdteTag(alrtStr:String) {
        let alert = UIAlertController(title: "Dollar Book", message: alrtStr, preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    func loadTagsCln() {
        self.stopAnimating()
        if(tagmanageViewModel.tagArry1.count > 0)
        {
            self.tagsCln.isHidden = false
            self.noTags.isHidden = true
            self.tagsCln.reloadData()
        }
        else
        {
            self.tagsCln.isHidden = true
            self.noTags.isHidden = false
        }
    }
    @objc func switchChanged(mySwitch: UISwitch) {
        self.startAnimating()
        let value = mySwitch.isOn
        if(value == false)
        {
            self.switchVal = "income"
        }
        else
        {
            self.switchVal = "expense"
        }
        DispatchQueue.global().async {
            self.tagmanageViewMdl.getTags(tags: self.switchVal)
        }
        
        // Do something
    }
    @IBAction func clkAddBtn()
    {
        if(self.switchVal == "income")
        {
            self.AddEditTagSwitch.isOn = false
        }
        else if(self.switchVal == "expense")
        {
            self.AddEditTagSwitch.isOn = true
        }
        self.addEditLbl.text = "Add Tag"
        self.tagNmeTxt.text = ""
        self.AddTagBtn.isHidden = false
        self.EditTagBtn.isHidden = true
        if(self.addTagView.isHidden == true)
        {
           // self.addBtn.setBackgroundImage(UIImage(named: "minus"), for: .normal)
            self.addTagView.isHidden = false
            self.AddTagBtn.isHidden = true
            self.EditTagBtn.isHidden = true
            self.doneBg.isHidden = true
            
        }
        else
        {
           // self.addBtn.setBackgroundImage(UIImage(named: "plus"), for: .normal)
            self.addTagView.isHidden = true
            self.AddTagBtn.isHidden = false
            self.EditTagBtn.isHidden = false
            self.doneBg.isHidden = false
        }
    }
    func editTag(tagNme:String,tagType:String,tagId:String,tagIcnClr:String,tagIcnUrl:String,tagIcnId:String)
    {
        self.icn_id = tagIcnId
        self.iconUrl = tagIcnUrl
        self.slctColor = Color(hex: tagIcnClr)
      //  self.addBtn.setBackgroundImage(UIImage(named: "minus"), for: .normal)
        self.addEditLbl.text = "Edit Tag"
        self.addTagView.isHidden = false
        self.tagNmeTxt.text = tagNme
        self.ctgryIconBgLbl.backgroundColor = UIColor(hex: tagIcnClr)
        if let url = URL(string: tagIcnUrl) {
            
            let processor = OverlayImageProcessor(overlay: UIColor(hex: tagIcnClr), fraction: 0.1)
            
            // Load the image with Kingfisher and apply the tint
            //                           self.ctgryIcon.kf.setImage(
            //                                       with: url)
            
            self.ctgryIcon.kf.setImage(with: url, options: [.processor(processor)])
        }
        if(tagType == "1")
        {
            self.AddEditTagSwitch.isOn = false
        }
        else
        {
            self.AddEditTagSwitch.isOn = true
        }
        self.tagIdTxt.text = tagId
        self.AddTagBtn.isHidden = true
        self.EditTagBtn.isHidden = false
        self.tagmanageViewMdl.getIcons()
        //self.submitBtn.tag = Int(acntId)!
        self.EditTagBtn.addTarget(self, action: #selector(editSbmt), for: .touchUpInside)
    }
    @IBAction func editSbmt(sender: UIButton)
    {
        self.tagmanageViewMdl.validateEditTag(tagName: self.tagNmeTxt.text!,tagType:self.AddEditTagSwitch.isOn,tagId:self.tagIdTxt.text!,tagIcnClr: self.slctColor,tagIcnUrl: self.iconUrl,iconId: self.icn_id)
    }
    @IBAction func back()
    {
        if(self.addTagView.isHidden)
        {
            self.dismiss(animated: false, completion: nil)
        }
        else
        {
            self.addTagView.isHidden = true
          //  self.addBtn.setBackgroundImage(UIImage(named: "plus"), for: .normal)
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
extension TagManageViewController:UICollectionViewDataSource,UICollectionViewDelegate
{
    // tag 1 ->  List Category Clcn
    // tag 2 ->  List Icons Clcn
    // else   ->  List Color Clcn
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if(collectionView.tag == 1)
        {
            return 1
        }
        else if(collectionView.tag == 2)
        {
            return tagmanageViewModel.sections.count
        }
        else
        {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView.tag == 1)
        {
            return tagmanageViewModel.tagArry1.count
        }
        else if(collectionView.tag == 2) // cons Clcn
        {
            return tagmanageViewModel.sections[section].items.count
        }
        else
        {
            return colors.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView.tag == 1)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crncyCell", for: indexPath) as! tagsViewCell
            cell.layer.borderWidth = 0.0
            cell.layer.borderColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0).cgColor
            let mydata = tagmanageViewModel.tagArry1[indexPath.item]
            let tagData = tagmanageViewModel.tagArry1[indexPath.item]
            //cell.bgLbl.cornerRadius = 8
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
            cell.tagshort.cornerRadius = cell.tagshort.frame.height/2
            if(mydata.iconClor != nil)
            {
                cell.tagshort.backgroundColor = Color(hex: mydata.iconClor!)
                if let url = URL(string: "\(mydata.iconUrl!)") {
                    let processor = OverlayImageProcessor(overlay: Color(hex: mydata.iconClor!), fraction: 0.1)
                    
                            // Load the image with Kingfisher and apply the tint
    //                           self.ctgryIcon.kf.setImage(
    //                                       with: url)
                    cell.tagImg.kf.setImage(with: url, options: [.processor(processor)])
                    
                        }
            }
            cell.tagshort.alpha = 0.0
            cell.tagshort.text = ""
            cell.bgLbl.backgroundColor = Color(hex: mydata.iconClor!)
            cell.bgLbl.alpha = 0.2
            //cell.tagshort.backgroundColor = UIColor.red
            //cell.tagName.text = mydata
            var tagname = mydata.tagName!.prefix(1)
            //cell.tagshort.text = "\(tagname.uppercased())"
            cell.tagName.text = mydata.tagName!
//            if(self.switchVal == "income")
//            {
//                //cell.tagshort.backgroundColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
//                cell.tagshort.backgroundColor = ColorManager.incomeColor()
//            }
//            else
//            {
//                //cell.tagshort.backgroundColor = UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
//                cell.tagshort.backgroundColor = ColorManager.expenseColor()
//                
//            }
            
            return cell
        }
        else if(collectionView.tag == 2)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconcell", for: indexPath) as! tagsViewCell
            let url = URL(string: "\(tagmanageViewModel.sections[indexPath.section].items[indexPath.item])")
            cell.tagImg.kf.setImage(with: url)
            if(tagmanageViewModel.sections[indexPath.section].iconIds[indexPath.item] == self.icn_id)
            {
                cell.contentView.backgroundColor = UIColor.lightGray
            }
            else
            {
                cell.contentView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
            }
            
//            cell.layer.cornerRadius = cell.frame.width/2
//            cell.layer.masksToBounds = true
            //cell.tagImg.image = tagmanageViewModel.sections[indexPath.section].items[indexPath.item]
            return cell
            
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as! tagsViewCell
            //cell.contentView.backgroundColor = colors[indexPath.row]
            cell.bgLbl.backgroundColor = colors[indexPath.row]
            cell.bgLbl.layer.cornerRadius = cell.bgLbl.frame.width/2
            cell.bgLbl.layer.masksToBounds = true
            return cell
        }
        let fallbackCell = UICollectionViewCell()
            fallbackCell.backgroundColor = .clear // Optional: Visual indication for debugging
            return fallbackCell
    }
    // MARK: Header View

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if(collectionView.tag == 2)
        {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "iconHeader", for: indexPath)
            header.backgroundColor = .clear
            // Remove all subviews
                    for subview in header.subviews {
                        subview.removeFromSuperview()
                    }
            // Add label to header
            let label = UILabel(frame: header.bounds)
            label.text = tagmanageViewModel.sections[indexPath.section].name
            label.textColor = .darkGray
            //label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textAlignment = .left
            header.addSubview(label)
            
            return header
        }
        return UICollectionReusableView()
    }
        let fallbackCell = UICollectionViewCell()
            fallbackCell.backgroundColor = .clear // Optional: Visual indication for debugging
            return fallbackCell
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView.tag == 1)
        {
            for cell in collectionView.visibleCells {
                    if let customCell = cell as? UICollectionViewCell {
                        customCell.layer.borderWidth = 0.0
                    }
                }

            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0).cgColor
            let mydata = tagmanageViewModel.tagArry1[indexPath.item]
            
            //print(self.slctdTagArry)
            
            
            self.editTag(tagNme: mydata.tagName!, tagType: mydata.tagType!, tagId: mydata.tagId!,tagIcnClr:mydata.iconClor! ,tagIcnUrl: mydata.iconUrl!,tagIcnId: mydata.iconId!)
        }
        else if(collectionView.tag == 2)
        {
            for cell in collectionView.visibleCells {
                    if let customCell = cell as? UICollectionViewCell {
                        customCell.contentView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1.0) // Reset appearance
                    }
                }
            if  let cell = collectionView.cellForItem(at: indexPath)
            {
                cell.contentView.backgroundColor = UIColor.lightGray
                
                
            }
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconcell", for: indexPath) as! tagsViewCell
//            cell.bgLbl.backgroundColor = UIColor.red
            if let url = URL(string: "\(tagmanageViewModel.sections[indexPath.section].items[indexPath.item])") {
                let processor = OverlayImageProcessor(overlay: UIColor.darkGray, fraction: 0.1)
                self.ctgryIcon.kf.setImage(with: url, options: [.processor(processor)])
                    }
           // let url = URL(string: "\(tagmanageViewModel.sections[indexPath.section].items[indexPath.item])")
            // URL of the image
                   if let url = URL(string: "\(tagmanageViewModel.sections[indexPath.section].items[indexPath.item])")
            {
                       // Apply a tint color using Kingfisher's TintImageProcessor
                       let processor = TintImageProcessor(tint: .red)

                       // Load the image with Kingfisher
//                       self.ctgryIcon.kf.setImage(
//                           with: url,
//                           options: [
//                               .processor(processor), // Apply the tint processor
//                               .transition(.fade(0.3)) // Add a fade animation
//                           ]
//                       )
                       
                       if let url = URL(string: "\(tagmanageViewModel.sections[indexPath.section].items[indexPath.item])") {
                                   // Use Kingfisher's TintImageProcessor to apply a tint color
                                  // let processor = TintImageProcessor(tint: .blue) // Set the desired tint color
                           let processor = OverlayImageProcessor(overlay: self.slctColor, fraction: 0.1)
                           
                                   // Load the image with Kingfisher and apply the tint
//                           self.ctgryIcon.kf.setImage(
//                                       with: url)
                           self.ctgryIcon.kf.setImage(with: url, options: [.processor(processor)])
                           self.iconUrl = tagmanageViewModel.sections[indexPath.section].items[indexPath.item]
                           self.icn_id = tagmanageViewModel.sections[indexPath.section].iconIds[indexPath.item]
                               }
                   }
        }
        else
        {
            for cell in collectionView.visibleCells {
                    if let customCell = cell as? UICollectionViewCell {
                        customCell.contentView.backgroundColor = UIColor(red: 244/255, green: 246/255, blue: 251/255, alpha: 1.0) // Reset appearance
                    }
                }

                // Update the selected cell appearance
                //if let selectedCell = collectionView.cellForItem(at: indexPath) as? CustomCell {
                    if  let cell = collectionView.cellForItem(at: indexPath)
                    {
                        cell.contentView.backgroundColor = colors[indexPath.row]
                        self.slctColor = colors[indexPath.row]
                    }
            
            if let image = UIImage(named: "ctgryIcn1") {
                
                self.ctgryIcon.image = image.withRenderingMode(.alwaysTemplate)
            }

            // Set the desired tint color
            self.ctgryIconBgLbl.backgroundColor = colors[indexPath.row]
            self.ctgryIconBgLbl.alpha = 0.2
            //self.ctgryIcon.tintColor = colors[indexPath.row]
            
            if let url = URL(string: self.iconUrl) {
                let processor = OverlayImageProcessor(overlay: self.slctColor, fraction: 0.1)
                
                // Load the image with Kingfisher and apply the tint
                //                           self.ctgryIcon.kf.setImage(
                //                                       with: url)
                
                self.ctgryIcon.kf.setImage(with: url, options: [.processor(processor)])
            }
        }
    }
}
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
