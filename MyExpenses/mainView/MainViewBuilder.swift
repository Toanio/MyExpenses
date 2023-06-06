//
//  MainViewBuilder.swift
//  MyExpenses
//
//  Created by c.toan on 30.04.2023.
//

import Foundation
protocol BuilderProtocol {
    func create() -> MainViewController
}
class MainViewBuilder: BuilderProtocol {
    func create() -> MainViewController {
        let presenter = MainViewPresenter()
        let viewController = MainViewController(presenter: presenter)
        return viewController
    }
}
