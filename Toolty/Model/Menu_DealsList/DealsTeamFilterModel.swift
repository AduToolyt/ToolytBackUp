//
//  DealsTeamFilterModel.swift
//  Toolty
//
//  Created by Nizamudheen on 07/08/21.
//

import Foundation

class DealsTeamFilterModel{
    var status : Int
    var message : String
    var teams : [TeamFilter] = []
    var userFilter : [UserFilterData] = [] //[userList]
    
    init(dict: NSDictionary) {
        status = dict.getIntValue(key: "status")
        message = dict.getStringValue(key: "message")
        
        if let dictPending = dict["teams"] as? [NSDictionary]{
            for dictData in dictPending{
                let objData = TeamFilter(dict: dictData)
                self.teams.append(objData)
            }
        }
        if let dictPending = dict["userList"] as? [NSDictionary]{
            for dictData in dictPending{
                let objData = UserFilterData(dict: dictData)
                self.userFilter.append(objData)
            }
        }
                
    }
}


class TeamFilter{
    var id : Int
    var team_name : String
    
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        team_name = dict.getStringValue(key: "team_name")
    }
}

class UserFilterData{
    var id : Int
    var first_name : String
    var level_id : Int
    var user_name : String
    var user_id : Int
    var last_name : String
    
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        first_name = dict.getStringValue(key: "first_name")
        level_id = dict.getIntValue(key: "level_id")
        user_name = dict.getStringValue(key: "user_name")
        user_id = dict.getIntValue(key: "user_id")
        last_name = dict.getStringValue(key: "last_name")
    }
    
}


class DealsListModel{
    var status : Int
    var stageStatus : Int
    var totalOpportunityCount : Int
    var orderValueStatus : Int
    var closeDateStatus : Int
    var opportunityCount : Int
    var userFilter : [UserFilterData] = []
    var viewUserTeams : [TeamFilter] = []
    var statusFilterArray : [StatusFilterArray] = []
    var oppurtunitySatges : [StatusFilterArray] = []
    var viewUserZones : [ViewUserZoneRegion] = []
    var viewUserRegions : [ViewUserZoneRegion] = []
    var filterLabels : FilterLabels
    var opportunities : [DealsOpportunities] = []
    
    
    init(dict: NSDictionary) {
        status = dict.getIntValue(key: "status")
        stageStatus = dict.getIntValue(key: "stageStatus")
        totalOpportunityCount = dict.getIntValue(key: "totalOpportunityCount")
        orderValueStatus = dict.getIntValue(key: "orderValueStatus")
        closeDateStatus = dict.getIntValue(key: "closeDateStatus")
        opportunityCount = dict.getIntValue(key: "opportunityCount")
        
        if let dictPending = dict["userList"] as? [NSDictionary]{
            for dictData in dictPending{
                let objData = UserFilterData(dict: dictData)
                self.userFilter.append(objData)
            }
        }
        
        if let dictPending = dict["viewUserTeams"] as? [NSDictionary]{
            for dictData in dictPending{
                let objData = TeamFilter(dict: dictData)
                self.viewUserTeams.append(objData)
            }
        }
        
        if let dictPending = dict["statusFilterArray"] as? [NSDictionary]{
            for dictData in dictPending{
                let objData = StatusFilterArray(dict: dictData)
                self.statusFilterArray.append(objData)
            }
        }
        
        if let dictPending = dict["oppurtunitySatges"] as? [NSDictionary]{
            for dictData in dictPending{
                let objData = StatusFilterArray(dict: dictData)
                self.oppurtunitySatges.append(objData)
            }
        }
        
        if let dictPending = dict["viewUserZones"] as? [NSDictionary]{
            for dictData in dictPending{
                let objData = ViewUserZoneRegion(dict: dictData)
                self.viewUserZones.append(objData)
            }
        }
        if let dictPending = dict["viewUserRegions"] as? [NSDictionary]{
            for dictData in dictPending{
                let objData = ViewUserZoneRegion(dict: dictData)
                self.viewUserRegions.append(objData)
            }
        }
        
        filterLabels = FilterLabels(dict: dict["filterLabels"] as! NSDictionary)

        if let dictPending = dict["opportunities"] as? [NSDictionary]{
            for dictData in dictPending{
                let objData = DealsOpportunities(dict: dictData)
                self.opportunities.append(objData)
            }
        }
    }
}

