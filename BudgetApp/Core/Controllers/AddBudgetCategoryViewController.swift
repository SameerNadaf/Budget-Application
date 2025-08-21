//
//  AddBudgetCategoryViewController.swift
//  BudgetApp
//
//  Created by Sameer  on 20/08/25.
//

import UIKit
import CoreData

class AddBudgetCategoryViewController: UIViewController {
    
    private let persistentContainer: NSPersistentContainer
    private let contentView = AddBudgetCategoryView()
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Budget"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        contentView.addBudgetButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    
    private func saveBudgetCategory() {
        guard let name = contentView.nameTextField.text, let amount = contentView.amountTextField.text else {
            return
        }
        
        do {
            let budgetCategory = BudgetCategory(context: persistentContainer.viewContext)
            budgetCategory.name = name
            budgetCategory.amount = Double(amount) ?? 0.0
            try persistentContainer.viewContext.save()
            dismiss(animated: true)
        } catch {
            showAlert(message: "Unable to save budget category")
        }
    }
    
    @objc private func addButtonPressed() {
        guard let name = contentView.nameTextField.text,
              let amount = contentView.amountTextField.text else { return }
        
        if FormValidator.isFormValid(name: name, amount: amount) {
            saveBudgetCategory()
            dismiss(animated: true)
        } else {
            if name.isEmpty {
                showAlert(message: "Name is required")
            } else if amount.isEmpty {
                showAlert(message: "Amount is required")
            }
        }
    }
}
