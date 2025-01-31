
import Foundation

struct Tags: Codable {

  var tagId   : String? = nil
  var userId  : String? = nil
  var tagName : String? = nil
  var tagType : String? = nil
  var iconClor: String? = nil
  var iconUrl: String? = nil
  var iconId: String? = nil
  enum CodingKeys: String, CodingKey {

    case tagId   = "tag_id"
    case userId  = "user_id"
    case tagName = "tag_name"
    case tagType = "tag_type"
    case iconClor = "icon_color"
    case iconUrl = "icon_name"
    case iconId = "icon_id"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    tagId   = try values.decodeIfPresent(String.self , forKey: .tagId   )
    userId  = try values.decodeIfPresent(String.self , forKey: .userId  )
    tagName = try values.decodeIfPresent(String.self , forKey: .tagName )
    tagType = try values.decodeIfPresent(String.self , forKey: .tagType )
    iconClor = try values.decodeIfPresent(String.self , forKey: .iconClor )
    iconUrl = try values.decodeIfPresent(String.self , forKey: .iconUrl )
    iconId = try values.decodeIfPresent(String.self , forKey: .iconId )
 
  }

  init() {

  }

}
