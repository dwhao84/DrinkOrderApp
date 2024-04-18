//
//  DrinksModel.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/18.
//

import UIKit

struct Kebuke: Codable {
    let records: [Record]
}

struct Record: Codable {
    let id: String
    let createdTime: String
    let fields: Fields
}

struct Fields: Codable {
    let category: String
    let drinksImages: [DrinksImages]?
    let drinksName: String
    let drinksDescription: String
    let mediumPrice: Int
    let largePrice: Int
    
    enum CodingKeys: String, CodingKey {
        case category          = "category"
        case drinksImages      = "Drinks Images"
        case drinksDescription = "Drinks Description"
        case drinksName        = "Drinks name"
        case mediumPrice       = "medium Price"
        case largePrice        = "large Price"
    }
}

enum Category: String, CodingKey {
    case 單品茶                  = "單品茶"
    case 季節限定                = "季節限定"
    case 歐蕾MilkTea            = "歐蕾 MilkTea"
    case 調茶MixTea             = "調茶 MixTea"
    case 雲蓋SweetCreamColdFoam = "雲蓋 SweetCreamColdFoam"
}

struct DrinksImages: Codable {
    let id: String
    let url: String
}


