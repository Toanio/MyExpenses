//
//  NewExpensesBuilder.swift
//  MyExpenses
//
//  Created by c.toan on 28.04.2023.
//

import Foundation

class NewExpensesBuilder {
    func create() -> NewExpensesViewController {
        let presenter = NewExpensesPresenter()
        let viewController = NewExpensesViewController(presenter: presenter)
        return viewController
    }
}
