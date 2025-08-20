//
//  FormValidator.swift
//  BudgetApp
//
//  Created by Sameer  on 20/08/25.
//

struct FormValidator {
    static func isFormValid(name: String?, amount: String?) -> Bool {
        guard let name = name, let amount = amount else { return false }
        return !name.isEmpty && !amount.isEmpty && amount.isNumber && amount.isGreaterThan(0)
    }
}

