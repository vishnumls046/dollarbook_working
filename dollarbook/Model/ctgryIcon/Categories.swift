/* 
Copyright (c) 2025 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Categories : Codable {
	let icon_category_id : String?
	let icon_category_name : String?
	let icon_category_status : String?
	let sort_order : String?
	let icons : [Icons]?

	enum CodingKeys: String, CodingKey {

		case icon_category_id = "icon_category_id"
		case icon_category_name = "icon_category_name"
		case icon_category_status = "icon_category_status"
		case sort_order = "sort_order"
		case icons = "icons"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		icon_category_id = try values.decodeIfPresent(String.self, forKey: .icon_category_id)
		icon_category_name = try values.decodeIfPresent(String.self, forKey: .icon_category_name)
		icon_category_status = try values.decodeIfPresent(String.self, forKey: .icon_category_status)
		sort_order = try values.decodeIfPresent(String.self, forKey: .sort_order)
		icons = try values.decodeIfPresent([Icons].self, forKey: .icons)
	}

}