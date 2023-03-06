//
//  ExpensesDetailViewController.swift
//  MyExpenses
//
//  Created by c.toan on 14.02.2023.
//

import UIKit

class ExpensesDetailViewController: UIViewController {
    var expenses = [ExpensesData?]()
    lazy var coastLabel = UILabel()
    lazy var typeLabel = UILabel()
    lazy var nameExpensesLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(30)
        return label
    }()
    lazy var coastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Стоимость: "
        return label
    }()
    lazy var typeNameExpensesLabel: UILabel = {
        let label = UILabel()
        label.text = "Тип: "
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainView()
    }
    
    private func configureMainView() {
        let coastStack = UIStackView(arrangedSubviews: [
            coastNameLabel, coastLabel
        ])
        coastStack.axis = .horizontal
        let typeStack = UIStackView(arrangedSubviews: [
            typeNameExpensesLabel, typeLabel
        ])
        coastStack.axis = .horizontal
        let stack = UIStackView(arrangedSubviews: [
            nameExpensesLabel,
            coastStack,
            typeStack,
        ])
        stack.axis = .vertical
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(10)
        }
    }
}

extension ExpensesDetailViewController: sendExpensesProtocol {
    func sendExpenses(expenses: ExpensesData) {
        self.nameExpensesLabel.text = expenses.name
        self.coastLabel.text = expenses.coast
        self.typeLabel.text = expenses.type
    }
}
