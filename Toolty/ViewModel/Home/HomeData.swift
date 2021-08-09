//
//  HomeData.swift
//  Toolty
//
//  Created by Devang Lakhani  on 7/9/21.
//

import Foundation
import UIKit

class HomeData: NSObject{
    var objHome : Home!
    var count : Int = 0
    var status : Int = 0
    var uID = String()
    
    var timeZoneOffset : String{
        let timeZone = TimeZone.current.secondsFromGMT()
        return "\(timeZone)"
    }
    
    
    func paramDict() -> [String: Any]{
        var dict : [String: Any] = [:]
            dict["team_lead_id"] = _user.id
            dict["user_id"] = uID
            dict["company_id"] = _user.companyId
            dict["user_timezone_app_offset"] = timeZoneOffset
        return dict
    }
    
    func paramUnreadCount() -> [String : Any]{
        var dict : [String: Any] = [:]
        dict["company_id"] = _user.companyId
        dict["team_lead_id"] = _user.id
        return dict
    }
}
//MARK:- AppOverview WebCall Method
extension HomeData{
    func getOverview(completion : @escaping (ResponseType, Home?) -> ()){
        KPWebCall.call.homeOverviewData(param: paramDict()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                weakSelf.objHome = Home(dict: dict)
                completion(.success,weakSelf.objHome)
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error,nil)
            }
        }
    }
    
    func getUnreadNotiCount(completion : @escaping (ResponseType, Int,Int) -> ()){
        KPWebCall.call.getUnreadCount(param: paramUnreadCount()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                if let status = dict["status"] as? Int, let unreadCount = dict["unreadNotifiationCount"] as? Int{
                    weakSelf.status = status
                    weakSelf.count = unreadCount
                }
                completion(.success,weakSelf.status,weakSelf.count)
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error,weakSelf.status,weakSelf.count)
            }
        }
    }
    
    func manuList() -> [MenuList]{
        var objMenu : [MenuList] = []
        objMenu.append(contentsOf: [MenuList(name: "Today"),MenuList(name: "Insights")])
        
        let arrLabel = _labels.values as! [NSDictionary]
        if let status = arrLabel.map({$0.value(forKey: "module_status")}) as? [Int], let name = arrLabel.map({$0.value(forKey: "module_name")}) as? [String]{
            if status.contains(2) && name.contains("Leader Board"){
                objMenu.append(MenuList(name: "LeaderBoard"))
            }
        }
        
        if _privilege.goal_view == 1{
            objMenu.append(MenuList(name: "Goal"))
        }
        return objMenu
    }
}
