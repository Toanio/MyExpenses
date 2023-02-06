//
//  NewVC.swift
//  MyExpenses
//
//  Created by c.toan on 01.02.2023.
//

import UIKit
import SnapKit

protocol AddExpensesDelegate {
    func addExpenses(expenses: Expenses)
}

class NewExpensesVC: UIViewController {
   
    var delegate: AddExpensesDelegate?
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Название расхода"
        return label
    }()
    
    let expensesTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название траты"
        textField.becomeFirstResponder()
        textField.borderStyle = .bezel
        return textField
    }()
    
    let coastLabel: UILabel = {
        let label = UILabel()
        label.text = "Стоимость"
        return label
    }()
    
    let coastTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите стоимость"
        textField.borderStyle = .bezel
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        makeTextFields()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnClick))
        
    }
    
    @objc func doneBtnClick() {
        
        guard let name = expensesTextField.text, expensesTextField.hasText else { return }
        guard let coast = coastTextField.text, coastTextField.hasText else { return }
        let expenses = Expenses(name: name, coast: coast)
        delegate?.addExpenses(expenses: expenses)
        navigationController?.popViewController(animated: true)
    }
    
    private func makeTextFields() {
        
        let stack = UIStackView(arrangedSubviews: [
            mainLabel,
            expensesTextField,
            coastLabel,
            coastTextField
        ])
        stack.axis = .vertical
        
        view.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }

}
