//
//  VisitStatusFilter.swift
//  Toolty
//
//  Created by Suraj on 30/07/21.
//

import Foundation
import CoreData

class VisitStatusFilter : NSManagedObject, ParentManagedObject{
    @NSManaged var id : String
    @NSManaged var label: String
    
    
    func initWith(dict: NSDictionary){
        id = dict.getStringValue(key: "id")
        label = dict.getStringValue(key: "label")
    }
}
