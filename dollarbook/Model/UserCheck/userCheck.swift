
import Foundation

struct UserCheck: Codable {

  var result  : Int?    = nil
  var message : String? = nil

  enum CodingKeys: String, CodingKey {

    case result  = "result"
    case message = "message"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    result  = try values.decodeIfPresent(Int.self    , forKey: .result  )
    message = try values.decodeIfPresent(String.self , forKey: .message )
 
  }

  init() {

  }

}
