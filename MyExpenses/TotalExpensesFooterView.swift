//
//  TotalExpensesFooterView.swift
//  MyExpenses
//
//  Created by c.toan on 16.02.2023.
//

import UIKit
import SnapKit

class TotalExpensesFooterView: UITableViewHeaderFooterView {
    static let identifier = "TotalExpensesFooter"
    var expenses = [Expenses?]()
    lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Итог: "
        return label
    }()
    lazy var sumExpensesLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureTotalFooterView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTotalFooterView() {
        let stack = UIStackView(arrangedSubviews: [
            totalLabel, sumExpensesLabel
        ])
        stack.axis = .horizontal
        contentView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
}
