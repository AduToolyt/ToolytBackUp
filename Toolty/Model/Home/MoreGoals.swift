//
//  MoreGoals.swift
//  Toolty
//
//  Created by Suraj on 27/07/21.
//

import Foundation


class MoreGoals:NSObject{
   
        var status,userGoalID, totalModulesCount: Int
        var goalImage, goalName: String
        var modules: [goalmodels] = []
        
        init(dict: NSDictionary) {
            status = dict.getIntValue(key: "status")
            userGoalID = dict.getIntValue(key: "userGoalId")
            totalModulesCount = dict.getIntValue(key: "totalModulesCount")
            goalImage = dict.getStringValue(key: "goalImage")
            goalName = dict.getStringValue(key: "goalName")
            if let upcomingDict = dict["modules"] as? [NSDictionary]{
                for dict in upcomingDict{
                    let objData = goalmodels(dict: dict)
                    self.modules.append(objData)
                }
            }

        }
}


class goalmodels:NSObject{
    var primKey, moduleType, moduleID,subGoalTaget, goalPeriodicity,tagetAchieved: Int
        var moduleName,periodicityName,completionPercentage: String
    init(dict: NSDictionary) {
        primKey = dict.getIntValue(key: "prim_key")
        moduleType = dict.getIntValue(key: "module_type")
        moduleID = dict.getIntValue(key: "module_id")
        subGoalTaget = dict.getIntValue(key: "sub_goal_taget")
        goalPeriodicity = dict.getIntValue(key: "goal_periodicity")
        tagetAchieved = dict.getIntValue(key: "taget_achieved")
        moduleName = dict.getStringValue(key: "module_name")
        periodicityName = dict.getStringValue(key: "periodicityName")
        completionPercentage = dict.getStringValue(key: "completion_percentage")
    }
}
