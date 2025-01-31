
import Foundation

struct ChngPwd: Codable {

  var value     : Int?    = nil
  var message   : String? = nil
  var profileId : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case value     = "value"
    case message   = "message"
    case profileId = "profile_id"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    value     = try values.decodeIfPresent(Int.self    , forKey: .value     )
    message   = try values.decodeIfPresent(String.self , forKey: .message   )
    profileId = try values.decodeIfPresent(Int.self    , forKey: .profileId )
 
  }

  init() {

  }

}
