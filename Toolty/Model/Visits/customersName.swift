//
//  customersName.swift
//  Toolty
//
//  Created by Suraj on 20/07/21.
//

import Foundation


class customersName:NSObject{
    
    var totalCount: Int
    var customers: [Customer] = []
    var viewUsers: [ViewUser] = []
    init(dict: NSDictionary) {
        totalCount = dict.getIntValue(key: "totalCount")
        if let dictVisitstatusfilter = dict["customers"] as? [NSDictionary]{
            for dictData in dictVisitstatusfilter{
                let objdata = Customer(dict: dictData)
                self.customers.append(objdata)
            }
        }
        if let dictVisitstatusfilter = dict["viewUsers"] as? [NSDictionary]{
            for dictData in dictVisitstatusfilter{
                let objdata = ViewUser(dict: dictData)
                self.viewUsers.append(objdata)
            }
        }
    }
}
class Customer: NSObject {
    var customerID: Int
    var companyName, fullName, location: String
    var assignedToID, statusType, leadStatusID: Int
    var customerName: String
    var orderAssignedToID, paymentAssignedToID, deliveryAssignedToID, paymentPrivilege: Int
    var deliveryPrivilege: Int
    
    init(dict: NSDictionary) {
        customerID = dict.getIntValue(key: "customer_id")
        companyName = dict.getStringValue(key: "company_name")
        fullName = dict.getStringValue(key: "full_name")
        location = dict.getStringValue(key: "location")
        assignedToID = dict.getIntValue(key: "assigned_to_id")
        statusType = dict.getIntValue(key: "status_type")
        leadStatusID = dict.getIntValue(key: "lead_status_id")
        customerName = dict.getStringValue(key: "customer_name")
        orderAssignedToID = dict.getIntValue(key: "order_assigned_to_id")
        paymentAssignedToID = dict.getIntValue(key: "payment_assigned_to_id")
        deliveryAssignedToID = dict.getIntValue(key: "delivery_assigned_to_id")
        paymentPrivilege = dict.getIntValue(key: "payment_privilege")
        deliveryPrivilege = dict.getIntValue(key: "delivery_privilege")
    }
}

class ViewUser: NSObject {
    var id, userID: Int
    var firstName, lastName, userName: String
    var levelID: Int
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        userID = dict.getIntValue(key: "user_id")
        firstName = dict.getStringValue(key: "first_name")
        lastName = dict.getStringValue(key: "last_name")
        userName = dict.getStringValue(key: "user_name")
        levelID = dict.getIntValue(key: "level_id")
    }
}
