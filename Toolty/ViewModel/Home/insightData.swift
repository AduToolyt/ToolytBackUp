//
//  insightData.swift
//  Toolty
//
//  Created by Suraj on 22/07/21.
//

import Foundation
class insightData: NSObject{
     var objHome : insightModel!
    var typeID = "0"
    var objrev : RevenuchartModel!
    var objopp: opportinyModel!
    var id = ""
    func paramDict() -> [String : Any]{
        var dict : [String: Any] = [:]
        dict["company_id"] = _user.companyId
        dict["user_id"] = id
        dict["team_lead_id"] = _user.id
        dict["type"] = typeID
        return dict
    }
    
        func revenuDict() -> [String : Any]{
            var dict : [String: Any] = [:]
            dict["company_id"] = _user.companyId
            dict["user_id"] = id
            dict["team_lead_id"] = _user.id
            return dict
        }
    func oppDict() -> [String : Any]{
        var dict : [String: Any] = [:]
        dict["company_id"] = _user.companyId
        dict["user_id"] = id
        dict["team_lead_id"] = _user.id
        return dict
    }
}


extension insightData{
    func getinsight(completion : @escaping (ResponseType, insightModel?) -> ()){
        KPWebCall.call.homeInsightData(param: paramDict()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                DispatchQueue.main.async {
                    weakSelf.objHome = insightModel(dict: dict)
                    completion(.success,weakSelf.objHome)
                }
                
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error,nil)
            }
        }
    }
    
    func getRevenu(completion : @escaping (ResponseType, RevenuchartModel?) -> ()){
        KPWebCall.call.homeRevenuData(param: paramDict()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                DispatchQueue.main.async {
                    weakSelf.objrev = RevenuchartModel(dict: dict)
                    completion(.success,weakSelf.objrev)
                }
                
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error,nil)
            }
        }
    }

    func getOpportunityGraph(completion : @escaping (ResponseType, opportinyModel?) -> ()){
        KPWebCall.call.homeopportunityData(param: oppDict()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                DispatchQueue.main.async {
                    weakSelf.objopp = opportinyModel(dict: dict)
                    completion(.success,weakSelf.objopp)
                }
                
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error,nil)
            }
        }
    }
    
}
