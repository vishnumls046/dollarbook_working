
import Foundation

struct ForgotPwd: Codable {

  var result : ResultFrgt? = ResultFrgt()

  enum CodingKeys: String, CodingKey {

    case result = "result"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    result = try values.decodeIfPresent(ResultFrgt.self , forKey: .result )
 
  }

  init() {

  }

}
