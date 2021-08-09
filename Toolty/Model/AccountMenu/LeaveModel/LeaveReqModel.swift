//
//  LeaveReqModel.swift
//  Toolty
//
//  Created by Suraj on 06/08/21.
//

import Foundation

class LeaveReqModel:NSObject{
    var status: String
    var totalCount: Int
    var leaveRequests: [ViewUserTeamLeaveApplied] = []
    var viewUser: [ViewUserTeamViewUser] = []
    
    init(dict: NSDictionary) {
        status = dict.getStringValue(key: "status")
        totalCount = dict.getIntValue(key: "totalCount")
        if let user = dict["viewUsers"] as? [NSDictionary]{
            for dictData in user{
                let objdata = ViewUserTeamViewUser(dict: dictData)
                self.viewUser.append(objdata)
            }
        }
        if let leaveapply = dict["leaveRequests"] as? [NSDictionary]{
            for dictData in leaveapply{
                let objdata = ViewUserTeamLeaveApplied(dict: dictData)
                self.leaveRequests.append(objdata)
            }
        }
    }
}

