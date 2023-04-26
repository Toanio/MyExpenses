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
    func setData() -> PieChartData {
        let set = PieChartDataSet(entries: configureEntries())
        set.colors = [UIColor.red, UIColor.green, UIColor.magenta, UIColor.gray]
        let data = PieChartData(dataSet: set)
        return data
    }
    
    func configureEntries() -> [PieChartDataEntry] {
        let redType = expenses.filter { $0.typeColor == .red }
        let redCoastString = redType.compactMap { $0.coast }
        let redCoast = redCoastString.compactMap { Double($0) }
        let sumRedCoast = redCoast.reduce(0) { partialResult, value in
            partialResult + value
        }
        
        let greenType = expenses.filter { $0.typeColor == .green }
        let greenCoastString = greenType.compactMap { $0.coast }
        let greenCoast = greenCoastString.compactMap { Double($0) }
        let sumGreenCoast = greenCoast.reduce(0) { partialResult, value in
            partialResult + value
        }
        
        let magentaType = expenses.filter { $0.typeColor == .magenta }
        let magentaCoastString = magentaType.compactMap { $0.coast }
        let magentaCoast = magentaCoastString.compactMap { Double($0) }
        let sumMagentaCoast = magentaCoast.reduce(0) { partialResult, value in
            partialResult + value
        }
        
        let otherType = expenses.filter { $0.type == "Select type" }
        let otherTypeString = otherType.compactMap { $0.coast }
        let otherCoast = otherTypeString.compactMap { Double($0) }
        let sumOtherCoast = otherCoast.reduce(0) { partialResult, value in
            partialResult + value
        }
        
        var entries: [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: sumRedCoast, label: "Red Value"))
        entries.append(PieChartDataEntry(value: sumGreenCoast, label: "Green Value"))
        entries.append(PieChartDataEntry(value: sumMagentaCoast, label: "Magenta Value"))
        entries.append(PieChartDataEntry(value: sumOtherCoast, label: "Other Value"))
        return entries
    }
}
