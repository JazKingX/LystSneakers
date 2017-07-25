//
//  NotificationManager.swift
//  LystSneakers
//
//  Created by Jaz King on 24/07/2017.
//  Copyright © 2017 Jaz King. All rights reserved.
//

import Foundation
import UIKit

class notificationManager {
    
    var itemName: String
    var itemType: String
    
    func setNotificationIn5() {
        
        //Set notification for 5 mins after current time
        var date = DateComponents()
        date.minute = 5
        
        // ios 9 notification
        let notification = UILocalNotification()
        notification.fireDate = date.date
        notification.alertBody = "Your \(itemName) \(itemType) is on sale now!!"
        //notification1.alertAction = "be awesome!"
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.shared.scheduleLocalNotification(notification)
        
    }
    
    init(itemName: String, itemType: String) {
        self.itemName = itemName
        self.itemType = itemType
    }
    
}
