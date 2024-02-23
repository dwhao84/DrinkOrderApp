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
    // First group -> Contact Information.
    let telephoneNumber = SettingData(serviceName: "Telephone Number", serviceImage: Images.phone)
    let location        = SettingData(serviceName: "Location",         serviceImage: Images.map)
    let email           = SettingData(serviceName: "E-mail",           serviceImage: Images.mail)
    
    // Second group -> Company Information.
    let declaration     = SettingData(serviceName: "Declaration",      serviceImage: Images.declaration)
    let inspectReport   = SettingData(serviceName: "Insepect Report",  serviceImage: Images.report)
    let privacy         = SettingData(serviceName: "Privacy",          serviceImage: Images.privacy)
    let brandStory      = SettingData(serviceName: "Brand Story",      serviceImage: Images.brandStory)
    return [telephoneNumber, location, email, declaration, inspectReport, privacy, brandStory]
}


