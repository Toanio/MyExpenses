//
//  ViewController.swift
//  MyExpenses
//
//  Created by c.toan on 30.01.2023.
//

import UIKit

class ViewController: UITabBarController {
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        
        viewControllers = [
            createNavController(viewController: MainVC(), title: "Главная"),
            createNavController(viewController: SettingsVC(), title: "Настройки")
        ]
       
    
    }
    
    private func createNavController(viewController: UIViewController, title: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        //navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        navController.tabBarItem.title = title
        return navController
        
    }


}

