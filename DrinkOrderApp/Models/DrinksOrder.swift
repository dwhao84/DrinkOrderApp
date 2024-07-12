//
//  DrinksOrder.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/6/16.
//

import UIKit

struct Order: Codable {
    let fields: OrderFields
}

// MARK: - Create Order data model
struct OrderFields: Codable {
    let userName: String?
    let drinkName: String?
    let cupSize: String?
    let sugarLevel: String?
    let iceLevel: String?
    let topping: String?
    let qty: String?
    let price: String?
    
    enum CodingKeys: String, CodingKey {
        case userName   = "User name"
        case drinkName  = "Drink name"
        case cupSize    = "Cup Size"
        case sugarLevel = "Sugar Level"
        case iceLevel   = "Ice Level"
        case topping    = "Topping"
        case qty        = "Qty"
        case price      = "Price"
    }
}
