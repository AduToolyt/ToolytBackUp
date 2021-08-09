//
//  Home.swift
//  Toolty
//
//  Created by Devang Lakhani  on 7/8/21.
//

import Foundation
import UIKit

enum EnumHome{
    case collCell
    case activityCell
    case missedActivityCell
    
    
    var cellId : String{
        switch self{
        case .collCell:
            return "cell1"
        case .activityCell:
            return "cell2"
        case .missedActivityCell:
            return "cell3"
        }
    }
    
    var collCellId : String{
        switch self {
        case .collCell:
            return "collCell1"
        case .missedActivityCell:
            return "collCell2"
        default : return ""
        }
    }
    
    var cellHeight : CGFloat{
        switch self{
        case .collCell:
            return 100.widthRatio
        case .activityCell:
            return UITableView.automaticDimension
        case .missedActivityCell:
            return 150.widthRatio
        }
    }
    
    var sectionTitle: String{
        switch self {
        case .activityCell:
            return "Upcoming Activites"
        case .missedActivityCell:
            return "Missed Activites"
        default : return ""
        }
    }
}


class Home{
    var schedualCount : Int
    var visitRecordingEnable : Int
    var activitiesCount : Int
    var arrPending : [Pending] = []
    var filterLabel : FilterLabel?
    var arrUpcoming : [Schedules] = []
    var arrMissedActivity : [Schedules] = []
    var arrUserList : [GetUserList] = []
    
    init(dict: NSDictionary) {
        schedualCount = dict.getIntValue(key: "shedulesCount")
        visitRecordingEnable = dict.getIntValue(key: "visitRecordingEnalbed")
        activitiesCount = dict.getIntValue(key: "activitiesCount")
        
        if let dictPending = dict["pending"] as? [NSDictionary]{
            for dictData in dictPending{
                let objData = Pending(dict: dictData)
                self.arrPending.append(objData)
            }
        }
        
        if let filterDict = dict["filterLabels"] as? NSDictionary{
            self.filterLabel = FilterLabel(dict: filterDict)
        }
        
        if let upcomingDict = dict["schedules"] as? [NSDictionary]{
            for dict in upcomingDict{
                let objData = Schedules(dict: dict)
                self.arrUpcoming.append(objData)
            }
        }
        if let actiVityDict = dict["activities"] as? [NSDictionary]{
            for dictData in actiVityDict{
                let objData = Schedules(dict: dictData)
                self.arrMissedActivity.append(objData)
            }
        }
        
        if let userList = dict["userList"] as? [NSDictionary]{
            for dictData in userList{
                let objData = GetUserList(dict: dictData)
                self.arrUserList.append(objData)
            }
        }
    }
}

class Pending{
    var title : String
    var count : Int
    var moduleId : String
    var linkStatus : String
    
    init(dict: NSDictionary) {
        title = dict.getStringValue(key: "label")
        count = dict.getIntValue(key: "count")
        moduleId = dict.getStringValue(key: "module_id")
        linkStatus = dict.getStringValue(key: "link_status")
    }
}

class FilterLabel{
    var globleRegionLabel : String
    var label : String
    var zoneLabel : String
    var regionLabel : String
    var userLabel : String
    
    init(dict: NSDictionary) {
        globleRegionLabel = dict.getStringValue(key: "global_region_label")
        label = dict.getStringValue(key: "team_label")
        zoneLabel = dict.getStringValue(key: "zone_label")
        regionLabel = dict.getStringValue(key: "region_label")
        userLabel = dict.getStringValue(key: "user_label")
    }
}

class Schedules{
    var id : String
    var recordingurl : String
    var assignBy : String
    var customerId : String
    var statusType : String
    var copanyName : String
    var fullName : String
    var firstName : String
    var lastName : String
    var visitState : String
    var leadStatusId : String
    var orderPrivilege: String
    var paymentPrivilege: String
    var deliverPrivilege: String
    var date : Date?
    var time : String
    var visitCount : Int
    var schedualOrNot : String
    var orderByVal : Date?
    var ascDescVal : String
    var customerLatLong : String
    var address : String
    var schedualLatLong : String
    var alongWithUser : String
    var leadStatus : String
    var remarks : String
    var customerName : String
    var schedualDate : Date?
    var schedualTime : String
    var cancelledDate : Date?
    var cancelledTime : String
    var cancelReason : String
    var image : String
    var email : String
    var phone: String
    var custImage : String
    var visitContent : String
    
