//
//  NewExpensesPresenter.swift
//  MyExpenses
//
//  Created by c.toan on 30.03.2023.
//

import Foundation
protocol NewExpensesPresenterProtocol {
    var showMenu: Bool { get }
    func changeShowMenu()
    func menuValues() -> [IndexPath]
}

class NewExpensesPresenter: NewExpensesPresenterProtocol {
    var showMenu = false
    
    func changeShowMenu() {
        showMenu = !showMenu
    }
    
    func menuValues() -> [IndexPath] {
        var indexPaths = [IndexPath]()
        
        TypeExpenses.allCases.forEach { (color) in
            let indexPath = IndexPath(row: color.rawValue, section: 0)
            indexPaths.append(indexPath)
        }
        return indexPaths
    }
}

