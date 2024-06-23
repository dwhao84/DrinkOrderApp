//
//  CheckLogin.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/6/21.
//

import UIKit

// Checking the user name:
enum NameCheck {
    case valid
    case empty
    case lackTextlength
}

// Checking E-mail:
enum EmailCheck {
    case valid
    case lacksPunctuation
    case lackAt
    case invalidDomain
}

// Checking Password:
enum PasswordCheck {
    case valid
    case containsCommonPassword
    case lacksDigits
    case lacksPunctuation
    case lackTextLength
    case empty
}


