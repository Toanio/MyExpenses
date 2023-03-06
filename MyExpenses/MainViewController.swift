//
//  MainViewController.swift
//  MyExpenses
//
//  Created by c.toan on 30.01.2023.
//

import UIKit
protocol sendExpensesProtocol {
    func sendExpenses(expenses: ExpensesData)
}

class MainViewController: UITableViewController {
    var expenses = [ExpensesData?] ()
    var delegate: sendExpensesProtocol?
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ExpensesViewCell.self, forCellReuseIdentifier: ExpensesViewCell.identifier)
        tableView.register(TotalExpensesFooterView.self, forHeaderFooterViewReuseIdentifier: TotalExpensesFooterView.identifier)
        fetchExpensesFromStorage()
        configureEmptyLabel()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(plusBtnClick))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchExpensesFromStorage() //Обновить таблицу?
        updateEmptyLabel()
    }
    
    private func configureEmptyLabel() {
        view.addSubview(emptyLabel)
        emptyLabel.text = "Трат не было"
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func updateEmptyLabel() {
        emptyLabel.isHidden = !expenses.isEmpty
    }
    
    private func fetchExpensesFromStorage() {
        expenses = CoreDataManager.shared.fetchNotes()
    }
    
    //MARK: - Actions
    
    @objc func plusBtnClick() {
        let vc = NewExpensesViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: AddExpensesDelegate {
    func addExpenses() {
        self.dismiss(animated: true) {
            //self.expenses.append(expenses)
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
        //cell.typeLabel.backgroundColor = expenses[indexPath.row]?.color
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
            guard let deleteExpenses = expenses.remove(at: indexPath.row) else { return }
            CoreDataManager.shared.delete(deleteExpenses)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateEmptyLabel()
            tableView.endUpdates()
        }
    }
    
    //Создание Итого
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: TotalExpensesFooterView.identifier) as! TotalExpensesFooterView
        var res = 0
        expenses.forEach { exp in
            if let exp = exp?.coast {
                res += Int(exp)!
            }
        }
        cell.sumExpensesLabel.text = String(res)
        return cell
    }
}
