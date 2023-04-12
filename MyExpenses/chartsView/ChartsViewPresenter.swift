//
//  ChartsViewPresenter.swift
//  MyExpenses
//
//  Created by c.toan on 04.04.2023.
//

import UIKit
import Charts
class ChartsViewPresenter {
    var expenses = CoreDataManager.shared.fetchNotes()
    
    func configureEntries()-> [PieChartDataEntry] {
        let enties = expenses.compactMap { $0.coast }
        let entriesValue = enties.compactMap { Double($0) }
        let entries = entriesValue.compactMap { PieChartDataEntry(value: Double($0)) }
        return entries
    }
    
    func setData() -> PieChartData {
        let set = PieChartDataSet(entries: configureEntries())
        set.colors = [UIColor.red, UIColor.gray, UIColor.blue]
        let data = PieChartData(dataSet: set)
        return data
    }
    
    func test() {
        let entries = expenses.compactMap { $0.type }
        print(entries)
    }
}
