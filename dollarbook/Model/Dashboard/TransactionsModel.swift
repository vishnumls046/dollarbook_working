
import Foundation

struct TransactionsModel: Codable {

  var transactions : [Transactions]? = []
  var isLastpage   : Int?            = nil
  var first_transaction : String?    = nil
  var initial_balance   : String?       = nil
    
  enum CodingKeys: String, CodingKey {

    case transactions = "transactions"
    case isLastpage   = "isLastpage"
    case first_transaction   = "first_transaction"
    case initial_balance     = "initial_balance"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    transactions = try values.decodeIfPresent([Transactions].self , forKey: .transactions )
    isLastpage   = try values.decodeIfPresent(Int.self , forKey: .isLastpage   )
    first_transaction   = try values.decodeIfPresent(String.self , forKey: .first_transaction   )
    initial_balance   = try values.decodeIfPresent(String.self , forKey: .initial_balance   )
  }

  init() {

  }

}
