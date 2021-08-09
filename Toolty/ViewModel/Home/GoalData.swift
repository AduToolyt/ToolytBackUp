//
//  GoalData.swift
//  Toolty
//
//  Created by Suraj on 23/07/21.
//

import Foundation

class GoalData:NSObject{
var objHome : GoalModel!
    var objgoal:MoreGoals!
    var datafilter = ""
    
    func paramDict() -> [String : Any]{
        var dict : [String: Any] = [:]
        dict["data_filter"] = datafilter
        dict["goals_count"] = "3"
        dict["page_number"] = "1"
        return dict
    }
    func paramDictShowmore() -> [String : Any]{
        var dict : [String: Any] = [:]
        dict["data_filter"] = datafilter
        dict["goals_count"] = "10"
        dict["page_number"] = "1"
        return dict
    }
}

extension GoalData{
    func getGoalBoard(completion : @escaping (ResponseType, GoalModel?) -> ()){
        KPWebCall.call.homeGoalData(param: paramDict()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                DispatchQueue.main.async {
                    print(dict)
                    weakSelf.objHome = GoalModel(dict: dict)
                    completion(.success,weakSelf.objHome)
                }
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error,nil)
            }
        }
    }
    
    func getMoreGoalBoard(completion : @escaping (ResponseType, MoreGoals?) -> ()){
        KPWebCall.call.homeMoreGoalData(param: paramDictShowmore()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                DispatchQueue.main.async {
                    print(dict)
                    weakSelf.objgoal = MoreGoals(dict: dict)
                    completion(.success,weakSelf.objgoal)
                }
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error,nil)
            }
        }
    }

    
    
}
