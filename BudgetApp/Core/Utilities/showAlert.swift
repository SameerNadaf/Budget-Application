//
//  showAlert.swift
//  BudgetApp
//
//  Created by Sameer  on 20/08/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String = "Oops", message: String, buttonTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default))
        present(alert, animated: true)
    }
}
