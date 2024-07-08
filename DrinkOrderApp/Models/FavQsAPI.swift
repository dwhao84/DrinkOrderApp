//
//  FavQsAPI.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/6/18.
//

import UIKit

enum FavQsAPI {
    static let cotentType: String = "application/json"
    static let authorization: String = ""
    static let apiKey: String = "a7c01d0f0e393ecf59c17dd7a66b193a"
    static let apiUrl: String = ""
}

struct User: Codable {
    var user: SignIn
}

struct SignIn: Codable {
    var login: String
    var email: String?
    var password: String
}

struct Response: Codable {
    let userToken: String?
    let login: String?
    let email: String?
    let errorCode: Int?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "User-Token"
        case login
        case email
        case errorCode = "error_Code"
        case message
    }
}
