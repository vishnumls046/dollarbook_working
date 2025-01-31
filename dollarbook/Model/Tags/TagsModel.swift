
import Foundation

struct TagsModel: Codable {

  var tags : [Tags]? = []

  enum CodingKeys: String, CodingKey {

    case tags = "tags"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    tags = try values.decodeIfPresent([Tags].self , forKey: .tags )
 
  }

  init() {

  }

}