    var strDate : String{
        let strDate = Date.localDateString(from: date, format: "yyyy-MM-dd")
        return strDate
    }
    var strTime : String{
        let inputFormat = DateFormatter()
        inputFormat.dateFormat = "hh:mm"
        let showDate = inputFormat.date(from: time)
        let resultString = inputFormat.string(from: showDate!)
        return resultString
    }
    
    var orderByValStr : String{
        return strDate + strTime
    }
    
    var schedualDateStr : String{
        let str = Date.localDateString(from: schedualDate, format: "yyyy-MM-dd")
        return str
    }
    
    var schedualTimeStr : String{
        let inputFormat = DateFormatter()
        inputFormat.dateFormat = "hh:mm"
        let showDate = inputFormat.date(from: schedualTime)
        let resultString = inputFormat.string(from: showDate!)
        return resultString
    }
    
    var cancelledDateStr : String{
        let str = Date.localDateString(from: schedualDate, format: "yyyy-MM-dd")
        return str
    }
    
    var cancelledTimeStr : String{
        let inputFormat = DateFormatter()
        inputFormat.dateFormat = "hh:mm"
        let showDate = inputFormat.date(from: cancelledTime)
        let resultString = inputFormat.string(from: showDate!)
        return resultString
    }
    
    var imgUrl : URL?{
        return URL(string: image)
    }
    
    var custImgUrl: URL?{
        return URL(string: custImage)
    }
    
    init(dict: NSDictionary) {
        id = dict.getStringValue(key: "id")
        recordingurl = dict.getStringValue(key: "recording_url")
        assignBy = dict.getStringValue(key: "assigned_by")
        customerId = dict.getStringValue(key: "customer_id")
        statusType = dict.getStringValue(key: "status_type")
        copanyName = dict.getStringValue(key: "company_name")
        fullName = dict.getStringValue(key: "full_name")
        firstName = dict.getStringValue(key: "first_name")
        lastName = dict.getStringValue(key: "last_name")
        visitCount = dict.getIntValue(key: "visit_stat")
        leadStatus = dict.getStringValue(key: "lead_status_id")
        orderPrivilege = dict.getStringValue(key: "order_privilege")
        paymentPrivilege = dict.getStringValue(key: "payment_privilege")
        deliverPrivilege = dict.getStringValue(key: "delivery_privilege")
        date = Date.dateFormServerDiffFormat(from: dict.getStringValue(key: "date"))
        time = dict.getStringValue(key: "time")
        visitState = dict.getStringValue(key: "visit_status")
        schedualOrNot = dict.getStringValue(key: "schuled_or_not")
        orderByVal = Date.dateFromServerFormat(from: dict.getStringValue(key: "order_by_val"))
        ascDescVal = dict.getStringValue(key: "asc_desc_val")
        customerLatLong = dict.getStringValue(key: "customer_lat_lng")
        address = dict.getStringValue(key: "address")
        schedualLatLong = dict.getStringValue(key: "schedule_lat_lng")
        alongWithUser = dict.getStringValue(key: "along_with_users")
        leadStatus = dict.getStringValue(key: "lead_status")
        remarks = dict.getStringValue(key: "remarks")
        customerName = dict.getStringValue(key: "customer_name")
        schedualDate = Date.dateFormServerDiffFormat(from: dict.getStringValue(key: "schedule_date"))
        schedualTime = dict.getStringValue(key: "schedule_time")
        cancelledDate = Date.dateFormServerDiffFormat(from: dict.getStringValue(key: "cancelled_date"))
        cancelledTime = dict.getStringValue(key: "cancelled_time")
        cancelReason = dict.getStringValue(key: "cancel_reason")
        image = dict.getStringValue(key: "image")
        email = dict.getStringValue(key: "email")
        phone = dict.getStringValue(key: "phone")
        leadStatusId = dict.getStringValue(key: "lead_status_id")
        custImage = dict.getStringValue(key: "cust_image")
        visitContent = dict.getStringValue(key: "visit_content")
    }
}

class GetUserList{
    var id : String
    var userId: String
    var firstName : String
    var lastName : String
    var levelId : String
    var userName : String
    
    
    init(dict: NSDictionary) {
        id = dict.getStringValue(key: "id")
        userId = dict.getStringValue(key: "user_id")
        firstName = dict.getStringValue(key: "first_name")
        lastName = dict.getStringValue(key: "last_name")
        levelId = dict.getStringValue(key: "level_id")
        userName = dict.getStringValue(key: "user_name")
    }
}



class MenuList{
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
