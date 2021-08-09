//
//  RechedualVisitData.swift
//  Toolty
//
//  Created by Chirag Patel on 26/07/21.
//

import UIKit

class RechedualVisitData: NSObject {
    var objVisitData : Visit!
    var arrAssignData : [Assign] = []
    var arrAssign : [AlongData] = []
    var arrAlongData : [AlongData] = []
    var arrNames : [String] = []
    var arrValueAlong : [String] = []
    var arrTimeSlots : [TimeSlots] = []
    var objValues : Values!
    var date = ""
    var isFromVC : Bool = false
    var strTimeStatus : String = ""
    var totalSlot : String = ""
    var address : String = ""
    var time : String = ""
    var assignId : String = ""
    var customerLead : String = ""
    var schedualNotes : String = ""
    var location : String = ""
    
    func paramAssignDict() -> [String : Any]{
        var dict : [String : Any] = [:]
        dict["user_id"] = _user.id
        dict["company_id"] = _user.companyId
        dict["team_lead_id"] = _user.id
        return dict
    }
    
    func paramTimeDict() -> [String : Any]{
        var dict : [String : Any] = [:]
        dict["date"] = date
        dict["customer_id"] = objVisitData.customerID
        dict["user_id"] = _user.id
        dict["ampm"] = isFromVC ? strTimeStatus : convertTimeFormat(time: dict["date"] as! String)
        dict["company_id"] = _user.companyId
        return dict
    }
    
    func paramDictAlong() -> [String : Any]{
        var dict : [String : Any] = [:]
        dict["user_id"] = _user.id
        dict["company_id"] = _user.companyId
        dict["team_lead_id"] = _user.id
        return dict
    }
    
    func paramCancelVisit() -> [String : Any]{
        var dict : [String : Any] = [:]
        dict["visit_id"] = objVisitData.id
        dict["company_id"] = _user.companyId
        dict["user_id"] = _user.id
        dict["cancel_reason"] = objVisitData.visitContent
        return dict
    }
    
    func paramSubmitVisitDict() -> [String : Any]{
        var dict : [String : Any] = [:]
        dict["company_id"] = _user.companyId
        dict["team_lead_id"] = _user.id
        dict["address"] = address
        dict["user_id"] = _user.id
        dict["time"] = time
        dict["no_of_slot_selected"] = totalSlot
        dict["assign_to"] = assignId
        dict["variable_0_122"] = ""
        dict["customer_lead"] = customerLead
        dict["schedule_note"] = schedualNotes
        dict["customer_location_status"] = ""
        dict["location"] = location
        dict["user_timezone_app_offset"] = timeZoneOffset
        dict["date"] = date
        return dict
    }  
}


//MARK:- Reschedual API WEB Call METHODS
extension RechedualVisitData{
    func getAssignData(completion : @escaping ((ResponseType,[AlongData],[Assign]) -> ())){
        KPWebCall.call.getAssignData(param: paramAssignDict()) {[weak self] (json, statusCode) in
            guard let dictData = json as? NSDictionary, let weakSelf = self else {return}
            if statusCode == 200, let result = dictData["viewFormLabelOrder"] as? [NSDictionary]{
                for data in result{
                    let objData = Assign(dict: data)
                    let valueData = Values(name: objData.value, id: objData.value_id, manageId: objData.manage_form_id, varName: objData.variable_name)
                    for (index, _) in valueData.arrValueStr.enumerated() {
                        let objData = AlongData(name: valueData.arrNameStr[index], id: valueData.arrValueStr[index])
                        objData.variableName = valueData.variableName
                        weakSelf.arrAssign.append(objData)
                    }
                    weakSelf.arrAssignData.append(objData)
                }
                completion(.success,weakSelf.arrAssign,weakSelf.arrAssignData)
            }else{
                completion(.error, [], [])
            }
        }
    }
    
    func getTimeSlots(completion : @escaping ((ResponseType,[TimeSlots]) -> ())){
        KPWebCall.call.getAllTimeSlots(param: paramTimeDict()) {[weak self] (json, statusCode) in
            guard let dictData = json as? NSDictionary, let weakSelf = self else {return}
            if statusCode == 200, let result = dictData["timeSlots"] as? [NSDictionary]{
                weakSelf.arrTimeSlots = []
                for data in result{
                    let objData = TimeSlots(dict: data)
                    weakSelf.arrTimeSlots.append(objData)
                }
                completion(.success,weakSelf.arrTimeSlots)
            }else{
                completion(.error,[])
            }
        }
    }
    
    func getAlongData(completion : @escaping ((ResponseType,[AlongData],[Assign]) -> ())){
        KPWebCall.call.getAlongWithData(param: paramDictAlong()) {[weak self] (json, statusCode) in
            guard let dictData = json as? NSDictionary, let weakSelf = self else {return}
            if statusCode == 200, let result = dictData["viewFormLabelOrder"] as? [NSDictionary]{
                for data in result{
                    let objData = Assign(dict: data)
                    let valueData = Values(name: objData.value, id: objData.value_id, manageId: objData.manage_form_id, varName: objData.variable_name)
                    weakSelf.objValues = valueData
                }
                for (index, _) in weakSelf.objValues.arrValueStr.enumerated() {
                    let objData = AlongData(name: weakSelf.objValues.arrNameStr[index], id: weakSelf.objValues.arrValueStr[index])
                    objData.variableName = weakSelf.objValues.variableName
                    weakSelf.arrAlongData.append(objData)
                }
                completion(.success,weakSelf.arrAlongData,weakSelf.arrAssignData)
            }else{
                completion(.error, [], [])
            }
        }
    }
    
    func getCancelVisit(completion : @escaping ((ResponseType) -> ())){
        KPWebCall.call.getCancelVisit(param: paramCancelVisit()) {(json, statusCode) in
            guard let _ = json as? NSDictionary else {return}
            if statusCode == 200{
                completion(.success)
            }else{
                completion(.error)
            }
        }
    }
    
    func reschedualVisit(completion : @escaping ((ResponseType, String) -> ())){
        KPWebCall.call.submitReschedualVisit(param: paramSubmitVisitDict()) { (json, statusCode) in
            guard let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                if let status = dict["status"] as? String{
                    completion(.success, status)
                }
            }else{
                completion(.error, "")
            }
        }
    }
}
