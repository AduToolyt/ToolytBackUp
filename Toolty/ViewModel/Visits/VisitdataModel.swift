//
//  VisitdataModel.swift
//  Toolty
//
//  Created by Suraj on 19/07/21.
//

import Foundation
import UIKit

class VisitdataModel:NSObject{
    var date = "" //yyyy-MM-dd
    var objvisit : visitModle!
    var cusLead:customersName!
    var visitStatus = ""
    var userID = ""
    var custleadId = ""
    var timeZoneOffset : String{
        let timeZone = TimeZone.current.secondsFromGMT()
        return "\(timeZone)"
    }
    
    func VisitparamDict() -> [String : Any]{
        var dict : [String: Any] = [:]
        dict["company_id"] = _user.companyId
        dict["team_lead_id"] = _user.id
        dict["user_id"] = userID
        dict["api_call_status"] = "2"
        dict["filter_date"] = date
        dict["visit_status_id"] = visitStatus
        dict["customer_id"] = custleadId
        dict["user_timezone_app_offset"] = timeZoneOffset
        dict["page_number"] = "0"
        return dict
    }
    
    func leadcustDict()->[String:Any]{
        var dict : [String: Any] = [:]
        dict["company_id"] = _user.companyId
        dict["team_lead_id"] = _user.id
        dict["user_id"] = _user.id
        dict["lead_type"] = "0"
        dict["page_number"] = "0"
        return dict
    }
}

extension VisitdataModel{
    func getVisitOverview(completion : @escaping (ResponseType, visitModle?) -> ()){
        KPWebCall.call.ViewOverviewData(param: VisitparamDict()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                if let responseDic = dict["visitStatusFilterArray"] as? [NSDictionary]{
                    print(responseDic)
//                    for i in responseDic{
//                        _VisitStatusFilter = VisitStatusFilter.addUpdateEntity(key: i.getStringValue(key: "label"), value: "label")
//                            _appDelegator.saveContext()
//                    }
                    
                }
                weakSelf.objvisit = visitModle(dict: dict)
                completion(.success,weakSelf.objvisit)
                
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error,nil)
            }
        }
    }
    
    func getcustLead(completion : @escaping (ResponseType, customersName?) -> ()){
        KPWebCall.call.getallcustomers(param: leadcustDict()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                weakSelf.cusLead = customersName(dict: dict)
                completion(.success,weakSelf.cusLead)
                if let responseDict = dict["customers"] as? [NSDictionary] {
                    print(responseDict.count)
                    for dictData in responseDict {
                        print(dictData)
                        _custLead = CustLeadLists.addUpdateEntity(key: "customer_id", value: dictData.getStringValue(key: "customer_id"))
                        _custLead.initWith(dict: dictData)
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
