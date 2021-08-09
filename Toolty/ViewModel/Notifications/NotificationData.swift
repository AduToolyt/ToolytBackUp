//
//  NotificationData.swift
//  Toolty
//
//  Created by Chirag Patel on 12/07/21.
//

import UIKit

class NotificationData: NSObject {
    
    var loadMore = LoadMore ()
    var objNotidetails : Notifications!
    var arrNotiData : [NotificationList] = []
    var refresh  = UIRefreshControl()
    
    
    func paramNotiDict() -> [String: Any]{
        var dict : [String : Any] = [:]
        dict["page_number"] = loadMore.index
        dict["user_id"] = _user.id
        dict["company_id"] = _user.companyId
        dict["no_of_data_in_page"] = loadMore.limit
        return dict
    }
    
}

//MARK:- Get Notification WebCall Methods
extension NotificationData{
    func getNotification(completion : @escaping (ResponseType,Notifications?,[NotificationList]) -> ()){
        KPWebCall.call.getNotificationsData(param: paramNotiDict()) {[weak self] (json, statusCode) in
            guard let weakSelf = self, let dict = json as? NSDictionary else{return}
            if statusCode == 200{
                weakSelf.objNotidetails = Notifications(dict: dict)
                if let arrDict = dict["notifications"] as? [NSDictionary]{
                    for data in arrDict{
                        let dictData = NotificationList(dict: data)
                        weakSelf.arrNotiData.append(dictData)
                    }
                }
                completion(.success,weakSelf.objNotidetails,weakSelf.arrNotiData)
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error,nil,[])
            }
        }
    }
    
    func readNotification(param: [String: Any], completion: @escaping (ResponseType) -> ()){
        KPWebCall.call.notificationMarkRead(param: param) { (json, statusCode) in
            guard let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                completion(.success)
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error)
            }
        }
    }
    
    func markAsReadAllNoti(completion: @escaping(ResponseType) -> ()){
        KPWebCall.call.readAllNotification(param: ["team_lead_id": _user.id, "company_id": _user.companyId]) { (json, statusCode) in
            guard let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                completion(.success)
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error)
            }
        }
    }
}