class FilterLabels{
    var global_region_label : String
    var team_label : String
    var zone_label : String
    var region_label : String
    var user_label : String
    
    
    init(dict: NSDictionary) {
        global_region_label = dict.getStringValue(key: "global_region_label")
        team_label = dict.getStringValue(key: "team_label")
        zone_label = dict.getStringValue(key: "zone_label")
        region_label = dict.getStringValue(key: "region_label")
        user_label = dict.getStringValue(key: "user_label")
    }
}

class StatusFilterArray{
    var id : Int
    var status_label : String
    var oppurtunity_stage : String
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        status_label = dict.getStringValue(key: "label")
        oppurtunity_stage = dict.getStringValue(key: "oppurtunity_stage")
    }
}

class ViewUserZoneRegion{
    var id : Int
    var team_id : Int
    var zone_id : Int
    var zone_name : String
    var region_name : String
    
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        team_id = dict.getIntValue(key: "team_id")
        zone_id = dict.getIntValue(key: "zone_id")
        zone_name = dict.getStringValue(key: "zone_name")
        region_name = dict.getStringValue(key: "region_name")
    }
}

class DealsOpportunities{
    var id : Int
    var customer_id : Int
    var reference_id : String
    var oppurtunity_name : String
    var full_name : String
    var estimated_order_date : String
    var estimated_order_value : String
    var status : String
    var currency_symbol : String
    var lost_won_date : String
    var stage_percent : String
    var estimated_order_value_new : String
    
    init(dict: NSDictionary) {
        
        id = dict.getIntValue(key: "id")
        customer_id = dict.getIntValue(key: "customer_id")
        reference_id = dict.getStringValue(key: "reference_id")
        oppurtunity_name = dict.getStringValue(key: "oppurtunity_name")
        full_name = dict.getStringValue(key: "full_name")
        estimated_order_date = dict.getStringValue(key: "estimated_order_date")
        estimated_order_value = dict.getStringValue(key: "estimated_order_value")
        status = dict.getStringValue(key: "status")
        currency_symbol = dict.getStringValue(key: "currency_symbol")
        lost_won_date = dict.getStringValue(key: "lost_won_date")
        stage_percent = dict.getStringValue(key: "stage_percent")
        estimated_order_value_new = dict.getStringValue(key: "estimated_order_value_new")
    }
}

/*
 {
 "opportunities"[{
 "customer_id":2054358,
 "id":144847,
 "reference_id":"11",
 "oppurtunity_name":"Auto loan",
 "full_name":"Raja(IT professional)",
 "estimated_order_date":"2021-03-31",
 "estimated_order_value":10000000,
 "status":"Sanction",
 "currency_symbol":"&#x20B9;",
 "lost_won_date":"",
 "stage_percent":"50",
 "estimated_order_value_new":"10,000,000.00"}],
 
 
 
 
 "status":1,
 "closeDateStatus":1,
 "orderValueStatus":1,
 "stageStatus":1,
 "totalOpportunityCount":5,
 "opportunityCount":5,
 "userList":[{"id":6598,"user_id":6598,"first_name":"RAKESH","last_name":"","level_id":1016,"user_name":"RAKESH "}],
 "viewUserTeams":[{"id":237,"team_name":"J-2"}],
 "statusFilterArray":[{"id":1,"label":"All In Progress"}],
 "oppurtunitySatges":[{"id":464,"oppurtunity_stage":"Created "}],
 "viewUserZones":[{"id" : 8,"team_id" : 6,"zone_name" : "South"}],
 "viewUserRegions":[{"id" : 3,"region_name" : "Region 1","zone_id" : 8}]
 "filterLabels":{"global_region_label":"Global Region","team_label":"Team","zone_label":"Zone","region_label":"Region","user_label":"Users"},
 }
 */
