//
//  LeadlistMenuData.swift
//  Toolty
//
//  Created by Suraj on 31/07/21.
//

import Foundation

class LeadlistMenuData:NSObject{
  
    var objList : LeadList!
//    var objcust:customersList!
    var industriesID = ""
    var searchWord = ""
    var statusType = ""
    var sortID = ""
    var user = ""
    var pageNo = ""
    
    func LeadListPara()->[String:Any]{
        var dict : [String: Any] = [:]
        dict["company_id"] = _user.companyId
        dict["team_lead_id"] = _user.id
        dict["user_id"] = user
        dict["industry_id"] = industriesID
        dict["_token"] = ""
        dict["page_number"] = pageNo
        dict["created_by_id"] = "0"
        dict["search_word"] = searchWord
        dict["status_type"] = statusType
        dict["take_all_users"] = "0"
        dict["sort_by_id"] = sortID
        dict["lead_status_id"] = "0"
        return dict
    }
}

extension LeadlistMenuData{
    func getLeadList(completion : @escaping (ResponseType, LeadList?) -> ()){
        KPWebCall.call.MenuLeadList(param: LeadListPara()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                print(dict)
                weakSelf.objList = LeadList(dict: dict)
                completion(.success,weakSelf.objList)
                
                if let Progress = dict["leadStatus"] as? [NSDictionary]{
                    for dictData in Progress{
                        print(dictData)
                        _LeadViewleadStatus = LeadViewleadStatus.addUpdateEntity(key: "id", value: dictData.getStringValue(key: "id"))
                        _LeadViewleadStatus.initWith(dict: dictData)
                        _appDelegator.saveContext()
                    }
                }
                if let Source = dict["leadSource"] as? [NSDictionary]{
                    for i in Source{
                        print(i)
                        _LeadViewleadSource = LeadViewleadSource.addUpdateEntity(key: "id", value: i.getStringValue(key: "id"))
                        _LeadViewleadSource.initWith(dict: i)
                        _appDelegator.saveContext()
                    }
                }
                if let Industries = dict["industries"] as? [NSDictionary]{
                    for i in Industries{
                        print(i)
                        _LeadViewindustries = LeadViewindustries.addUpdateEntity(key: "id", value: i.getStringValue(key: "id"))
                        _LeadViewindustries.initWith(dict: i)
                        _appDelegator.saveContext()
                    }
                }
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
    
    func getcustomersList(completion : @escaping (ResponseType, LeadList?) -> ()){
        KPWebCall.call.MenucustomersList(param: LeadListPara()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                print(dict)
                weakSelf.objList = LeadList(dict: dict)
                completion(.success,weakSelf.objList)
                if let Progress = dict["leadStatus"] as? [NSDictionary]{
                    for dictData in Progress{
                        print(dictData)
                        _LeadViewleadStatus = LeadViewleadStatus.addUpdateEntity(key: "id", value: dictData.getStringValue(key: "id"))
                        _LeadViewleadStatus.initWith(dict: dictData)
                        _appDelegator.saveContext()
                    }
                }
                if let Source = dict["leadSource"] as? [NSDictionary]{
                    for i in Source{
                        print(i)
                        _LeadViewleadSource = LeadViewleadSource.addUpdateEntity(key: "id", value: i.getStringValue(key: "id"))
                        _LeadViewleadSource.initWith(dict: i)
                        _appDelegator.saveContext()
                    }
                }
                if let Industries = dict["industries"] as? [NSDictionary]{
                    for i in Industries{
                        print(i)
                        _LeadViewindustries = LeadViewindustries.addUpdateEntity(key: "id", value: i.getStringValue(key: "id"))
                        _LeadViewindustries.initWith(dict: i)
                        _appDelegator.saveContext()
                    }
                }
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
}
