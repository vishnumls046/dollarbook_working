//
//  ColorManager.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 18/12/22.
//

import Foundation
import UIKit
class ColorManager
{
    static func incomeColor()->UIColor
    {
        return UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 1.0)
    }
    static func expenseColor()->UIColor
    {
        return UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1.0)
    }
    static func transferColor()->UIColor
    {
        return UIColor(red: 52/255, green: 199/255, blue: 89/255, alpha: 1.0)
    }
    
    //For table background
    static func incomeColorBg()->UIColor
    {
        return UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.05)
    }
    static func expenseColorBg()->UIColor
    {
        return UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 0.05)
    }
    
    //For table Icon bg
    static func incomeColorTblIcn()->UIColor
    {
        return UIColor(red: 145/255, green: 111/255, blue: 239/255, alpha: 0.2)
    }
    static func expenseColorTblIcn()->UIColor
    {
        return UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 0.2)
    }
}
