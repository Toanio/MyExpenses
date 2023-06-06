//
//  ChartsViewPresenter.swift
//  MyExpenses
//
//  Created by c.toan on 04.04.2023.
//

import UIKit
import Charts

protocol ChartsViewPresenterProtocol {
    var expenses: [ExpensesData] { get }
    func setData() -> PieChartData
    func configureEntries() -> [PieChartDataEntry]
    func filterExpensesData(color: UIColor) -> Double
}

class ChartsViewPresenter: ChartsViewPresenterProtocol {
    var expenses: [ExpensesData] {
            return CoreDataManager.shared.fetchNotes()
        }
    
    func setData() -> PieChartData {
        let set = PieChartDataSet(entries: configureEntries())
        set.colors = [UIColor.red, UIColor.green, UIColor.magenta, UIColor.gray]
        let data = PieChartData(dataSet: set)
        return data
    }
    
    func configureEntries() -> [PieChartDataEntry] {
        let otherType = expenses.filter { $0.type == "Select type" }
        let otherTypeString = otherType.compactMap { $0.coast }
        let otherCoast = otherTypeString.compactMap { Double($0) }
        let sumOtherCoast = otherCoast.reduce(0) { $0 + $1 }
        
        var entries: [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: filterExpensesData(color: .red), label: "Red Value"))
        entries.append(PieChartDataEntry(value: filterExpensesData(color: .green), label: "Green Value"))
        entries.append(PieChartDataEntry(value: filterExpensesData(color: .magenta), label: "Magenta Value"))
        entries.append(PieChartDataEntry(value: sumOtherCoast, label: "Other Value"))
        return entries
    }
    
    func filterExpensesData(color: UIColor) -> Double {
        let redType = expenses.filter { $0.typeColor == color }
        let redCoastString = redType.compactMap { $0.coast }
        let redCoast = redCoastString.compactMap { Double($0) }
        let sumRedCoast = redCoast.reduce(0) { $0 + $1 }
        return sumRedCoast
    }
}
