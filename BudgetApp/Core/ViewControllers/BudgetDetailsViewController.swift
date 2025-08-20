//
//  BudgetDetailsViewController.swift
//  BudgetApp
//
//  Created by Sameer  on 20/08/25.
//

import UIKit
import CoreData

class BudgetDetailViewController: UIViewController {
    
    private var persistentContainer: NSPersistentContainer
    private var budgetCategory: BudgetCategory
    
    private lazy var nameTextField = TextFieldView(placeholder: "Transaction name")
    private lazy var amountTextField = TextFieldView(placeholder: "Transaction amount")
    private lazy var saveTransactionButton = PrimaryButton(title: "Save Transaction")
    private lazy var amountLabel = LabelView(text: budgetCategory.amount.formatAsCurrency())
    private let stackView = VerticalStackView(margins: NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TransactionTableViewCell")
        return tableView
    }()
    
    init(budgetCategory: BudgetCategory, persistentContainer: NSPersistentContainer) {
        self.budgetCategory = budgetCategory
        self.persistentContainer = persistentContainer
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = budgetCategory.name
        
        stackView.addArrangedSubview(amountLabel)
        stackView.setCustomSpacing(50, after: amountLabel)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(amountTextField)
        stackView.addArrangedSubview(saveTransactionButton)
        stackView.addArrangedSubview(tableView)
        
        view.addSubview(stackView)
        
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        saveTransactionButton.addTarget(self, action: #selector(saveTransactionButtonPressed), for: .touchUpInside)
        
    }
    
    private var isFormValid: Bool {
        guard let name = nameTextField.text, let amount = amountTextField.text else {
            return false
        }
        
        return FormValidator.isFormValid(name: name, amount: amount)
    }
    
    private func saveTransaction() {
        guard let name = nameTextField.text, let amount = amountTextField.text else {
            return
        }
        
        let transaction = Transaction(context: persistentContainer.viewContext)
        transaction.name = name
        transaction.amount = Double(amount) ?? 0.0
        transaction.category = budgetCategory
        transaction.dateCreated = Date()
        
        do {
            try persistentContainer.viewContext.save()
            tableView.reloadData()
        } catch {
            showAlert(message: "Unable to save transaction")
        }
    }
    
    @objc func saveTransactionButtonPressed(_ sender: UIButton) {
        if isFormValid {
            saveTransaction()
            nameTextField.text = ""
            amountTextField.text = ""
            
        } else {
            guard let name = nameTextField.text,
                  let amount = amountTextField.text else { return }
            
            if name.isEmpty {
                showAlert(message: "Name is required")
            } else if amount.isEmpty {
                showAlert(message: "Amount is required")
            }
        }
    }

}

extension BudgetDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath)
        return cell
    }
    
}

extension BudgetDetailViewController: UITableViewDelegate {
    
}
