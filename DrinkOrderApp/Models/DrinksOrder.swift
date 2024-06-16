//
//  DrinksOrder.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/6/16.
//

import UIKit

// MARK: - Create Order data model
struct Order: Codable {
    let id: String?
    let drinkName: String
    let cupSize: String
    let sugarLevel: String
    let iceLevel: String
    let topping: String
    let qty: String
    
    // MARK: - Make sure the CodingKey is right.
    enum CodingKeys: String, CodingKey {
        case id         = "id"
        case drinkName  = "Drink name"
        case cupSize    = "Cup Size"
        case sugarLevel = "Sugar Level"
        case iceLevel   = "Ice Level"
        case topping    = "Topping"
        case qty        = "Qty"
    }
}

