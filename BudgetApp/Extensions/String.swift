//
//  String.swift
//  BudgetApp
//
//  Created by Sameer  on 20/08/25.
//

import Foundation

extension String {
    var isNumber: Bool {
        return Double(self) != nil
    }
    
    func isGreaterThan(_ num: Double) -> Bool {
        guard self.isNumber else {
            return false
        }
        return Double(self)! > num
    }
}
