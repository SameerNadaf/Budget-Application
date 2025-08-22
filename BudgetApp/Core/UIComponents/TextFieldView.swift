//
//  TextFieldView.swift
//  BudgetApp
//
//  Created by Sameer  on 20/08/25.
//

import UIKit

class TextFieldView: UITextField {
    
    init(placeholder: String, keyBoardType: UIKeyboardType = .default) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.keyboardType = keyBoardType
        self.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.borderStyle = .roundedRect
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        self.leftViewMode = .always
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
