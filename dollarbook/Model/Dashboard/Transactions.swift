
import Foundation

struct Transactions: Codable {

  var transactionId        : String? = nil
  var userId               : String? = nil
  var accountId            : String? = nil
  var transactionType      : String? = nil
  var transactionText      : String? = nil
  var transactionAmount    : String? = nil
  var transactionAddedDate : String? = nil
  var clearedDate          : String? = nil
  var isTransfer           : String? = nil
  var relatedId            : String? = nil
  var closing_balance      : Int? = nil
  var frmAcnName            : String? = nil
  var toAcnName            : String? = nil
  var iconClr            : String? = nil
  var iconUrl            : String? = nil

  enum CodingKeys: String, CodingKey {

    case transactionId        = "transaction_id"
    case userId               = "user_id"
    case accountId            = "account_id"
    case transactionType      = "transaction_type"
    case transactionText      = "transaction_text"
    case transactionAmount    = "transaction_amount"
    case transactionAddedDate = "transaction_added_date"
    case clearedDate          = "cleared_date"
    case isTransfer           = "is_transfer"
    case relatedId            = "related_id"
    case closing_balance      = "closing_balance"
    case frmAcnName           = "from_account_name"
    case toAcnName            = "to_account_name"
    case iconClr              = "icon_color"
    case iconUrl              = "icon_name"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    transactionId        = try values.decodeIfPresent(String.self , forKey: .transactionId        )
    userId               = try values.decodeIfPresent(String.self , forKey: .userId               )
    accountId            = try values.decodeIfPresent(String.self , forKey: .accountId            )
    transactionType      = try values.decodeIfPresent(String.self , forKey: .transactionType      )
    transactionText      = try values.decodeIfPresent(String.self , forKey: .transactionText      )
    transactionAmount    = try values.decodeIfPresent(String.self , forKey: .transactionAmount    )
    transactionAddedDate = try values.decodeIfPresent(String.self , forKey: .transactionAddedDate )
    clearedDate          = try values.decodeIfPresent(String.self , forKey: .clearedDate          )
    isTransfer           = try values.decodeIfPresent(String.self , forKey: .isTransfer           )
    relatedId            = try values.decodeIfPresent(String.self , forKey: .relatedId            )
    closing_balance      = try values.decodeIfPresent(Int.self , forKey: .closing_balance            )
    frmAcnName           = try values.decodeIfPresent(String.self , forKey: .frmAcnName            )
    toAcnName            = try values.decodeIfPresent(String.self , forKey: .toAcnName            )
    iconClr              = try values.decodeIfPresent(String.self , forKey: .iconClr            )
    iconUrl              = try values.decodeIfPresent(String.self , forKey: .iconUrl            )
  }

  init() {

  }

}
