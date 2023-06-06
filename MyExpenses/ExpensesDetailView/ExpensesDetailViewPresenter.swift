//
//  ExpensesDetailViewPresenter.swift
//  MyExpenses
//
//  Created by c.toan on 10.05.2023.
//

import UIKit

protocol ExpensesDetailViewPresenterProtocol {
    func test()
}
class ExpensesDetailViewPresenter: ExpensesDetailViewPresenterProtocol {
    
    func test() {
        CoreDataManager.shared.save()
        print("Test save base")
    }
    
}
