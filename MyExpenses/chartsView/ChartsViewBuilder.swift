//
//  ChartsViewBuilder.swift
//  MyExpenses
//
//  Created by c.toan on 30.04.2023.
//

import Foundation

class ChartsViewBuilder {
    func create() -> ChartsViewController {
        let presenter = ChartsViewPresenter()
        let viewController = ChartsViewController(presenter: presenter)
        return viewController
    }
}
