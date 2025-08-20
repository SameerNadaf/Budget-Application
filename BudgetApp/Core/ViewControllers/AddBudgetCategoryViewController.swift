//
//  AddBudgetCategoryViewController.swift
//  BudgetApp
//
//  Created by Sameer  on 20/08/25.
//

import UIKit
import CoreData

class AddBudgetCategoryViewController: UIViewController {
    
    private var persistentContainer: NSPersistentContainer
    
    private lazy var nameTextField = TextFieldView(placeholder: "Budget name")
    private lazy var amountTextField = TextFieldView(placeholder: "Budget amount")
    private lazy var addBudgetButton = PrimaryButton(title: "Save")
    private let stackView = VerticalStackView(margins: NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Add Budget"
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
    
}

extension AddBudgetCategoryViewController {
    private func setupUI() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(amountTextField)
        stackView.addArrangedSubview(addBudgetButton)
        
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        amountTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addBudgetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        addBudgetButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
}

extension AddBudgetCategoryViewController {
    private var isFormValid: Bool {
        guard let name = nameTextField.text,
              let amount = amountTextField.text else { return false }
        
        return FormValidator.isFormValid(name: name, amount: amount)
    }
    
    @objc private func addButtonPressed() {
        if isFormValid {
            saveBudgetCategory()
            dismiss(animated: true)
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
    
    private func saveBudgetCategory() {
        guard let name = nameTextField.text,
              let amount = amountTextField.text else { return }
        
        do {
            let budgetCategory = BudgetCategory(context: persistentContainer.viewContext)
            budgetCategory.name = name
            budgetCategory.amount = Double(amount) ?? 0.0
            try persistentContainer.viewContext.save()
        } catch {
            showAlert(message: "Something went wrong saving the budget category")
        }
    }
}
