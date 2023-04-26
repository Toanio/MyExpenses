//
//  MainViewPresenter.swift
//  MyExpenses
//
//  Created by c.toan on 17.03.2023.
//

import Foundation

class MainViewPresenter {
    var expenses = [ExpensesData?] ()
    
    func fetchExpensesFromStorage() {
        expenses = CoreDataManager.shared.fetchNotes()
    }
    
    func removeElement(indexPath: IndexPath) {
        guard let deleteExpenses = expenses.remove(at: indexPath.row) else { return }
        CoreDataManager.shared.delete(deleteExpenses)
    }
    
    func calculateTotalExpenses()-> Double {
//       var res = 0
//       expenses.forEach { exp in
//           if let exp = exp?.coast {
//               res += Int(exp)!
//           }
//       }
//       return res
        let coast = expenses.compactMap { $0?.coast }
        let doubleCoast = coast.compactMap {Double($0)}
        let result = doubleCoast.reduce(0) { partialResult, result in
            partialResult + result
        }
        return result
   }
}
