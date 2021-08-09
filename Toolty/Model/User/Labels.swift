//
//  Labels.swift
//  Toolty
//
//  Created by Chirag Patel on 13/07/21.
//

import Foundation
import CoreData

class LabelData : NSManagedObject,ParentManagedObject{
    @NSManaged var id : String
    @NSManaged var modualStatus : String
    @NSManaged var moduleName : String
    @NSManaged var values : NSArray
    
    
    func initWith(dict: NSDictionary){
        id = dict.getStringValue(key: "id")
        modualStatus = dict.getStringValue(key: "module_status")
        moduleName = dict.getStringValue(key: "module_name")
    }
}

