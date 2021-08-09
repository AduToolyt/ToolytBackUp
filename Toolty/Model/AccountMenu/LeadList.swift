//
//  LeadList.swift
//  Toolty
//
//  Created by Suraj on 31/07/21.
//

import Foundation
class LeadList :NSObject{
        var filterLabels: leadFilterLabel?
       var totalCount,callLogStatus,newsModuleStatus,sortByID: Int
       var viewUsers: [LeadviewUsers] = []
       var leadStatus: [LeadStatus] = []
       var leads: [Lead] = []
    var customers:[MenuCustomers] = []
       var leadSource: [LeadSource] = []
       var industries: [LeadIndustry] = []
       var viewUserTeams: [LeadViewUserTeam] = []
       var viewUserZones: [LeadViewUserZone] = []
       var viewUserRegions: [LeadViewUserRegion] = []
       var menus: [LeadMenu] = []
       
    init(dict: NSDictionary) {
        totalCount = dict.getIntValue(key: "totalCount")
        callLogStatus = dict.getIntValue(key: "callLogStatus")
        newsModuleStatus = dict.getIntValue(key: "newsModuleStatus")
        sortByID = dict.getIntValue(key: "sortById")
        
        if let filterDict = dict["filterLabels"] as? NSDictionary{
            self.filterLabels = leadFilterLabel(dict: filterDict)
        }
        if let dictVisit = dict["industries"] as? [NSDictionary]{
            for dictData in dictVisit{
                let objdata = LeadIndustry(dict: dictData)
                self.industries.append(objdata)
            }
        }
        if let dictVisit = dict["leadSource"] as? [NSDictionary]{
            for dictData in dictVisit{
                let objdata = LeadSource(dict: dictData)
                self.leadSource.append(objdata)
            }
        }
        if let dictVisit = dict["leadStatus"] as? [NSDictionary]{
            for dictData in dictVisit{
                let objdata = LeadStatus(dict: dictData)
                self.leadStatus.append(objdata)
            }
        }
        if let dictVisit = dict["leads"] as? [NSDictionary]{
            for dictData in dictVisit{
                let objdata = Lead(dict: dictData)
                self.leads.append(objdata)
            }
        }
        if let dictVisit = dict["customers"] as? [NSDictionary]{
            for dictData in dictVisit{
                let objdata = MenuCustomers(dict: dictData)
                self.customers.append(objdata)
            }
        }
        if let dictVisit = dict["viewUsers"] as? [NSDictionary]{
            for dictData in dictVisit{
                let objdata = LeadviewUsers(dict: dictData)
                self.viewUsers.append(objdata)
            }
        }
        if let dictVisit = dict["viewUserTeams"] as? [NSDictionary]{
            for dictData in dictVisit{
                let objdata = LeadViewUserTeam(dict: dictData)
                self.viewUserTeams.append(objdata)
            }
        }
        if let dictVisit = dict["viewUserZones"] as? [NSDictionary]{
            for dictData in dictVisit{
                let objdata = LeadViewUserZone(dict: dictData)
                self.viewUserZones.append(objdata)
            }
        }
        if let dictVisit = dict["menus"] as? [NSDictionary]{
            for dictData in dictVisit{
                let objdata = LeadMenu(dict: dictData)
                self.menus.append(objdata)
            }
        }
        if let dictVisit = dict["viewUserRegions"] as? [NSDictionary]{
            for dictData in dictVisit{
                let objdata = LeadViewUserRegion(dict: dictData)
                self.viewUserRegions.append(objdata)
            }
        }
    }
}

class leadFilterLabel:NSObject{
    var globalRegionLabel, teamLabel, zoneLabel, regionLabel,userLabel: String
    init(dict: NSDictionary) {
        globalRegionLabel = dict.getStringValue(key: "global_region_label")
        teamLabel = dict.getStringValue(key: "team_label")
        zoneLabel = dict.getStringValue(key: "zone_label")
        regionLabel = dict.getStringValue(key: "region_label")
        userLabel = dict.getStringValue(key: "user_label")
    }
}
class LeadIndustry:NSObject{
    var id: Int
    var industryName: String
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        industryName = dict.getStringValue(key: "industry_name")
    }
}
class LeadSource:NSObject{
    var id: Int
    var sourceName: String
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        sourceName = dict.getStringValue(key: "source_name")
    }
}
class LeadStatus: NSObject {
    var id, statusType: Int
    var leadStatus: String
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        statusType = dict.getIntValue(key: "status_type")
        leadStatus = dict.getStringValue(key: "lead_status")
    }}
