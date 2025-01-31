
import Foundation

struct DashboardTotalModel: Codable {

  var totalMonthlyIncome  : String? = nil
  var totalMonthlyExpense : String? = nil

  enum CodingKeys: String, CodingKey {

    case totalMonthlyIncome  = "total_monthly_income"
    case totalMonthlyExpense = "total_monthly_expense"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    totalMonthlyIncome  = try values.decodeIfPresent(String.self , forKey: .totalMonthlyIncome  )
    totalMonthlyExpense = try values.decodeIfPresent(String.self , forKey: .totalMonthlyExpense )
 
  }

  init() {

  }

}
