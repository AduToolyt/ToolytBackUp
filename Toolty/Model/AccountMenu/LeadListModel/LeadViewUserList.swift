//
//  LeadViewUserList.swift
//  Toolty
//
//  Created by Suraj on 04/08/21.
//

import Foundation
import CoreData

//leadStatus -- progress
class LeadViewleadStatus: NSManagedObject, ParentManagedObject {
    @NSManaged var id:String
    @NSManaged var status_type:String
    @NSManaged var lead_status:String
    func initWith(dict: NSDictionary) {
        id = dict.getStringValue(key: "id")
        status_type = dict.getStringValue(key: "status_type")
        lead_status = dict.getStringValue(key: "lead_status")
    }
}


//leadSource -- Source
class LeadViewleadSource: NSManagedObject, ParentManagedObject {
    @NSManaged var id:String
    @NSManaged var source_name:String
    func initWith(dict: NSDictionary) {
        id = dict.getStringValue(key: "id")
        source_name = dict.getStringValue(key: "source_name")
    }
}

//industries -- industries
class LeadViewindustries: NSManagedObject, ParentManagedObject {
    @NSManaged var id:String
    @NSManaged var industry_name:String
    func initWith(dict: NSDictionary) {
        id = dict.getStringValue(key: "id")
        industry_name = dict.getStringValue(key: "industry_name")
    }
}

//viewUsers -- created by
class LeadViewUserList: NSManagedObject, ParentManagedObject {
    @NSManaged var id : String
    @NSManaged var user_id:String
    @NSManaged var first_name:String
    @NSManaged var last_name:String
    @NSManaged var level_id:String
    @NSManaged var user_name:String
    func initWith(dict: NSDictionary) {
        id = dict.getStringValue(key: "id")
        user_id = dict.getStringValue(key: "user_id")
        first_name = dict.getStringValue(key: "first_name")
        last_name = dict.getStringValue(key: "last_name")
        level_id = dict.getStringValue(key: "level_id")
        user_name = dict.getStringValue(key: "user_name")
    }
}


