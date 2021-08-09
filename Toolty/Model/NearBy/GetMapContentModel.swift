//
//  GetMapContentModel.swift
//  Toolty
//
//  Created by Suraj on 29/07/21.
//

import Foundation
class GetMapContentModel:NSObject{
    var customers: [mapContentCustomers] = []
    var leadStatus: [mapContentLeadStatus] = []
    var opportunityStages: [mapContentOpportunityStage] = []
    var visitModes: [mapContentVisitMode] = []
    var visitSubReason: [mapContentVisitSubReason] = []
    
    init(dict: NSDictionary) {
        if let dictVisitstatusfilter = dict["customers"] as? [NSDictionary]{
            for dictData in dictVisitstatusfilter{
                let objdata = mapContentCustomers(dict: dictData)
                self.customers.append(objdata)
            }
        }
        
        if let dictVisitstatusfilter = dict["leadStatus"] as? [NSDictionary]{
            for dictData in dictVisitstatusfilter{
                let objdata = mapContentLeadStatus(dict: dictData)
                self.leadStatus.append(objdata)
            }
        }
        
        if let dictVisitstatusfilter = dict["opportunityStages"] as? [NSDictionary]{
            for dictData in dictVisitstatusfilter{
                let objdata = mapContentOpportunityStage(dict: dictData)
                self.opportunityStages.append(objdata)
            }
        }
        if let dictVisitstatusfilter = dict["visitModes"] as? [NSDictionary]{
            for dictData in dictVisitstatusfilter{
                let objdata = mapContentVisitMode(dict: dictData)
                self.visitModes.append(objdata)
            }
        }
        if let dictVisitstatusfilter = dict["visitSubReason"] as? [NSDictionary]{
            for dictData in dictVisitstatusfilter{
                let objdata = mapContentVisitSubReason(dict: dictData)
                self.visitSubReason.append(objdata)
            }
        }
    }
}

class mapContentCustomers:NSObject{
        var id, customerID: Int
      var fullName, companyName, location: String
      
      var image, address, phone,status,todayStatus, email: String
      var distance: Double
//      var todaysVisits: [TodaysVisit]
        var opportunities: [mapContentOpportunity] = []
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        customerID = dict.getIntValue(key: "customer_id")
        status = dict.getStringValue(key: "status")
        todayStatus = dict.getStringValue(key: "today_status")
        fullName = dict.getStringValue(key: "full_name")
        companyName = dict.getStringValue(key: "company_name")
        location = dict.getStringValue(key: "location")
        image = dict.getStringValue(key: "image")
        address = dict.getStringValue(key: "address")
        phone = dict.getStringValue(key: "phone")
        email = dict.getStringValue(key: "email")
        distance = dict.getDoubleValue(key: "distance")
        
        if let dictVisitstatusfilter = dict["visitSubReason"] as? [NSDictionary]{
            for dictData in dictVisitstatusfilter{
                let objdata = mapContentOpportunity(dict: dictData)
                self.opportunities.append(objdata)
            }
        }
    }
}


class mapContentOpportunity:NSObject{
    var id, opportunityID, customerID,stageID, closeDateStatus, orderValueStatus, stageStatus: Int
       var fullName, oppurtunityName, estimatedOrderValue, estimatedOrderDate,currencySymbol,status: String
       
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        opportunityID = dict.getIntValue(key: "opportunity_id")
        customerID = dict.getIntValue(key: "customer_id")
        stageID = dict.getIntValue(key: "stage_id")
        closeDateStatus = dict.getIntValue(key: "closeDateStatus")
        orderValueStatus = dict.getIntValue(key: "orderValueStatus")
        stageStatus = dict.getIntValue(key: "stageStatus")
        
        fullName = dict.getStringValue(key: "full_name")
        oppurtunityName = dict.getStringValue(key: "oppurtunity_name")
        estimatedOrderValue = dict.getStringValue(key: "estimated_order_value")
        estimatedOrderDate = dict.getStringValue(key: "estimated_order_date")
        currencySymbol = dict.getStringValue(key: "currency_symbol")
        status = dict.getStringValue(key: "status")
    }
}


class mapContentLeadStatus:NSObject{
var id, statusType: Int
var leadStatus: String
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        statusType = dict.getIntValue(key: "status_type")
        leadStatus = dict.getStringValue(key: "lead_status")
    }
}


class mapContentOpportunityStage:NSObject{
    var id: Int
    var oppurtunityStage: String
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        oppurtunityStage = dict.getStringValue(key: "oppurtunity_stage")
    }
}



class mapContentVisitMode:NSObject{
    var id: Int
    var visitMode: String
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        visitMode = dict.getStringValue(key: "visit_mode")
    }
}


class mapContentVisitSubReason:NSObject{
    var id, visitReasonID: Int
        var visitSubReason: String
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        visitReasonID = dict.getIntValue(key: "visit_reason_id")
        visitSubReason = dict.getStringValue(key: "visit_sub_reason")
    }
}
