//
//  Item.swift
//  Day22-PersistenceAndCoreData
//
//  Created by 杜赛 on 2020/3/22.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit
import CoreData

class Item: NSManagedObject {
    static func itemsOfCategory(in context: NSManagedObjectContext, linkedWith category: Category) -> [Item] {
        return (category.items?.allObjects as! [Item]).sorted { $0.created! < $1.created! }
    }
    
    static func create(in context: NSManagedObjectContext, title: String, linkedWith category: Category) -> Item {
        let item = Item(context: context)
        item.title = title
        item.created = Date()
        item.id = UUID()
        item.category = category
        item.finished = false
        context.performAndWait {
            do {
                try context.save()
            } catch {
                print("Item - static func create - \(error)")
            }
        }
        return item
    }
    
    static func searchInCategory(in context: NSManagedObjectContext, title: String, linedWith category: Category) -> [Item] {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "created", ascending: true)
        let searchPredicate = NSPredicate(format: "title contains[c] %@", title)
        let categoryPredicate = NSPredicate(format: "category.id == %@", category.id! as CVarArg)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [searchPredicate, categoryPredicate])
        request.sortDescriptors = [sortDescriptor]
        request.predicate = predicate
        var matches = [Item]()
        context.performAndWait {
            do {
                matches = try context.fetch(request)
            } catch {
                print("Item - static func searchInCategory - \(error)")
            }
        }
        return matches
    }
    
    func changeFinishStatus(in context: NSManagedObjectContext) {
        self.finished = !self.finished
        context.performAndWait {
            try? context.save()
        }
    }
}
