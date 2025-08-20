//
//  TextFieldView.swift
//  BudgetApp
//
//  Created by Sameer  on 20/08/25.
//

import UIKit

class TextFieldView: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        self.leftViewMode = .always
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
