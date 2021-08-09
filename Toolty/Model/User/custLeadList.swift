//
//  custLeadList.swift
//  Toolty
//
//  Created by Suraj on 20/07/21.
//

import Foundation
import CoreData

class CustLeadLists: NSManagedObject, ParentManagedObject {
    
    @NSManaged var customer_id: String
    @NSManaged var company_name: String
    @NSManaged var full_name: String
    @NSManaged var assigned_to_id : String
    @NSManaged var status_type : String
    @NSManaged var lead_status_id : String
    @NSManaged var customer_name: String
    @NSManaged var order_assigned_to_id: String
    @NSManaged var payment_assigned_to_id: String
    @NSManaged var delivery_assigned_to_id : String
    @NSManaged var payment_privilege  : String
    @NSManaged var delivery_privilege : String
    
    func initWith(dict: NSDictionary) {
        customer_id = dict.getStringValue(key: "customer_id")
        company_name = dict.getStringValue(key: "company_name")
        full_name = dict.getStringValue(key: "full_name")
        assigned_to_id = dict.getStringValue(key: "assigned_to_id")
        status_type = dict.getStringValue(key: "status_type")
        lead_status_id = dict.getStringValue(key: "lead_status_id")
        customer_name = dict.getStringValue(key: "customer_name")
        order_assigned_to_id = dict.getStringValue(key: "order_assigned_to_id")
        payment_assigned_to_id = dict.getStringValue(key: "payment_assigned_to_id")
        delivery_assigned_to_id = dict.getStringValue(key: "delivery_assigned_to_id")
        payment_privilege = dict.getStringValue(key: "payment_privilege")
        delivery_privilege = dict.getStringValue(key: "delivery_privilege")
    }
}

