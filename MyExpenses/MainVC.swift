//
//  MainViewController.swift
//  MyExpenses
//
//  Created by c.toan on 30.01.2023.
//

import UIKit

struct Expenses {
    var name: String
    var coast: String
    var color: String
}

private let reuseIdentifier = "cell"

class MainVC: UITableViewController {
    
    var expenses = [Expenses?] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ExpensesViewCell.self, forCellReuseIdentifier: ExpensesViewCell.identifier)

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(plusBtnClick))
        
    }
    
    @objc func plusBtnClick() {
        let vc = NewExpensesVC()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExpensesViewCell.identifier, for: indexPath) as! ExpensesViewCell
        cell.nameLabel.text = expenses[indexPath.row]?.name
        cell.coastLabel.text = expenses[indexPath.row]?.coast
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(expenses[indexPath.row]?.color)
    }

}

extension MainVC: AddExpensesDelegate {
    func addExpenses(expenses: Expenses) {
        self.dismiss(animated: true) {
            self.expenses.append(expenses)
            self.tableView.reloadData()
        }
    }
    
    
}
