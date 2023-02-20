//
//  MainViewController.swift
//  MyExpenses
//
//  Created by c.toan on 30.01.2023.
//

import UIKit
protocol sendExpensesProtocol {
    func sendExpenses(expenses: Expenses)
}
struct Expenses {
    var name: String
    var coast: String
    var type: String
    var color: UIColor
}

class MainViewController: UITableViewController {
    var expenses = [Expenses?] ()
    var delegate: sendExpensesProtocol?
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ExpensesViewCell.self, forCellReuseIdentifier: ExpensesViewCell.identifier)
        tableView.register(TotalExpensesFooterView.self, forHeaderFooterViewReuseIdentifier: TotalExpensesFooterView.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        configureEmptyLabel()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(plusBtnClick))
    }
    
    private func configureEmptyLabel() {
        view.addSubview(emptyLabel)
        if expenses.isEmpty {
            emptyLabel.text = "Трат не было"
        } else {
            emptyLabel.isHidden = true
        }
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
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
        cell.typeLabel.text = expenses[indexPath.row]?.type
        cell.typeLabel.backgroundColor = expenses[indexPath.row]?.color
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ExpensesDetailViewController()
        delegate = vc
        guard let expens = expenses[indexPath.row] else { return }
        delegate?.sendExpenses(expenses: expens)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //Удаление строчки в таблице
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            expenses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: TotalExpensesFooterView.identifier) as! TotalExpensesFooterView
        cell.sumExpensesLabel.text = "50"
        return cell
    }
}
