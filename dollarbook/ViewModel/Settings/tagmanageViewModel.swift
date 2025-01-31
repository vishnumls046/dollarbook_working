//
//  tagmanageViewModel.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 07/12/22.
//

import Foundation
import Alamofire
import UIKit
import Toaster
class tagmanageViewModel:NSObject
{
    var tagType = ""
    var color = ""
    var incmTagsArry = [Tags]()
    var expnTagsArry = [Tags]()
    var incmTagArry:[String] = []
    var expTagArry:[String] = []
    var slctdTagArry:[String] = []
    var tagArry = [Tags]()
    var TagArry:[String] = []
    static var tagArry1 = [Tags]()
    static var TagArry2:[String] = []
    
    
    static var iconCtgryIdArry:[String] = []
    static var iconCtgryNameArry:[String] = []
    static var iconUrlArry:[String] = []
    static var iconIdArry:[String] = []
    struct Section {
        let name: String
        let items: [String]
        let iconIds: [String]
    }
    var icons:Section? = nil
    static var sections:[Section] = []
    var tagmangDlt:tagmanageProt?
    func getIcons()
    {
        AF.request(APImanager.getCtrgryIcons(),method: .post,parameters:["user_id":UserDefaults.standard.value(forKey: "user_id")!], encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let IconResponse  = try
                    JSONDecoder().decode(Icons_Base.self, from: data)
                    //print(TagResponse.transaction!)
                    
                    tagmanageViewModel.iconCtgryIdArry = []
                    tagmanageViewModel.iconCtgryNameArry = []
                    tagmanageViewModel.sections = []
                    //editTransactnViewModel.trans = TagResponse.transaction![0]
                    //self.acntId = editTransactnViewModel.trans.accountId!
//                    for anItem in TagResponse.transaction! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        //self.transArry.append(anItem)
                    
                    for anItem in IconResponse.categories! as Array {
                        
                        tagmanageViewModel.iconCtgryIdArry.append(anItem.icon_category_id!)
                        tagmanageViewModel.iconCtgryNameArry.append(anItem.icon_category_name!)
                       // tagmanageViewModel.iconCtgryIdArry = []
                        tagmanageViewModel.iconUrlArry = []
                        tagmanageViewModel.iconIdArry = []
                        for icons in anItem.icons! as Array {
                            
                            
                            tagmanageViewModel.iconUrlArry.append(icons.icon_name!)
                            tagmanageViewModel.iconIdArry.append(icons.icon_id!)
                            self.icons = Section(name: anItem.icon_category_name!, items: tagmanageViewModel.iconUrlArry,iconIds: tagmanageViewModel.iconIdArry)
                        }
                        
                        tagmanageViewModel.sections.append(self.icons!)
                    }
                    // do something with personName and personID
                    //}
                    //print(self.transArry)
                    DispatchQueue.main.async {
                        self.tagmangDlt?.loadIconsCln()
                    }
                    
                }
                catch let err{
                    //self.dashDlgt?.recentTblUpdt(trnsCnt:"0")
                    print(err)
                }
            }
        }
        
    }
    func getTags(tags:String)
    {
        self.tagType = tags
        
        AF.request(APImanager.GetTagsAPI(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let TagResponse  = try
                    JSONDecoder().decode(TagsModel.self, from: data)
                    print(TagResponse.tags!)

                    self.expnTagsArry = []
                    self.incmTagsArry = []
                    self.TagArry = []
                    self.slctdTagArry = []
                    self.incmTagArry = []
                    self.expTagArry = []
                    for anItem in TagResponse.tags! as Array {
                        //let tagName = anItem.tagName as! String
                      //let tagID = anItem["tag_id"] as! String
                        //self.tagsArry.append(anItem)
                        if(anItem.tagType == "1")
                        {
                            self.incmTagsArry.append(anItem)
                            self.incmTagArry.append(anItem.tagName!)
                        }
                        else
                        {
                            self.expnTagsArry.append(anItem)
                            self.expTagArry.append(anItem.tagName!)
                        }
                        
                        
                    // do something with personName and personID
                    }
                    if(tags == "income")
                    {
                        self.TagArry.append(contentsOf: self.incmTagArry)
                        tagmanageViewModel.tagArry1 = self.incmTagsArry
                    }
                    else
                    {
                        tagmanageViewModel.tagArry1 = self.expnTagsArry
                        self.TagArry.append(contentsOf: self.expTagArry)
                        
                    }
                    self.tagmangDlt?.loadTagsCln()
                    
                }
                catch let err{
                    self.tagmangDlt?.loadTagsCln()
                    print(err)
                }
            }
        }
        
    }
    func validateAddTag(tagName: String,tagType:Bool,tagIcnClr:UIColor,tagIcnUrl:String,tagIcnId:String)
    {
        if (tagName == "")
        {
            self.tagmangDlt?.valdteTag(alrtStr: "Please Enter Account Name !")
        }
        else
        {
            DispatchQueue.global().async {
                self.addTag(tagNme: tagName, tagType: "\(tagType)",tagIcnClr: tagIcnClr,tagIcnUrl: tagIcnUrl,tagIcnId: tagIcnId)
            }
            
            //self.addCrncyAcnt()
        }
    }
    func validateEditTag(tagName: String,tagType:Bool,tagId:String,tagIcnClr:UIColor,tagIcnUrl:String,iconId:String)
    {
        if (tagName == "")
        {
            self.tagmangDlt?.valdteTag(alrtStr: "Please Enter Account Name !")
        }
        else
        {
            DispatchQueue.global().async {
                self.editTag(tagNme:tagName,tagType:"\(tagType)",tagId:tagId,tagIcnClr: tagIcnClr,tagIcnUrl: tagIcnUrl,iconId: iconId)
            }
            
            //self.addCrncyAcnt()
        }
    }
    
    func addTag(tagNme:String,tagType:String,tagIcnClr:UIColor,tagIcnUrl:String,tagIcnId:String)
    {
        var tagTypes = ""
        if(tagType == "false")
        {
            tagTypes = "1"
        }
        else
        {
            tagTypes = "2"
        }
        if let hex = tagIcnClr.toHex() {
            self.color = hex
        }
        AF.request(APImanager.AddTagsAPI(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"tag_name":tagNme,"tag_type":tagTypes,"icon_color":color,"icon_id":tagIcnId] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let acntResponse  = try
                    JSONDecoder().decode(AddDataModel.self, from: data)
                    //print(acntResponse.addresult!.message!)
//                    for anItem in acntResponse.tags! as Array {
//
//                        self.tagArry.append(anItem.tagName!)
//
//                    // do something with personName and personID
//                    }
                    
                        DispatchQueue.main.async {
                            
                            //                        UserDefaults.standard.set("1", forKey: "acnt")
                            //                        UserDefaults.standard.set("1", forKey: "accountExist")
                            if(acntResponse.addresult!.value == 1)
                            {
                                self.tagmangDlt?.closeTagView(tagTyp:tagTypes)
                                
                            }
                            else
                            {
                                self.tagmangDlt?.valdteTag(alrtStr: acntResponse.addresult!.message!)
                            }
                        }
                    
                    
                }
                catch let err{
                    print(err)
                }
            }
        }
        
    }
    func editTag(tagNme:String,tagType:String,tagId:String,tagIcnClr:UIColor,tagIcnUrl:String,iconId:String)
    {
        var tagTypes = ""
        if(tagType == "false")
        {
            tagTypes = "1"
        }
        else
        {
            tagTypes = "2"
        }
        if let hex = tagIcnClr.toHex() {
            self.color = hex
        }
        AF.request(APImanager.EditTagsAPI(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"tag_name":tagNme,"tag_type":tagTypes,"tag_id":tagId,"icon_color":color,"icon_id":iconId] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let acntResponse  = try
                    JSONDecoder().decode(AddDataModel.self, from: data)
                   // print(acntResponse.addresult!.message!)
//                    for anItem in acntResponse.tags! as Array {
//
//                        self.tagArry.append(anItem.tagName!)
//
//                    // do something with personName and personID
//                    }
                    DispatchQueue.main.async {
                        self.tagmangDlt?.valdteTag(alrtStr: acntResponse.addresult!.message!)
//                        UserDefaults.standard.set("1", forKey: "acnt")
//                        UserDefaults.standard.set("1", forKey: "accountExist")
                        self.tagmangDlt?.closeTagView(tagTyp:tagTypes)
                    }
                    
                }
                catch let err{
                    print(err)
                }
            }
        }
        
    }
    func delTag(tagId:String,tagType:String)
    {
        AF.request(APImanager.deleteTag(),method: .post,parameters: ["user_id":UserDefaults.standard.value(forKey: "user_id")!,"tag_id":tagId] ,encoding: URLEncoding.default, headers:["Oakey":"INCEXPMND1254"]).responseJSON
        {
            response in
            if let data = response.data
            {
                do{
                    let acntResponse  = try
                    JSONDecoder().decode(AddDataModel.self, from: data)
                    print(acntResponse.addresult!.message!)
//                    for anItem in acntResponse.tags! as Array {
//
//                        self.tagArry.append(anItem.tagName!)
//
//                    // do something with personName and personID
//                    }
                    
                        
                            DispatchQueue.main.async {
                                Toast(text: acntResponse.addresult!.message!).show()
                                ToastView.appearance().backgroundColor = ColorManager.expenseColor()
                                ToastView.appearance().textColor = .white
                            }
                    DispatchQueue.global().async {
                        if(acntResponse.addresult!.value == 1)
                        {
                            self.tagmangDlt?.closeTagView(tagTyp:tagType)
                            
                        }
                        else
                        {
                            self.tagmangDlt?.valdteTag(alrtStr: acntResponse.addresult!.message!)
                        }
                    }
                        
                        //self.editViewDlgt?.alerts(alrtStr: acntResponse.addresult!.message!)
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
//                            self.editViewDlgt?.BackAfterDataAdd()
//                        })
                        //self.addViewDlgt?.closeSetAcntView()
                        
                    
                    
                }
                catch let err{
                    print(err)
                }
            }
        }
    }
}
// Convert uicolor to Hexa
extension UIColor {
    func toHex(includeAlpha: Bool = false) -> String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }

        if includeAlpha {
            return String(format: "#%02X%02X%02X%02X",
                          Int(red * 255),
                          Int(green * 255),
                          Int(blue * 255),
                          Int(alpha * 255))
        } else {
            return String(format: "#%02X%02X%02X",
                          Int(red * 255),
                          Int(green * 255),
                          Int(blue * 255))
        }
    }
}
