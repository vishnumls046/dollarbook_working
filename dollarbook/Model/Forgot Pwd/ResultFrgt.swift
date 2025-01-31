
import Foundation

struct ResultFrgt: Codable {

  var userStatus : Int?    = nil
  var message    : String? = nil

  enum CodingKeys: String, CodingKey {

    case userStatus = "user_status"
    case message    = "message"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    userStatus = try values.decodeIfPresent(Int.self    , forKey: .userStatus )
    message    = try values.decodeIfPresent(String.self , forKey: .message    )
 
  }

  init() {

  }

}
