
import Foundation

struct TrnsDetModel: Codable {

  var transaction : [TransactionDet]? = []

  enum CodingKeys: String, CodingKey {

    case transaction = "transaction"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    transaction = try values.decodeIfPresent([TransactionDet].self , forKey: .transaction )
 
  }

  init() {

  }

}
