//
//  userFilterData.swift
//  Toolty
//
//  Created by Suraj on 15/07/21.
//

import Foundation


class userFilterData:NSObject{
    var objHome : UserFilter!
    
    func paramDict() -> [String: Any]{
        var dict : [String: Any] = [:]
        dict["team_ids"] = ""
        dict["global_region_ids"] = ""
        dict["filter_page"] = "overview"
        dict["user_id"] = _user.id//"27"
        dict["company_id"] = _user.companyId //"16"
        dict["zone_ids"] = ""
        return dict
    }
}

extension userFilterData{
    func getuserFilter(completion : @escaping (ResponseType, UserFilter?) -> ()){
        KPWebCall.call.getUserFilterData(param: paramDict()) {[weak self] (json, statusCode) in
            
            guard let dict = json as? NSDictionary, let weakSelf = self else {return}
            
            if statusCode == 200, let responseDict = dict["userList"] as? [NSDictionary] {
                for dictData in responseDict {
                    _userList = UserList.addUpdateEntity(key: "id", value: dictData.getStringValue(key: "id"))
                    _userList.initWith(dict: dictData)
                    _appDelegator.saveContext()
                }
                
                _userList.values = responseDict as NSArray
                _appDelegator.saveContext()

                weakSelf.objHome = UserFilter(dict: dict)
                completion(.success,weakSelf.objHome)
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error,nil)
            }
        }
    }
}
