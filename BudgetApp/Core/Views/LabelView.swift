//
//  LabelView.swift
//  BudgetApp
//
//  Created by Sameer  on 20/08/25.
//

import UIKit

class LabelView: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
