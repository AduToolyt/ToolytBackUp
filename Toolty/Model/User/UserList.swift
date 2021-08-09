//
//  UserList.swift
//  Toolty
//
//  Created by Chirag Patel on 16/07/21.
//

import UIKit
import CoreData

class UserList: NSManagedObject,ParentManagedObject {
    @NSManaged var id: String
    @NSManaged var first_name: String
    @NSManaged var last_name: String
    @NSManaged var level_id : String
    @NSManaged var user_id : String
    @NSManaged var user_name : String
    @NSManaged var values : NSArray
    

    func initWith(dict: NSDictionary) {
        id = dict.getStringValue(key: "id")
        first_name = dict.getStringValue(key: "first_name")
        last_name = dict.getStringValue(key: "last_name")
        level_id = dict.getStringValue(key: "level_id")
        user_id = dict.getStringValue(key: "user_id")
        user_name = dict.getStringValue(key: "user_name")
    }
}
