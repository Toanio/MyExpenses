//
//  ExpensesDetailViewBuilder.swift
//  MyExpenses
//
//  Created by c.toan on 10.05.2023.
//

import UIKit

class ExpensesDetailViewBuilder {
    func create() -> ExpensesDetailViewController {
        let presenter = ExpensesDetailViewPresenter()
        let viewController = ExpensesDetailViewController(presenter: presenter)
        return viewController
    }
    
}
