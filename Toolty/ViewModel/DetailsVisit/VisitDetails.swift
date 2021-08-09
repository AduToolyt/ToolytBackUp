//
//  VisitDetails.swift
//  Toolty
//
//  Created by Chirag Patel on 22/07/21.
//

import UIKit

class VisitData: NSObject {
    var arrVisitData : [VisitDetails] = []
    var objVisit : Visit!
    
    func paramDict() -> [String : Any]{
        var dict : [String: Any] = [:]
        dict["visit_id"] = objVisit.id
        dict["visit_status"] = objVisit.visitStatus
        dict["company_id"] = _user.companyId
        dict["customer_id"] = objVisit.customerID
        dict["schuled_or_not"] = objVisit.schuledOrNot
        dict["update_missed_visit"] = objVisit.updateMissedVisit
        dict["user_id"] = _user.id
        return dict
    }
}

extension VisitData{
    func getVisitData(completion : @escaping (ResponseType, [VisitDetails]) -> ()){
        KPWebCall.call.getVisitData(param: paramDict()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200 {
                if let arrDict = dict["viewFormLabelOrder"] as? [NSDictionary]{
                    for data in arrDict{
                        let objData = VisitDetails(dict: data)
                        weakSelf.arrVisitData.append(objData)
                    }
                }
                completion(.success,weakSelf.arrVisitData)
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error,[])
            }
        }
    }
}
