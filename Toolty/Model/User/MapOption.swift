//
//  MapOption.swift
//  Toolty
//
//  Created by Chirag Patel on 13/07/21.
//

import Foundation
import CoreData

class MapsOption : NSManagedObject, ParentManagedObject{
    @NSManaged var nearbyTypes : String
    
    func initWith(dict: NSDictionary){
        nearbyTypes = dict.getStringValue(key: "near_by_types")
    }
}
