//
//  AppDelegate.swift
//  Day22-PersistenceAndCoreData
//
//  Created by 杜赛 on 2020/3/22.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Day22_PersistenceAndCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    static var persistentContainer: NSPersistentContainer {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    
    static var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    /*
     AppDelegate.persistentContainer.performBackgroundTask { context in
        // do some CoreData stuff using the passed-in context
        // this closure is not the main queue, so don't do UI stuff here (dispatch if needed)
        // and don't use AppDelegate.viewContext here, use the passed context
        // you don't have to use NSManagedObjectContext's perform method here either
        // since you're implicitly doing this block on that passed context's thread
        // try? context.save() // don't forget this
     }
     
     
     This is a method we can implement in our NSManagedObject subclass...
     func prepareForDeletion() { ... }
     
     
     Thread-Safe Access to an NSManagedObjectContext
     context.performBlock { // or performBlockAndWait until it finishes
        // do stuff with context (this will happen in its safe Q (the Q it was created on)
     }
     
     
     NSFetchedResultsController
     Hooks an NSFFetchREquest upto a UITableViewController.
     var fetchedResultsController = NSFetchedResultsController... // more on this in a moment
     func numberOfsectionsInTableView(sender: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 1
     }
     func tableView(sender: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController?.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
     }
     func object(at indexPath: NSIndexPath) -> NSManagedObject
     func tableView(_ tv: UITableView, cellForRowAt indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tv.dequeue...
        if let obj = fetchedResultsController.object(at: indexPath) {
            // load up the cell based on the properties of the obj
            // obj will be an NSManagedObject (or subclass thereof) that fetches into this row
        }
        return cell
     }
     let frc = NSFetchedResultsController<Tweet>(
        fetchRequest: request,
        managedObjectContext: context,
        sectionNameKeyPath: keyThatSaysWhichAttributeIsTheSectionName,
        cacheName: "xxxCache" // carefull!
     )
     
     */

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

