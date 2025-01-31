
import Foundation

struct AddResult: Codable {

  var value   : Int?    = nil
  var message : String? = nil

  enum CodingKeys: String, CodingKey {

    case value   = "value"
    case message = "message"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    value   = try values.decodeIfPresent(Int.self    , forKey: .value   )
    message = try values.decodeIfPresent(String.self , forKey: .message )
 
  }

  init() {

  }

}
