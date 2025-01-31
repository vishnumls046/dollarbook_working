/* 
Copyright (c) 2025 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct verifyResult : Codable {
	let user_id : String?
	let currency_id : String?
	let full_name : String?
	let phone_number : String?
	let email_id : String?
	let user_password : String?
	let otp : String?
	let otp_expiry : String?
	let user_status : String?
	let registered_date : String?
	let last_login_time : String?
	let last_login_ip : String?
	let subscribed : String?
	let account_exists : String?
	let currency_name : String?
	let currency_code : String?
    let message : String?

	enum CodingKeys: String, CodingKey {

		case user_id = "user_id"
		case currency_id = "currency_id"
		case full_name = "full_name"
		case phone_number = "phone_number"
		case email_id = "email_id"
		case user_password = "user_password"
		case otp = "otp"
		case otp_expiry = "otp_expiry"
		case user_status = "user_status"
		case registered_date = "registered_date"
		case last_login_time = "last_login_time"
		case last_login_ip = "last_login_ip"
		case subscribed = "subscribed"
		case account_exists = "account_exists"
		case currency_name = "currency_name"
		case currency_code = "currency_code"
        case message = "message"
        
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
		currency_id = try values.decodeIfPresent(String.self, forKey: .currency_id)
		full_name = try values.decodeIfPresent(String.self, forKey: .full_name)
		phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
		email_id = try values.decodeIfPresent(String.self, forKey: .email_id)
		user_password = try values.decodeIfPresent(String.self, forKey: .user_password)
		otp = try values.decodeIfPresent(String.self, forKey: .otp)
		otp_expiry = try values.decodeIfPresent(String.self, forKey: .otp_expiry)
		user_status = try values.decodeIfPresent(String.self, forKey: .user_status)
		registered_date = try values.decodeIfPresent(String.self, forKey: .registered_date)
		last_login_time = try values.decodeIfPresent(String.self, forKey: .last_login_time)
		last_login_ip = try values.decodeIfPresent(String.self, forKey: .last_login_ip)
		subscribed = try values.decodeIfPresent(String.self, forKey: .subscribed)
		account_exists = try values.decodeIfPresent(String.self, forKey: .account_exists)
		currency_name = try values.decodeIfPresent(String.self, forKey: .currency_name)
		currency_code = try values.decodeIfPresent(String.self, forKey: .currency_code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
	}

}
