//
//  LabelView.swift
//  BudgetApp
//
//  Created by Sameer  on 20/08/25.
//

import UIKit

class LabelView: UILabel {
    init(text: String? = nil, alignment: NSTextAlignment = .left, font: UIFont? = nil, alpha: CGFloat = 1.0) {
        super.init(frame: .zero)
        self.text = text
        self.alpha = alpha
        self.font = font
        self.textAlignment = alignment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
