
import Foundation

struct Tagss: Codable {

  var tagId   : String? = nil
  var userId  : String? = nil
  var tagName : String? = nil
  var tagType : String? = nil
  var tagClr : String? = nil
  var tagUrl : String? = nil

  enum CodingKeys: String, CodingKey {

    case tagId   = "tag_id"
    case userId  = "user_id"
    case tagName = "tag_name"
    case tagType = "tag_type"
    case tagClr = "icon_color"
    case tagUrl = "icon_name"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    tagId   = try values.decodeIfPresent(String.self , forKey: .tagId   )
    userId  = try values.decodeIfPresent(String.self , forKey: .userId  )
    tagName = try values.decodeIfPresent(String.self , forKey: .tagName )
    tagType = try values.decodeIfPresent(String.self , forKey: .tagType )
    tagClr = try values.decodeIfPresent(String.self , forKey: .tagClr )
    tagUrl = try values.decodeIfPresent(String.self , forKey: .tagUrl )
 
  }

  init() {

  }

}
