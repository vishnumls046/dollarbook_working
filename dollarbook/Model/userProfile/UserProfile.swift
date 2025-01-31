
import Foundation

struct UserProfile: Codable {

  var user : [User]? = []

  enum CodingKeys: String, CodingKey {

    case user = "user"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    user = try values.decodeIfPresent([User].self , forKey: .user )
 
  }

  init() {

  }

}