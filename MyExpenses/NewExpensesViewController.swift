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

class NewExpensesViewController: UIViewController  {
    var showMenu = false
    var delegate: AddExpensesDelegate?
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Название расхода"
        return label
    }()
    lazy var expensesTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название траты"
        textField.becomeFirstResponder()
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 2
        textField.keyboardType = .default
        textField.returnKeyType = .next
        textField.borderStyle = .bezel
        return textField
    }()
    lazy var coastLabel: UILabel = {
        let label = UILabel()
        label.text = "Стоимость"
        return label
    }()
    lazy var coastTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите стоимость"
        textField.borderStyle = .bezel
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 2
        textField.keyboardType = .numberPad
        textField.returnKeyType = .done
        return textField
    }()
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .compact
        picker.datePickerMode = .date
        return picker
    }()
    lazy var typeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .darkGray
        button.addTarget(self, action: #selector(someMethod), for: .touchUpInside)
        button.setTitle("Выбор типа", for: .normal)
        return button
    }()
    lazy var tableView: UITableView = UITableView()
    
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
        expensesTextField.delegate = self
        coastTextField.delegate = self
        let stack = UIStackView(arrangedSubviews: [
            mainLabel,
            expensesTextField,
            coastLabel,
            coastTextField,
            datePicker,
            typeButton,
        ])
        stack.axis = .vertical
        stack.spacing = 5
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    private func configureTableView()  {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(typeButton).offset(31)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(200)
        }
    }
    
    //MARK: - Actions
    
    @objc func doneBtnClick() {
        guard let name = expensesTextField.text, expensesTextField.hasText,
              let coast = coastTextField.text, coastTextField.hasText,
              let color = typeButton.backgroundColor,
              let description = typeButton.titleLabel?.text
        else {
            coastTextField.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
            expensesTextField.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
            return
        }
        let expenses = Expenses(name: name, coast: coast, type: description, color: color)
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

extension NewExpensesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == expensesTextField {
            coastTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            doneBtnClick()
        }
        return true
    }
    //Разобраться в реализации
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == coastTextField {
            let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
            return (string.rangeOfCharacter(from: invalidCharacters) == nil)
        }
        return true
    }
}

extension NewExpensesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showMenu ? TypeExpenses.allCases.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let expens = TypeExpenses(rawValue: indexPath.row)
        cell.textLabel?.text = expens?.description
        cell.backgroundColor = expens?.color
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let expens = TypeExpenses(rawValue: indexPath.row)
        typeButton.setTitle(expens?.description, for: .normal)
        typeButton.backgroundColor = expens?.color
        showMenu = false
        var indexPaths = [IndexPath]()

        TypeExpenses.allCases.forEach { (color) in
            let indexPath = IndexPath(row: color.rawValue, section: 0)
            indexPaths.append(indexPath)
        }
        tableView.deleteRows(at: indexPaths, with: .fade)
    }
}
