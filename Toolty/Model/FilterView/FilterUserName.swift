//
//  FilterUserName.swift
//  Toolty
//
//  Created by Suraj on 15/07/21.
//

import Foundation
import CoreData


class FilterUserName: NSManagedObject, ParentManagedObject {

    @NSManaged var user_name: String

    func initWith(dict: NSDictionary) {

        user_name = dict.getStringValue(key: "user_name")
    }
    
}
