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

enum TypeExpenses: Int, CaseIterable {
    case Food
    case Entertaiment
    case Sport
    
    var description: String {
        switch self {
        case .Food: return "Food"
        case .Entertaiment: return "Entertaiment"
        case .Sport: return "Sport"
        }
    }
    
    var color: UIColor {
        switch self {
        case .Food: return UIColor.red
        case .Entertaiment: return UIColor.magenta
        case .Sport: return UIColor.green
        }
    }
}

class NewExpensesVC: UIViewController  {
   
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
        textField.keyboardType = .default
        textField.returnKeyType = .next
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
        textField.keyboardType = .numbersAndPunctuation
        textField.returnKeyType = .done
        return textField
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .compact
        picker.datePickerMode = .date
        return picker
    }()
    
    let saveBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .darkGray
        button.addTarget(self, action: #selector(someMethod), for: .touchUpInside)
        button.setTitle("Выбор типа", for: .normal)
        return button
    }()
    
    var tableView: UITableView!
    var showMenu = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        configureTextFields()
        configureTableView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnClick))
        
    }
    
    //MARK: - Configures
    private func configureTextFields() {
        
        let stack = UIStackView(arrangedSubviews: [
            mainLabel,
            expensesTextField,
            coastLabel,
            coastTextField,
            datePicker,
            saveBtn,
        ])
        stack.axis = .vertical
        stack.spacing = 5
        
        view.addSubview(stack)
        
        expensesTextField.delegate = self
        coastTextField.delegate = self
        
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    func configureTableView()  {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(saveBtn).offset(31)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    //MARK: - Actions
    @objc func doneBtnClick() {
        
        guard let name = expensesTextField.text, expensesTextField.hasText else { return }
        guard let coast = coastTextField.text, coastTextField.hasText else { return }
        guard let color = saveBtn.titleLabel?.text else { return }
        let expenses = Expenses(name: name, coast: coast, color: color)
        delegate?.addExpenses(expenses: expenses)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func someMethod() {
        showMenu = !showMenu
        
        var indexPaths = [IndexPath]()
        
        TypeExpenses.allCases.forEach { (color) in
            let indexPath = IndexPath(row: color.rawValue, section: 0)
            indexPaths.append(indexPath)
        }
        
        if showMenu {
            tableView.insertRows(at: indexPaths, with: .fade)
        } else {
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
    }

}

extension NewExpensesVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == expensesTextField {
            coastTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            doneBtnClick()
        }
        return true
    }
    
    
}

extension NewExpensesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showMenu ? TypeExpenses.allCases.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = TypeExpenses(rawValue: indexPath.row)?.description
        cell.backgroundColor = TypeExpenses(rawValue: indexPath.row)?.color
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        saveBtn.setTitle(TypeExpenses(rawValue: indexPath.row)?.description, for: .normal)
        saveBtn.backgroundColor = TypeExpenses(rawValue: indexPath.row)?.color
        showMenu = false
        
        var indexPaths = [IndexPath]()

        TypeExpenses.allCases.forEach { (color) in
            let indexPath = IndexPath(row: color.rawValue, section: 0)
            indexPaths.append(indexPath)
        }
        tableView.deleteRows(at: indexPaths, with: .fade)
    }
    
    
}
