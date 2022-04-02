//
//  Alerts.swift
//  School App
//
//  Created by Ahmed on 18/01/2021.
//

import Foundation
import UIKit
extension  UIViewController {

    func showAlertWithOkAndCancel(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
        })
        alert.addAction(ok)
        alert.addAction(cancel)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    func showAlertWithOk(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }

}
enum Alert{
    enum String {
        static let alert = "Alert"
        static let emptyNewAndConfirmPassword = "Password and Confirm Password is Empty"
        static let passwordNotMatched = "Password Not Matched"
        static let passwordLengthShort = "Password Length is Short"
        static let textFieldIsEmpty = "Textfield is Empty"
    }
}

