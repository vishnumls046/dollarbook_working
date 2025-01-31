//
//  APImanager.swift
//  dollarbook
//
//  Created by MindlabsMacMini2021(Vishnu) on 06/10/22.
//

import Foundation
class APImanager
{
    static let header = ["Oakey":"INCEXPMND1254"]
    //static let domain = "http://incexpapp.mindmockups.com/webservice/v1/"
    static let domain = "https://dollarbook.app/webservice/v1/"

    static func getHeader()->[String:String]
    {
        return ["Oakey":"INCEXPMND1254"]
    }
    static func registerAPI()->String
    {
        let url = "\(domain)userRegister"
        return url
    }
    static func LoginAPI()->String
    {
        let url = "\(domain)UserLogin"
        return url
    }
    static func DashTotalAPI()->String
    {
        let url = "\(domain)dashboardTotal"
        return url
    }
    static func GetTagsAPI()->String
    {
        let url = "\(domain)getTags"
        return url
    }
    static func EditTagsAPI()->String
    {
        let url = "\(domain)editTag"
        return url
    }
    static func AddTagsAPI()->String
    {
        let url = "\(domain)addTag"
        return url
    }
    static func GetTransactions()->String
    {
        let url = "\(domain)getTransactions"
        return url
    }
    static func GetCrncyAPI()->String
    {
        let url = "\(domain)currencies"
        return url
    }
    static func addAcntAPI()->String
    {
        let url = "\(domain)addAccount"
        return url
    }
    static func editAcntAPI()->String
    {
        let url = "\(domain)editAccount"
        return url
    }
    static func GetAccounts()->String
    {
        let url = "\(domain)getAccounts"
        return url
    }
    
    static func addIncome()->String
    {
        let url = "\(domain)addIncome"
        return url
    }
    static func addExpense()->String
    {
        let url = "\(domain)addExpense"
        return url
    }
    static func addTrnsfr()->String
    {
        let url = "\(domain)addTransfers"
        return url
    }
    
    static func GetBarGrphData()->String
    {
        let url = "\(domain)sixmonthsTrasactions"
        return url
    }
    static func GetDefltTags()->String
    {
        let url = "\(domain)getDefaultTags"
        return url
    }
    static func DashStat()->String
    {
        let url = "\(domain)dashboardStat"
        return url
    }
    static func ForgotPwd()->String
    {
        let url = "\(domain)forgotPassword"
        return url
    }
    static func UpdtProfile()->String
    {
        let url = "\(domain)updateUserprofile"
        return url
    }
    static func BankReport()->String
    {
        let url = "\(domain)bankingReport"
        return url
    }
    static func TnscnDetail()->String
    {
        let url = "\(domain)transactionDet"
        return url
    }
    static func EditIncome()->String
    {
        let url = "\(domain)editIncome"
        return url
    }
    static func EditExpense()->String
    {
        let url = "\(domain)editExpense"
        return url
    }
    static func EditTrnsfr()->String
    {
        let url = "\(domain)editTransfers"
        return url
    }
    static func DeleteTrnscn()->String
    {
        let url = "\(domain)deleteTransaction"
        return url
    }
    static func GetUserProfile()->String
    {
        let url = "\(domain)userprofile"
        return url
    }
    static func ChngPwdAPI()->String
    {
        let url = "\(domain)changePassword"
        return url
    }
    static func delUsrAcnt()->String
    {
        let url = "\(domain)deleteAccount"
        return url
    }
    static func delBankAcnt()->String
    {
        let url = "\(domain)deleteBankAccount"
        return url
    }
    static func userCheck()->String
    {
        let url = "\(domain)userCheck"
        return url
    }
    static func getReport()->String
    {
        let url = "\(domain)getReport"
        return url
    }
    static func getReportDet()->String
    {
        let url = "\(domain)reportDetails"
        return url
    }
    static func deleteTag()->String
    {
        let url = "\(domain)deleteUsertag"
        return url
    }
    static func getCtrgryIcons()->String
    {
        let url = "\(domain)getIcons"
        return url
    }
    static func sendOtp()->String
    {
        let url = "\(domain)sendOTP"
        return url
    }
    static func verifyOtp()->String
    {
        let url = "\(domain)verifyOTP"
        return url
    }
}
