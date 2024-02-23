//
//  SettingsModel.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/2/23.
//

import UIKit

struct SettingData {
    let serviceName:  String
    let serviceImage: UIImage
}

func fetchSettingData () -> [SettingData] {
    let settingDataOne = SettingData(serviceName: "Telephone Number", serviceImage: Images.phone)
    let settingDataTwo = SettingData(serviceName: "Location",         serviceImage: Images.map)
    return [settingDataOne, settingDataTwo]
}


