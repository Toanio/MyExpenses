//
//  MainViewPresenter.swift
//  MyExpenses
//
//  Created by c.toan on 17.03.2023.
//

import Foundation

protocol MainViewPresenterProtocol {
    var expenses: [ExpensesData?] { get }
    func fetchExpensesFromStorage()
    func removeElement(indexPath: IndexPath)
    func calculateTotalExpenses()-> Double
}

class MainViewPresenter: MainViewPresenterProtocol{
    var expenses = [ExpensesData?] ()
    
    func fetchExpensesFromStorage() {
        expenses = CoreDataManager.shared.fetchNotes()
    }
    
    func removeElement(indexPath: IndexPath) {
        guard let deleteExpenses = expenses.remove(at: indexPath.row) else { return }
        CoreDataManager.shared.delete(deleteExpenses)
    }
    
    func calculateTotalExpenses()-> Double {
        let coast = expenses.compactMap { $0?.coast }
        let doubleCoast = coast.compactMap {Double($0)}
        let result = doubleCoast.reduce(0) { $0 + $1}
        return result
   }    
}

