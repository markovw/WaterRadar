//
//  NotificationViewModel.swift
//  hydrated-app
//
//  Created by Vladislav on 01.06.2024.
//

import SwiftUI
import UserNotifications

class NotificationViewModel: ObservableObject {
    func checkForPermission() {
        let notificatonCenter = UNUserNotificationCenter.current()
        notificatonCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                notificatonCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.dispatchNotification()
                    }
                }
            case .denied:
                return
            case .authorized:
                
                self.dispatchNotification()
            default: 
                return
            }
        }
    }
    
    func dispatchNotification() {
        let identifier = "my-morning-notification"
        
        let title = "Time to work out"
        let body = "Dont be a lazy"
        let hour = 00
        let minute = 24
        let isDaily = true
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }
}
