//
//  ViewController.swift
//  Day24-LocalNotification
//
//  Created by 杜赛 on 2020/3/25.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController
{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        requestNotificationAuthorization()
    }
    
    @IBAction func intervalNotification(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = "Feed the cat"
        content.subtitle = "It looks hungry"
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
    
    @IBAction func scheduleNotification(_ sender: UIButton) {
        let manager = LocalNotificationManager()
        manager.notifications = [
            LocalNotification(id: "reminder-1", title: "Remember the milk!", datetime: DateComponents(calendar: Calendar.current, year: 2019, month: 4, day: 22, hour: 17, minute: 0)),
            LocalNotification(id: "reminder-2", title: "Ask Bob from accounting", datetime: DateComponents(calendar: Calendar.current, year: 2019, month: 4, day: 22, hour: 17, minute: 1)),
            LocalNotification(id: "reminder-3", title: "Send postcard to mom", datetime: DateComponents(calendar: Calendar.current, year: 2019, month: 4, day: 22, hour: 17, minute: 2))
        ]

        manager.schedule()
    }
    
    
    @IBAction func notificationWithActions(_ sender: UIButton) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
        
        let categoryID = "User Actions"
        
        let category = UNNotificationCategory(identifier: categoryID, actions: [snoozeAction, deleteAction], intentIdentifiers: [], options: [])
        notificationCenter.setNotificationCategories([category])
        
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = categoryID
        content.title = "Notification"
        content.body = "WithActions.."
        
        // Add Trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)

        // Create Notification Request
        let request = UNNotificationRequest(identifier: "cocoacasts_local_notification", content: content, trigger: trigger)

        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
        
    }
    
    
    
    private func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(
        options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

