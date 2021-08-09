//
//  Notification.swift
//  Toolty
//
//  Created by Chirag Patel on 12/07/21.
//

import Foundation
import UIKit

class Notifications{
    var notificationCount : Int
    var unreadCount : Int
    var status: Int
    
    init(dict: NSDictionary) {
        notificationCount = dict.getIntValue(key: "notifiactionCount")
        unreadCount = dict.getIntValue(key: "unreadCount")
        status = dict.getIntValue(key: "status")
    }
}

class NotificationList{
    var id : String
    var title : String
    var content : String
    var deepLinkStatus : Int
    var type : String
    var elementId : String
    var elementStatus : String
    var readReqiureStatus : Int
    var readStatus : Int
    var dateTime : String
    
    
    init(dict: NSDictionary) {
        id = dict.getStringValue(key: "id")
        title = dict.getStringValue(key: "notification_title")
        content = dict.getStringValue(key: "notification_content")
        deepLinkStatus = dict.getIntValue(key: "deeplink_status")
        type = dict.getStringValue(key: "type")
        elementId = dict.getStringValue(key: "element_id")
        elementStatus = dict.getStringValue(key: "element_status")
        readReqiureStatus = dict.getIntValue(key: "read_required_status")
        readStatus = dict.getIntValue(key: "read_status")
        dateTime = dict.getStringValue(key: "created_at")
    }
}
