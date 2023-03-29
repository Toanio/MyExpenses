//
//  ExpensesData+CoreDataProperties.swift
//  
//
//  Created by c.toan on 29.03.2023.
//
//

import Foundation
import CoreData
import UIKit


extension ExpensesData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpensesData> {
        return NSFetchRequest<ExpensesData>(entityName: "ExpensesData")
    }

    @NSManaged public var coast: String?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var typeColor: UIColor?

}
