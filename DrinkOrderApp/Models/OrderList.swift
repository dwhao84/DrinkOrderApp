//
//  OrderList.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/7/12.
//

import UIKit

struct OrderResponse: Codable {
    let records: [CustomerOrder]
}

struct CustomerOrder: Codable {
    let fields: CustomerOrderFields
}

// MARK: - CustomerOrderFields Model

struct CustomerOrderFields: Codable {
    let userName: String?
    let drinkName: String?
    let cupSize: String?
    let sugarLevel: String?
    let iceLevel: String?
    let topping: String?
    let qty: String?
    let price: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case userName   = "User name"
        case drinkName  = "Drink name"
        case cupSize    = "Cup Size"
        case sugarLevel = "Sugar Level"
        case iceLevel   = "Ice Level"
        case topping    = "Topping"
        case qty        = "Qty"
        case price      = "Price"
        case url        = "URL"
    }
}

