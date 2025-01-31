/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Accounts : Codable {
	let account_id : String?
	let user_id : String?
	let account_name : String?
	let starting_balance : String?
	let added_date : String?
	let bank_status : String?
	let banks_cc : String?
	let sort_order : String?
    let current_balance : String?
    let account_type : String?
    

	enum CodingKeys: String, CodingKey {

		case account_id = "account_id"
		case user_id = "user_id"
		case account_name = "account_name"
		case starting_balance = "starting_balance"
		case added_date = "added_date"
		case bank_status = "bank_status"
		case banks_cc = "banks_cc"
		case sort_order = "sort_order"
        case current_balance = "current_balance"
        case account_type = "account_type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		account_id = try values.decodeIfPresent(String.self, forKey: .account_id)
		user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
		account_name = try values.decodeIfPresent(String.self, forKey: .account_name)
		starting_balance = try values.decodeIfPresent(String.self, forKey: .starting_balance)
		added_date = try values.decodeIfPresent(String.self, forKey: .added_date)
		bank_status = try values.decodeIfPresent(String.self, forKey: .bank_status)
		banks_cc = try values.decodeIfPresent(String.self, forKey: .banks_cc)
		sort_order = try values.decodeIfPresent(String.self, forKey: .sort_order)
        current_balance = try values.decodeIfPresent(String.self, forKey: .current_balance)
        account_type = try values.decodeIfPresent(String.self, forKey: .account_type)
	}

}
