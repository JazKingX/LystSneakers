//
//  NotificationManager.swift
//  LystSneakers
//
//  Created by Jaz King on 24/07/2017.
//  Copyright © 2017 Jaz King. All rights reserved.
//

import Foundation
import UIKit

class NotificationManager {
    
    //Set notification in 5 mins
    func setNotificationIn5(_ name: String, type: String) {
        
        print("Set notification is called")
        
        //Set notification for 5 mins after current time
        let fireDate = NSDate()
        
        // ios 9 notification
        let notification = UILocalNotification()
        
        //Set notification details
        notification.category = "Product Notification"
        notification.userInfo = [ "NotificationID"  : "\(name)",]
        notification.alertBody = "Your \(name) \(type) is on sale now!!"
        
        //Set notification 5 mins from now
        notification.fireDate = fireDate.addingTimeInterval(60 * 5) as Date
        
        //Set notitification sound
        notification.soundName = UILocalNotificationDefaultSoundName
        
        //Schedule Notification
        UIApplication.shared.scheduleLocalNotification(notification)
        
        
        
    }

    
}
