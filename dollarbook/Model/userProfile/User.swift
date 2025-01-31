
import Foundation

struct User: Codable {

  var userId         : String? = nil
  var currencyId     : String? = nil
  var fullName       : String? = nil
  var phoneNumber    : String? = nil
  var emailId        : String? = nil
  var userPassword   : String? = nil
  var userStatus     : String? = nil
  var registeredDate : String? = nil
  var lastLoginTime  : String? = nil
  var lastLoginIp    : String? = nil
  var subscribed     : String? = nil
    var currencyName     : String? = nil
    var currencyCode     : String? = nil
    
    
    
  enum CodingKeys: String, CodingKey {

    case userId         = "user_id"
    case currencyId     = "currency_id"
    case fullName       = "full_name"
    case phoneNumber    = "phone_number"
    case emailId        = "email_id"
    case userPassword   = "user_password"
    case userStatus     = "user_status"
    case registeredDate = "registered_date"
    case lastLoginTime  = "last_login_time"
    case lastLoginIp    = "last_login_ip"
    case subscribed     = "subscribed"
      case currencyName     = "currency_name"
      case currencyCode     = "currency_code"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    userId         = try values.decodeIfPresent(String.self , forKey: .userId         )
    currencyId     = try values.decodeIfPresent(String.self , forKey: .currencyId     )
    fullName       = try values.decodeIfPresent(String.self , forKey: .fullName       )
    phoneNumber    = try values.decodeIfPresent(String.self , forKey: .phoneNumber    )
    emailId        = try values.decodeIfPresent(String.self , forKey: .emailId        )
    userPassword   = try values.decodeIfPresent(String.self , forKey: .userPassword   )
    userStatus     = try values.decodeIfPresent(String.self , forKey: .userStatus     )
    registeredDate = try values.decodeIfPresent(String.self , forKey: .registeredDate )
    lastLoginTime  = try values.decodeIfPresent(String.self , forKey: .lastLoginTime  )
    lastLoginIp    = try values.decodeIfPresent(String.self , forKey: .lastLoginIp    )
    subscribed     = try values.decodeIfPresent(String.self , forKey: .subscribed     )
      currencyName     = try values.decodeIfPresent(String.self , forKey: .currencyName     )
      currencyCode     = try values.decodeIfPresent(String.self , forKey: .currencyCode     )
 
  }

  init() {

  }

}
