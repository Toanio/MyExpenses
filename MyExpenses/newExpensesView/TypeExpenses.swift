//
//  TypeExpenses.swift
//  MyExpenses
//
//  Created by c.toan on 06.04.2023.
//

import UIKit

enum TypeExpenses: Int, CaseIterable {
    case Food
    case Entertaiment
    case Sport
    
    var description: String {
        switch self {
        case .Food: return "Food"
        case .Entertaiment: return "Entertaiment"
        case .Sport: return "Sport"
        }
    }
    
    var color: UIColor {
        switch self {
        case .Food: return UIColor.red
        case .Entertaiment: return UIColor.magenta
        case .Sport: return UIColor.green
        }
    }
}
