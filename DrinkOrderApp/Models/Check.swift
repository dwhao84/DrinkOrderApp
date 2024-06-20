//
//  CheckLogin.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/6/21.
//

import UIKit

// Checking Account:
enum AccountCheck {
    case valid
    case lackWord
    case lackDigits
    case lackCorrection
    case lackAccountTextLength
    case empty
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

// Checking E-mail:
enum EmailCheck {
    case valid
    case empty
}
