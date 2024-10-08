//
//  DrinksModel.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/18.
//

import UIKit

// MARK: - Kebuke
struct Kebuke: Codable {
    let records: [KebukeRecord]
}

// MARK: - KebukeRecord
struct KebukeRecord: Codable {
    let id, createdTime: String
    let fields: KebukeFields
}

// MARK: - KebukeFields
struct KebukeFields: Codable {
    let largePrice: Int
    let drinksImages: [DrinksImage]?
    let category: Category
    let mediumPrice: Int
    let drinkName, drinksDescription: String

    enum CodingKeys: String, CodingKey {
        case largePrice        = "large price"
        case drinksImages      = "Drinks Images"
        case category          = "Category"
        case mediumPrice       = "medium price"
        case drinkName         = "Drink name"
        case drinksDescription = "Drinks Description"
    }
}

enum Category: String, Codable {
    case 單品茶                  = "單品茶"
    case 季節限定                = "季節限定"
    case 歐蕾MilkTea            = "歐蕾 Milk tea"
    case 調茶MixTea             = "調茶 Mix tea"
    case 雲蓋SweetCreamColdFoam = "雲蓋 Sweet Cream Cold Foam"
}

// MARK: - DrinksImage
struct DrinksImage: Codable {
    let id: String
    let width, height: Int
    let url: String
    let filename: String
    let size: Int
    let type: TypeEnum
    let thumbnails: Thumbnails
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let small, large, full: Full
}

// MARK: - Full
struct Full: Codable {
    let url: String
    let width, height: Int
}

enum TypeEnum: String, Codable {
    case imageJPEG = "image/jpeg"
}


// API URL:https://api.airtable.com/v0/appS5I28H2YO3bJzv/Kebuke
