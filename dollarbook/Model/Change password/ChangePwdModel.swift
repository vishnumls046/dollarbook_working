
import Foundation

struct ChangePwdModel: Codable {

  var result : ChngPwd? = ChngPwd()

  enum CodingKeys: String, CodingKey {

    case result = "result"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    result = try values.decodeIfPresent(ChngPwd.self , forKey: .result )
 
  }

  init() {

  }

}
