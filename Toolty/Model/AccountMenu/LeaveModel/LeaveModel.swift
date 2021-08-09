//
//  LeaveModel.swift
//  Toolty
//
//  Created by Suraj on 06/08/21.
//

import Foundation
class LeaveModel:NSObject{
    var status: String
        var viewUser: [ViewUserTeamViewUser] = []
        var leavePolicies: [ViewUserTeamLeavePolicy] = []
        var totalCount: Int
        var leaveApplied: [ViewUserTeamLeaveApplied] = []
    
    init(dict: NSDictionary) {
        status = dict.getStringValue(key: "status")
        totalCount = dict.getIntValue(key: "totalCount")
        
        if let user = dict["viewUsers"] as? [NSDictionary]{
            for dictData in user{
                let objdata = ViewUserTeamViewUser(dict: dictData)
                self.viewUser.append(objdata)
            }
        }
        if let leaveapply = dict["leaveApplied"] as? [NSDictionary]{
            for dictData in leaveapply{
                let objdata = ViewUserTeamLeaveApplied(dict: dictData)
                self.leaveApplied.append(objdata)
            }
        }
        if let leavepolicy = dict["leavePolicies"] as? [NSDictionary]{
            for dictData in leavepolicy{
                let objdata = ViewUserTeamLeavePolicy(dict: dictData)
                self.leavePolicies.append(objdata)
            }
        }
    }
}
// MARK: - ViewUserTeamLeaveApplied
class ViewUserTeamLeaveApplied: NSObject {
    var id: Int
    var userName,masterLeavePolicy,leaveDateRange, daysLeaveTaken, leaveReason,userDesignation: String
    var approveRejectStatus: Int
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        userName = dict.getStringValue(key: "user_name")
        masterLeavePolicy = dict.getStringValue(key: "master_leave_policy")
        leaveDateRange = dict.getStringValue(key: "leave_date_range")
        daysLeaveTaken = dict.getStringValue(key: "days_leave_taken")
        leaveReason = dict.getStringValue(key: "leave_reason")
        userDesignation = dict.getStringValue(key: "user_designation")
        approveRejectStatus = dict.getIntValue(key: "approve_reject_status")
    }
}
// MARK: - ViewUserTeamLeavePolicy
class ViewUserTeamLeavePolicy: NSObject {
    var id: Int
    var masterLeavePolicy: String
    var leavesAllowance, leavesTaken, leavesPending: Int
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        masterLeavePolicy = dict.getStringValue(key: "master_leave_policy")
        leavesAllowance = dict.getIntValue(key: "leaves_allowance")
        leavesTaken = dict.getIntValue(key: "leaves_taken")
        leavesPending = dict.getIntValue(key: "leaves_pending")
    }
}
