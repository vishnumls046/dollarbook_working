
import Foundation

struct AddDataModel: Codable {

    let addresult : AddResult?
    

  enum CodingKeys: String, CodingKey {

    case addresult = "result"
  
  }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        addresult = try values.decodeIfPresent(AddResult.self, forKey: .addresult)
    }

}
