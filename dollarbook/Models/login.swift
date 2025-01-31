// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let loginModel = try? newJSONDecoder().decode(LoginModel.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseLoginModel { response in
//     if let loginModel = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - LoginModel
class LoginModel: Codable {
    let result: Result

    init(result: Result) {
        self.result = result
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseResult { response in
//     if let result = response.result.value {
//       ...
//     }
//   }

// MARK: - Result
class Result: Codable {
    let userID, fullName, phoneNumber, emailID: String
    let userPassword, userStatus, registeredDate, lastLoginTime: String
    let lastLoginIP, subscribed: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailID = "email_id"
        case userPassword = "user_password"
        case userStatus = "user_status"
        case registeredDate = "registered_date"
        case lastLoginTime = "last_login_time"
        case lastLoginIP = "last_login_ip"
        case subscribed
    }

    init(userID: String, fullName: String, phoneNumber: String, emailID: String, userPassword: String, userStatus: String, registeredDate: String, lastLoginTime: String, lastLoginIP: String, subscribed: String) {
        self.userID = userID
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.emailID = emailID
        self.userPassword = userPassword
        self.userStatus = userStatus
        self.registeredDate = registeredDate
        self.lastLoginTime = lastLoginTime
        self.lastLoginIP = lastLoginIP
        self.subscribed = subscribed
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }

            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }

            return Result { try newJSONDecoder().decode(T.self, from: data) }
        }
    }

    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }

    @discardableResult
    func responseLoginModel(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<LoginModel>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
