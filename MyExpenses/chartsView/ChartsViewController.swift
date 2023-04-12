//
//  SettingsVC.swift
//  MyExpenses
//
//  Created by c.toan on 31.01.2023.
//

import UIKit
import Charts

class ChartsViewController: UIViewController, ChartViewDelegate {
    private let presenter = ChartsViewPresenter()
    var pie = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pie.delegate = self
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        configurePieCharts()
    }
    
    func configurePieCharts() {
        pie.frame = CGRect(x: 0, y: 0,
                           width: self.view.frame.width,
                           height: self.view.frame.width)
        pie.center = view.center
        view.addSubview(pie)
        pie.data = presenter.setData()
    }
}
