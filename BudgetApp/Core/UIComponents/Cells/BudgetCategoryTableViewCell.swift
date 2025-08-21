//
//  BudgetTableViewCell.swift
//  BudgetApp
//
//    Created by Sameer  on 21/08/25.
//

import UIKit

class BudgetTableViewCell: UITableViewCell {
    
    lazy var nameLabel = LabelView()
    lazy var amountLabel = LabelView()
    lazy var remainingLabel = LabelView(font: UIFont.systemFont(ofSize: 14), alpha: 0.5)
    let horizontalStackView: UIStackView = StackView(axis: .horizontal, margins: NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 50))
    let verticalStackView: UIStackView = StackView(margins: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        horizontalStackView.addArrangedSubview(nameLabel)
        
        // Spacer
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        horizontalStackView.addArrangedSubview(spacer)
        
        verticalStackView.alignment = .trailing
        verticalStackView.addArrangedSubview(amountLabel)
        verticalStackView.addArrangedSubview(remainingLabel)
        horizontalStackView.addArrangedSubview(verticalStackView)
        self.addSubview(horizontalStackView)

        horizontalStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        horizontalStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        horizontalStackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    func configure(_ budgetCategory: BudgetCategory) {
        nameLabel.text = budgetCategory.name
        amountLabel.text = budgetCategory.amount.formatAsCurrency()
        remainingLabel.text = "Remaining: \(budgetCategory.remainingAmount.formatAsCurrency())"
    }
    
}

#Preview {
    BudgetTableViewCell()
}
