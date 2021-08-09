//
//  OpporunityOption.swift
//  Toolty
//
//  Created by Chirag Patel on 13/07/21.
//

import Foundation
import CoreData

class OpporunityOption : NSManagedObject, ParentManagedObject{
    @NSManaged var leadCustomer : String
    @NSManaged var productMandatory: String
    @NSManaged var productPrice: String
    
    func initWith(dict: NSDictionary){
        leadCustomer = dict.getStringValue(key: "add_deal_for_lead_customer")
        productMandatory = dict.getStringValue(key: "product_mandatory")
        productPrice = dict.getStringValue(key: "product_price")
    }
}
