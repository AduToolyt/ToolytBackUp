//
//  LeaveData.swift
//  Toolty
//
//  Created by Suraj on 06/08/21.
//

import Foundation
class LeaveData:NSObject{
    var objLeavList : LeaveModel!
    var objLeaveReq:LeaveReqModel!
    
    var user = ""
    var pageNo = ""
    
    func LeaveListPara()->[String:Any]{
        var dict : [String: Any] = [:]
        dict["company_id"] = _user.companyId
        dict["team_lead_id"] = _user.id
        dict["user_id"] = user
        dict["page_number"] = pageNo
        return dict
    }
    func LeaveReqPara()->[String:Any]{
        var dict : [String: Any] = [:]
        dict["company_id"] = _user.companyId
        dict["user_id"] = _user.id
        dict["page_number"] = pageNo
        return dict
    }
}

extension LeaveData{
    func getLeaveList(completion : @escaping (ResponseType, LeaveModel?) -> ()){
        KPWebCall.call.MenuLeaveList(param: LeaveListPara()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                print(dict)
                weakSelf.objLeavList = LeaveModel(dict: dict)
                completion(.success,weakSelf.objLeavList)
                if let Created = dict["viewUsers"] as? [NSDictionary]{
                    for i in Created{
                        print(i)
                        _LeadViewUserList = LeadViewUserList.addUpdateEntity(key: "id", value: i.getStringValue(key: "id"))
                        _LeadViewUserList.initWith(dict: i)
                        _appDelegator.saveContext()
                    }
                }
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error,nil)
            }
        }
    }
    
    func getLeaveReq(completion : @escaping (ResponseType, LeaveReqModel?) -> ()){
        KPWebCall.call.MenuLeaveReq(param: LeaveReqPara()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                print(dict)
                weakSelf.objLeaveReq = LeaveReqModel(dict: dict)
                completion(.success,weakSelf.objLeaveReq)
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error,nil)
            }
        }
    }
    
}

