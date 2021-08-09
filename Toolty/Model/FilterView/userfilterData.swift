//
//  userfilterData.swift
//  Toolty
//
//  Created by Suraj on 15/07/21.
//

import Foundation

protocol FilterValue : class{
//    func selectedFilterValue(id:String,name:String,isFilters:Bool)
    func getFiltervalue(Userinfo:[filterValuesStruct])
}

class UserFilter{
    var status: Int?
    var message: String?
    var userList : [Userlist] = []
    
    init(dict: NSDictionary) {
        status = dict.getIntValue(key: "status")
        message = dict.getStringValue(key: "message")
        
        if let dictPending = dict["userList"] as? [NSDictionary]{
            for dictData in dictPending{
                let objData = Userlist(dict: dictData)
                self.userList.append(objData)
            }
        }
}
    
class Userlist {
    var id, userID: Int?
    var firstName, lastName: String?
    var levelID: Int?
    var userName: String?
    
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        userID = dict.getIntValue(key: "user_id")
        lastName = dict.getStringValue(key: "last_name")
        firstName = dict.getStringValue(key: "first_name")
        levelID = dict.getIntValue(key: "level_id")
        userName = dict.getStringValue(key: "user_name")
    }
}
}