class Lead: NSObject {
    var id, assignedToID, prospectType, customerID,leadStage, todayStatus,leadStatusID,leadClassification, taggedUserStatus: Int
    var createdAt, updatedAt, fullName, companyName,comments, nextActionDate,image, geneartedID,leadID,customerName,leadIDName: String
    var synced: Bool
    
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        assignedToID = dict.getIntValue(key: "assigned_to_id")
        prospectType = dict.getIntValue(key: "prospect_type")
        customerID = dict.getIntValue(key: "customer_id")
        leadStage = dict.getIntValue(key: "lead_stage")
        todayStatus = dict.getIntValue(key: "today_status")
        leadStatusID = dict.getIntValue(key: "lead_status_id")
        leadClassification = dict.getIntValue(key: "lead_classification")
        taggedUserStatus = dict.getIntValue(key: "tagged_user_status")
        
        createdAt = dict.getStringValue(key: "created_at")
        updatedAt = dict.getStringValue(key: "updated_at")
        fullName = dict.getStringValue(key: "full_name")
        companyName = dict.getStringValue(key: "company_name")
        comments = dict.getStringValue(key: "comments")
        nextActionDate = dict.getStringValue(key: "next_action_date")
        image = dict.getStringValue(key: "image")
        geneartedID = dict.getStringValue(key: "genearted_id")
        leadID = dict.getStringValue(key: "lead_id")
        customerName = dict.getStringValue(key: "customer_name")
        leadIDName = dict.getStringValue(key: "lead_id_name")
        synced = dict.getBooleanValue(key: "synced")
    }
}
class MenuCustomers: NSObject {
    var id, assignedToID, prospectType, customerID,leadStage, todayStatus,leadStatusID,leadClassification, taggedUserStatus: Int
    var createdAt, updatedAt, fullName, companyName,comments, nextActionDate,image, geneartedID,leadID,customerName,leadIDName: String
    var synced: Bool
    
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        assignedToID = dict.getIntValue(key: "assigned_to_id")
        prospectType = dict.getIntValue(key: "prospect_type")
        customerID = dict.getIntValue(key: "customer_id")
        leadStage = dict.getIntValue(key: "lead_stage")
        todayStatus = dict.getIntValue(key: "today_status")
        leadStatusID = dict.getIntValue(key: "lead_status_id")
        leadClassification = dict.getIntValue(key: "lead_classification")
        taggedUserStatus = dict.getIntValue(key: "tagged_user_status")
        
        createdAt = dict.getStringValue(key: "created_at")
        updatedAt = dict.getStringValue(key: "updated_at")
        fullName = dict.getStringValue(key: "full_name")
        companyName = dict.getStringValue(key: "company_name")
        comments = dict.getStringValue(key: "comments")
        nextActionDate = dict.getStringValue(key: "next_action_date")
        image = dict.getStringValue(key: "image")
        geneartedID = dict.getStringValue(key: "genearted_id")
        leadID = dict.getStringValue(key: "lead_id")
        customerName = dict.getStringValue(key: "customer_name")
        leadIDName = dict.getStringValue(key: "lead_id_name")
        synced = dict.getBooleanValue(key: "synced")
    }
}
class LeadviewUsers:NSObject{
    var id, userID: Int
       var firstName, lastName: String
       var levelID: Int
       var userName: String
    
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        userID = dict.getIntValue(key: "user_id")
        firstName = dict.getStringValue(key:"first_name")
        lastName = dict.getStringValue(key:"last_name")
        levelID = dict.getIntValue(key: "level_id")
        userName = dict.getStringValue(key:"user_name")
    }
}
class LeadViewUserTeam: NSObject {
    var id: Int
    var teamName: String
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        teamName = dict.getStringValue(key: "team_name")
    }
}
class LeadViewUserZone: NSObject {
    var id: Int
    var zoneName: String
    var teamID: Int
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        zoneName = dict.getStringValue(key: "zone_name")
        teamID = dict.getIntValue(key: "team_id")
    }
}
class LeadMenu: NSObject {
    var id: Int
    var menuName: String
    var link: String
    var showIn, appendUserID: Int
    var iconURL: String
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        menuName = dict.getStringValue(key: "menu_name")
        link = dict.getStringValue(key: "link")
        iconURL = dict.getStringValue(key: "icon_url")
        showIn = dict.getIntValue(key: "show_in")
        appendUserID = dict.getIntValue(key: "append_user_id")
    }
}
class LeadViewUserRegion: NSObject {
    var id: Int
    var regionName: String
    var zoneID: Int
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        regionName = dict.getStringValue(key: "region_name")
        zoneID = dict.getIntValue(key: "zone_id")
    }
}
