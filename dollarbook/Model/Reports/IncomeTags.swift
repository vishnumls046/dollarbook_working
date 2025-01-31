
import Foundation

struct IncomeTags: Codable {

  var tagId     : String? = nil
  var userId    : String? = nil
  var tagName   : String? = nil
  var tagType   : String? = nil
  var totIncome : String? = nil
  var income_percentage : Int? = nil
  var iconColor : String? = nil

  enum CodingKeys: String, CodingKey {

    case tagId     = "tag_id"
    case userId    = "user_id"
    case tagName   = "tag_name"
    case tagType   = "tag_type"
    case totIncome = "totIncome"
    case income_percentage = "income_percentage"
    case iconColor = "icon_color"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    tagId     = try values.decodeIfPresent(String.self , forKey: .tagId     )
    userId    = try values.decodeIfPresent(String.self , forKey: .userId    )
    tagName   = try values.decodeIfPresent(String.self , forKey: .tagName   )
    tagType   = try values.decodeIfPresent(String.self , forKey: .tagType   )
    totIncome = try values.decodeIfPresent(String.self , forKey: .totIncome )
    income_percentage = try values.decodeIfPresent(Int.self , forKey: .income_percentage )
    iconColor = try values.decodeIfPresent(String.self , forKey: .iconColor )
  }

  init() {

  }

}
