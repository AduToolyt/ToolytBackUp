//
//  GoalModel.swift
//  Toolty
//
//  Created by Suraj on 23/07/21.
//

import Foundation
struct filterDataGoals {
    var str:String?
    var val:Int?
}
var arr = [filterDataGoals]()
class GoalModel:NSObject{
    var status, activeGoalStatus: Int
        var activeData: ActiveData?
        
    init(dict: NSDictionary) {
        status = dict.getIntValue(key: "status")
        activeGoalStatus = dict.getIntValue(key: "activeGoalStatus")
        if let filterDict = dict["activeData"] as? NSDictionary{
         self.activeData = ActiveData(dict: filterDict)
    }
}
}
    class ActiveData:NSObject{
        var goalImage, goalName: String
            var userGoalID,totalEarnedAmount, totalModulesCount, totalGoalTargetAmount, targetDuration,goalProgressPercentage: Int
            var amountPerMonth: Double
            
            var dataFilter: DataFilter?
            var modules: [modul] = []
        
        init(dict: NSDictionary) {
            goalImage = dict.getStringValue(key: "goalImage")
            goalName = dict.getStringValue(key: "goalName")
            goalProgressPercentage = dict.getIntValue(key: "goalProgressPercentage")
            userGoalID = dict.getIntValue(key: "userGoalId")
            totalEarnedAmount = dict.getIntValue(key: "totalEarnedAmount")
            totalModulesCount = dict.getIntValue(key: "totalModulesCount")
            totalGoalTargetAmount = dict.getIntValue(key: "totalGoalTargetAmount")
            targetDuration = dict.getIntValue(key: "targetDuration")
            amountPerMonth = dict.getDoubleValue(key: "amountPerMonth")
            if let filterDict = dict["data_filter"] as? NSDictionary{
             self.dataFilter = DataFilter(dict: filterDict)
                
                for (key,val) in filterDict{
                    let values = filterDataGoals(str: key as! String, val: val as! Int)
                    arr.append(values)
                }
                
        }
            if let upcomingDict = dict["modules"] as? [NSDictionary]{
                for dict in upcomingDict{
                    let objData = modul(dict: dict)
                    self.modules.append(objData)
                }
            }
        }
    }


class DataFilter:NSObject{
    var today, week, month, all: Int
    init(dict: NSDictionary) {
        today = dict.getIntValue(key: "Today")
        week = dict.getIntValue(key: "Week")
        month = dict.getIntValue(key: "Month")
        all = dict.getIntValue(key: "All")
    }
}


class modul:NSObject{
    var primKey, moduleType, moduleID,subGoalTaget,tagetAchieved, goalPeriodicity: Int
        var moduleName,periodicityName,completionPercentage: String
    init(dict: NSDictionary) {
        primKey = dict.getIntValue(key: "prim_key")
        moduleType = dict.getIntValue(key: "module_type")
        moduleID = dict.getIntValue(key: "module_id")
        subGoalTaget = dict.getIntValue(key: "sub_goal_taget")
        tagetAchieved = dict.getIntValue(key: "taget_achieved")
        goalPeriodicity = dict.getIntValue(key: "goal_periodicity")
        
        moduleName = dict.getStringValue(key: "module_name")
        periodicityName = dict.getStringValue(key: "periodicityName")
        completionPercentage = dict.getStringValue(key: "completion_percentage")
    }
}
