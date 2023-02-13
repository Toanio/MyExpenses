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

class MainViewController: UITableViewController {
    var expenses = [Expenses?] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ExpensesViewCell.self, forCellReuseIdentifier: ExpensesViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(plusBtnClick))
    }
    
    //MARK: - Actions
    
    @objc func plusBtnClick() {
        let vc = NewExpensesViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: AddExpensesDelegate {
    func addExpenses(expenses: Expenses) {
        self.dismiss(animated: true) {
            self.expenses.append(expenses)
            self.tableView.reloadData()
        }
    }
}

//MARK: - Configure Table View

extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpensesViewCell.identifier, for: indexPath) as? ExpensesViewCell else { return UITableViewCell() }
        cell.nameLabel.text = expenses[indexPath.row]?.name
        cell.coastLabel.text = expenses[indexPath.row]?.coast
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(expenses[indexPath.row]?.color)
    }
}
