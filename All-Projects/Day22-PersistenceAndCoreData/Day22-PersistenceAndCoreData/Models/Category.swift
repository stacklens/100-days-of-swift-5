//
//  Category.swift
//  Day22-PersistenceAndCoreData
//
//  Created by 杜赛 on 2020/3/22.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit
import CoreData


class Category: NSManagedObject {
    static func all(in context: NSManagedObjectContext) -> [Category] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "created", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        var matches = [Category]()
        context.performAndWait {
            do {
                matches = try context.fetch(request)
            } catch {
                print("Category - static func all - \(error)")
            }
        }
        return matches
    }
    
    static func create(in context: NSManagedObjectContext, title: String) -> Category {
        let category = Category(context: context)
        category.id = UUID()
        category.title = title
        category.created = Date()
        context.performAndWait {
            do {
                try context.save()
            } catch {
                print("Category - static func create - \(error)")
            }
        }
        return category
    }
    
    static func delete(in context: NSManagedObjectContext, obj: Category) {
        context.performAndWait {
            context.delete(obj)
            do {
                try context.save()
            } catch {
                print("Category - static func delete - \(error)")
            }
        }
    }
    
    static func update(in context: NSManagedObjectContext, obj: Category, title: String) -> Category {
        obj.title = title
        context.performAndWait {
            do {
                try context.save()
            } catch {
                print("Category - static func update - \(error)")
            }
        }
        return obj
    }
}
