//
//  FeedModel.swift
//  Toolty
//
//  Created by Suraj on 07/08/21.
//

import Foundation

// MARK: - FeedModel
class FeedModel:NSObject{
    var status: String
        var viewUsers: [ViewUserTeamViewUser] = []
        var activity: [ViewUserTeamActivity] = []
        var totalCount, skipCount: Int
    
    init(dict: NSDictionary) {
        status = dict.getStringValue(key: "status")
        if let user = dict["viewUsers"] as? [NSDictionary]{
            for dictData in user{
                let objdata = ViewUserTeamViewUser(dict: dictData)
                self.viewUsers.append(objdata)
            }
        }
        if let acti = dict["activity"] as? [NSDictionary]{
            for dictData in acti{
                let objdata = ViewUserTeamActivity(dict: dictData)
                self.activity.append(objdata)
            }
        }
        totalCount = dict.getIntValue(key: "totalCount")
        skipCount = dict.getIntValue(key: "skipCount")
    }
}
// MARK: - ViewUserTeamActivity
class ViewUserTeamActivity: NSObject {
    var activityContent, createdAt, timeLine,createdPerson: String
    var type: Int
    
    init(dict: NSDictionary) {
        activityContent = dict.getStringValue(key: "activity_content")
        createdAt = dict.getStringValue(key: "created_at")
        timeLine = dict.getStringValue(key: "time_line")
        createdPerson = dict.getStringValue(key: "created_person")
        type = dict.getIntValue(key: "type")
    }
}
