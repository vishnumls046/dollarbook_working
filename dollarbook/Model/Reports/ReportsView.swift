
import Foundation

struct ReportsView: Codable {

  var incomeTags  : [IncomeTags]?  = []
  var expenseTags : [ExpenseTags]? = []

  enum CodingKeys: String, CodingKey {

    case incomeTags  = "incomeTags"
    case expenseTags = "expenseTags"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    incomeTags  = try values.decodeIfPresent([IncomeTags].self  , forKey: .incomeTags  )
    expenseTags = try values.decodeIfPresent([ExpenseTags].self , forKey: .expenseTags )
 
  }

  init() {

  }

}