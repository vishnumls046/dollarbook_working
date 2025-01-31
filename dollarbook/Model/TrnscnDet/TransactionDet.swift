
import Foundation

struct TransactionDet: Codable {

  var transactionId        : String? = nil
  var userId               : String? = nil
  var accountId            : String? = nil
  var frmAccountId         : String? = nil
  var toAccountId          : String? = nil
  var transactionType      : String? = nil
  var transactionText      : String? = nil
  var transactionAmount    : String? = nil
  var transactionAddedDate : String? = nil
  var clearedDate          : String? = nil
  var isTransfer           : String? = nil
  var relatedId            : String? = nil
  var accountName          : String? = nil
  var frmAccountName       : String? = nil
  var toAccountName        : String? = nil
  var icnClr               : String? = nil
  var icnUrl               : String? = nil
  var tagName              : String? = nil
  var tagId                : String? = nil
  var tagss                 : [Tagss]? = []

  enum CodingKeys: String, CodingKey {

    case transactionId        = "transaction_id"
    case userId               = "user_id"
    case accountId            = "account_id"
    case frmAccountId         = "from_account_id"
    case toAccountId          = "to_account_id"
    case transactionType      = "transaction_type"
    case transactionText      = "transaction_text"
    case transactionAmount    = "transaction_amount"
    case transactionAddedDate = "transaction_added_date"
    case clearedDate          = "cleared_date"
    case isTransfer           = "is_transfer"
    case relatedId            = "related_id"
    case tagss                = "tags"
    case accountName          = "account_name"
    case frmAccountName       = "from_account_name"
    case toAccountName        = "to_account_name"
    case icnClr               = "icon_color"
    case icnUrl               = "icon_name"
    case tagName              = "tag_name"
    case tagId                = "tag_id"
      
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    transactionId        = try values.decodeIfPresent(String.self , forKey: .transactionId        )
    userId               = try values.decodeIfPresent(String.self , forKey: .userId               )
    accountId            = try values.decodeIfPresent(String.self , forKey: .accountId            )
    frmAccountId         = try values.decodeIfPresent(String.self , forKey: .frmAccountId         )
    toAccountId          = try values.decodeIfPresent(String.self , forKey: .toAccountId          )
    transactionType      = try values.decodeIfPresent(String.self , forKey: .transactionType      )
    transactionText      = try values.decodeIfPresent(String.self , forKey: .transactionText      )
    transactionAmount    = try values.decodeIfPresent(String.self , forKey: .transactionAmount    )
    transactionAddedDate = try values.decodeIfPresent(String.self , forKey: .transactionAddedDate )
    clearedDate          = try values.decodeIfPresent(String.self , forKey: .clearedDate          )
    isTransfer           = try values.decodeIfPresent(String.self , forKey: .isTransfer           )
    relatedId            = try values.decodeIfPresent(String.self , forKey: .relatedId            )
    accountName          = try values.decodeIfPresent(String.self , forKey: .accountName          )
    toAccountName        = try values.decodeIfPresent(String.self , forKey: .toAccountName        )
    frmAccountName       = try values.decodeIfPresent(String.self , forKey: .frmAccountName       )
    tagss                = try values.decodeIfPresent([Tagss].self , forKey:.tagss                )
    icnClr        = try values.decodeIfPresent(String.self , forKey: .icnClr        )
    icnUrl       = try values.decodeIfPresent(String.self , forKey: .icnUrl       )
    tagName       = try values.decodeIfPresent(String.self , forKey: .tagName       )
    tagId       = try values.decodeIfPresent(String.self , forKey: .tagId       )
  }

  init() {

  }

}
