//
//  AddBudgetCategoryView.swift
//  BudgetApp
//
//  Created by Sameer  on 21/08/25.
//

import Foundation
import UIKit

class AddBudgetCategoryView: UIView {
    
    let nameTextField = TextFieldView(placeholder: "Budget name")
    let amountTextField = TextFieldView(placeholder: "Budget amount")
    let addBudgetButton = PrimaryButton(title: "Save")
    private let stackView = StackView(margins: NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(amountTextField)
        stackView.addArrangedSubview(addBudgetButton)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
