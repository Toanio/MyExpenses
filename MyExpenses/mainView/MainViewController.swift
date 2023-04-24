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
    private let presenter = MainViewPresenter()
    var delegate: sendExpensesProtocol?
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ExpensesViewCell.self, forCellReuseIdentifier: ExpensesViewCell.identifier)
        tableView.register(TotalExpensesFooterView.self, forHeaderFooterViewReuseIdentifier: TotalExpensesFooterView.identifier)
        presenter.fetchExpensesFromStorage()
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
        presenter.fetchExpensesFromStorage()
        tableView.reloadData()
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
        emptyLabel.isHidden = !presenter.expenses.isEmpty
    }
    
    //MARK: - Actions
    
    @objc func plusBtnClick() {
        let vc = NewExpensesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Configure Table View

extension MainViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.expenses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpensesViewCell.identifier, for: indexPath) as? ExpensesViewCell else { return UITableViewCell() }
        cell.nameLabel.text = presenter.expenses[indexPath.row]?.name
        cell.coastLabel.text = presenter.expenses[indexPath.row]?.coast
        cell.typeLabel.text = presenter.expenses[indexPath.row]?.type
        cell.typeLabel.backgroundColor = presenter.expenses[indexPath.row]?.typeColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ExpensesDetailViewController()
        delegate = vc
        guard let expens = presenter.expenses[indexPath.row] else { return }
        delegate?.sendExpenses(expenses: expens)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //Удаление строчки в таблице
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.removeElement(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateEmptyLabel()
        }
    }
    
    //Создание Итого
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: TotalExpensesFooterView.identifier) as! TotalExpensesFooterView
        cell.sumExpensesLabel.text = String(presenter.calculateTotalExpenses())
        return cell
    }
}
