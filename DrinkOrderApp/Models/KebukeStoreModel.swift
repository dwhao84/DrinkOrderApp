//
//  KebukeStoreModel.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/27.
//

import UIKit

// MARK: - Decode the JSON file for Store location.
struct Store: Codable {
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let phone: String

    // Add CodingKeys for able to connect Kebuke store json.
    enum CodingKeys: String, CodingKey {
        case name      = "店家名稱"
        case address   = "店家地址"
        case latitude  = "Latitude"
        case longitude = "Longitude"
        case phone     = "電話"
    }
}

