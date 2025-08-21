//
//  BudgetDetailsViewController.swift
//  BudgetApp
//
//  Created by Sameer  on 20/08/25.
//

import UIKit
import CoreData

final class BudgetDetailViewController: UIViewController {
    
    private var persistentContainer: NSPersistentContainer
    private var budgetCategory: BudgetCategory
    private var fetchResultsController: NSFetchedResultsController<Transaction>!
    
    private let contentView = BudgetDetailView()

    init(budgetCategory: BudgetCategory, persistentContainer: NSPersistentContainer) {
        self.budgetCategory = budgetCategory
        self.persistentContainer = persistentContainer
        super.init(nibName: nil, bundle: nil)
        
        let request = Transaction.fetchRequest()
        request.predicate = NSPredicate(format: "category == %@", budgetCategory)
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        
        fetchResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: persistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchResultsController.delegate = self
        
        do {
            try fetchResultsController.performFetch()
        } catch {
            showAlert(message: "Something went wrong fetching transactions")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = budgetCategory.name
        
        // Setup view data
        contentView.amountLabel.text = budgetCategory.amount.formatAsCurrency()
        updateTransactionTotal()
        
        // Setup delegates
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        
        // Setup button
        contentView.saveTransactionButton.addTarget(
            self,
            action: #selector(saveTransactionButtonPressed),
            for: .touchUpInside
        )
    }
    
    private func updateTransactionTotal() {
        contentView.transactionTotal.text = budgetCategory.transactionTotal.formatAsCurrency()
    }
    
    private var isFormValid: Bool {
        guard let name = contentView.nameTextField.text,
              let amount = contentView.amountTextField.text else {
            return false
        }
        return FormValidator.isFormValid(name: name, amount: amount)
    }
    
    private func resetForm() {
        contentView.nameTextField.text = ""
        contentView.amountTextField.text = ""
    }
    
    private func saveTransaction() {
        guard let name = contentView.nameTextField.text,
              let amount = contentView.amountTextField.text else {
            return
        }
        
        let transaction = Transaction(context: persistentContainer.viewContext)
        transaction.name = name
        transaction.amount = Double(amount) ?? 0.0
        transaction.category = budgetCategory
        transaction.dateCreated = Date()
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            showAlert(message: "Unable to save transaction")
        }
    }
    
    private func deleteTransaction(_ transaction: Transaction) {
        persistentContainer.viewContext.delete(transaction)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            showAlert(message: "Unable to delete transaction")
        }
    }
    
    @objc private func saveTransactionButtonPressed(_ sender: UIButton) {
        if isFormValid {
            saveTransaction()
            resetForm()
        } else {
            guard let name = contentView.nameTextField.text,
                  let amount = contentView.amountTextField.text else { return }
            
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
        (fetchResultsController.fetchedObjects ?? []).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "TransactionTableViewCell",
            for: indexPath
        )
        let transaction = fetchResultsController.object(at: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = transaction.name
        content.secondaryText = transaction.amount.formatAsCurrency()
        cell.contentConfiguration = content
        return cell
    }
}

extension BudgetDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let transaction = fetchResultsController.object(at: indexPath)
            deleteTransaction(transaction)
        }
    }
}

extension BudgetDetailViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        updateTransactionTotal()
        contentView.tableView.reloadData()
    }
}
