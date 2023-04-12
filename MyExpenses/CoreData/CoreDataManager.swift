//
//  CoreDataManager.swift
//  MyExpenses
//
//  Created by c.toan on 04.03.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager(modelName: "MyExpenses")
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(complition: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            complition?()
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("An error ocurred while saving: \(error.localizedDescription)")
            }
        }
    }
    func fetchNotes() -> [ExpensesData] {
        let request: NSFetchRequest<ExpensesData> = ExpensesData.fetchRequest()
        let sortDescriptior = NSSortDescriptor(keyPath: \ExpensesData.lastUpdated, ascending: false)
        request.sortDescriptors = [sortDescriptior]
        return try! viewContext.fetch(request)
    }
    
    func delete(_ expenses: ExpensesData) {
        viewContext.delete(expenses)
        CoreDataManager.shared.save()
    }
}
