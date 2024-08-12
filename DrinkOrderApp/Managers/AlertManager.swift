//
//  AlertManager.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/8/12.
//

import UIKit

class AlertManager {
    private static func showTextAlert(on vc: UIViewController, with title: String, with message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
}


// MARK: - Button Alerts
extension AlertManager {
    static func showButtonAlert(on vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        alert.view.tintColor = Colors.kebukeBrown
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
}
