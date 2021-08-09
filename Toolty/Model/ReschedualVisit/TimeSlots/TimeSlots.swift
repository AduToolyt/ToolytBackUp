//
//  TimeSlots.swift
//  Toolty
//
//  Created by Chirag Patel on 26/07/21.
//

import Foundation
import UIKit

class TimeSlots{
    var timeStr : String
    var availableStatus : Int
    var schedualTime : String
    var intervalTime : String
    var isSelected : Bool = false
    
    init(dict: NSDictionary) {
        timeStr = dict.getStringValue(key: "interval")
        availableStatus = dict.getIntValue(key: "available_status")
        schedualTime = dict.getStringValue(key: "schedule_time")
        intervalTime = dict.getStringValue(key: "interval_times")
    }
}
