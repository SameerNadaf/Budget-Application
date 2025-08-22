//
//  BudgetDetailView.swift
//  BudgetApp
//
//  Created by Sameer  on 21/08/25.
//

import UIKit

final class BudgetDetailView: UIView {
    
    // MARK: - UI Components
    let nameTextField = TextFieldView(placeholder: "Transaction name")
    let amountTextField = TextFieldView(placeholder: "Transaction amount", keyBoardType: .decimalPad)
    let saveTransactionButton = PrimaryButton(title: "Save Transaction")
    let amountLabel = LabelView(text: "")
    let transactionTotal = LabelView(text: "", alignment: .center)
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TransactionTableViewCell")
        return tableView
    }()
    
    private let stackView = StackView(
        margins: NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
    )
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .white
        
        stackView.addArrangedSubview(amountLabel)
        stackView.setCustomSpacing(50, after: amountLabel)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(amountTextField)
        stackView.addArrangedSubview(saveTransactionButton)
        stackView.addArrangedSubview(transactionTotal)
        stackView.addArrangedSubview(tableView)
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tableView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
}
