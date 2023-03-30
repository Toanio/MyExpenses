//
//  SettingsVC.swift
//  MyExpenses
//
//  Created by c.toan on 31.01.2023.
//

import UIKit
import Charts

class ChartsViewController: UIViewController, ChartViewDelegate {
    
    var expenses = CoreDataManager.shared.fetchNotes()
    var pie = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pie.delegate = self
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        pie.frame = CGRect(x: 0, y: 0,
                           width: self.view.frame.width,
                           height: self.view.frame.width)
        pie.center = view.center
        view.addSubview(pie)
        
        let enties = expenses.compactMap { $0.coast }
        let entriesValue = enties.compactMap { Double($0) }
        let entries = entriesValue.compactMap { PieChartDataEntry(value: Double($0)) }
        let set = PieChartDataSet(entries: entries)
        set.colors = [UIColor.red, UIColor.gray, UIColor.blue]
        let data = PieChartData(dataSet: set)
        pie.data = data
        
    }
}
