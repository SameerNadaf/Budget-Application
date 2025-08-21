//
//  NSSet.swift
//  BudgetApp
//
//  Created by Sameer  on 21/08/25.
//

import Foundation

extension NSSet {
    
    func toArray<T>() -> [T] {
        let array = self.map { $0 as! T}
        return array
    }
    
}
