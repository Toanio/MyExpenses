//
//  ExpensesViewCell.swift
//  MyExpenses
//
//  Created by c.toan on 06.02.2023.
//

import UIKit
import SnapKit

class ExpensesViewCell: UITableViewCell {
    static let identifier = "ExpensesViewCell"
    var nameLabel = UILabel()
    var coastLabel = UILabel()
    var typeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeForm()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeForm() {
        let stack = UIStackView(arrangedSubviews: [
            nameLabel, typeLabel, coastLabel
        ])
        stack.axis = .horizontal
        stack.spacing = 5
        contentView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
}
